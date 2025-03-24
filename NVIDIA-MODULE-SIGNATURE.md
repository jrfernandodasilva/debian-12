# Assinando o Módulo NVIDIA no Debian 12 com Secure Boot

Este guia descreve como assinar o módulo do driver NVIDIA no Debian 12 para que ele seja carregado corretamente em um sistema com Secure Boot ativado. O processo foi testado com o driver `nvidia-driver` versão 535.216.01 e o `kernel 6.1.0-32-amd64`.

## Pré-requisitos

-   Sistema Debian 12 instalado.
-   Pacote `nvidia-driver` instalado via repositórios Debian ou arquivo `.run` da NVIDIA.
-   Pacotes necessários: `dkms`, `linux-headers-$(uname -r)`, `mokutil`, e `openssl`.
-   Secure Boot ativado (verifique com `mokutil --sb-state`).

## Passos

### 1. Verifique o Secure Boot
Confirme que o Secure Boot está ativado:
```sh
mokutil --sb-state
```
Se o resultado for `SecureBoot enabled`, prossiga. Caso contrário, ative-o na BIOS/UEFI.
<hr/>

### 2. Instale os pacotes necessários
Certifique-se de que os pacotes essenciais estão instalados:
```sh
sudo apt update
sudo apt install dkms linux-headers-$(uname -r) mokutil openssl
```
<hr/>

### 3. Gere um par de chaves MOK (Machine Owner Key)
Crie uma chave privada e um certificado público para assinar os módulos:
```sh
sudo mkdir -p /root/mok
cd /root/mok
sudo openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -days 36500 -nodes -subj "/CN=NVIDIA Module Signing Key/"
```
-   `MOK.priv`: Chave privada.
-  `MOK.der`: Certificado público no formato DER.
-   `-nodes`: Sem senha (opcional; remova se desejar definir uma senha).
 Os arquivos serão criados em `/root/mok/`.
<hr/>

### 4. Localize os módulos NVIDIA
Os módulos compilados pelo DKMS estão em `/lib/modules/$(uname -r)/updates/dkms/`. Liste os arquivos:
```sh
ls -lh /lib/modules/$(uname -r)/updates/dkms/
```
Você verá arquivos como `nvidia.ko`, `nvidia-modeset.ko`, `nvidia-drm.ko`, etc. <br/>
No seu caso, se o `dkms status` mencionou `nvidia-current`, então pode ser `nvidia-current.ko`. Confirme o nome exato.
<hr/>

### 5. Assine os módulos NVIDIA
Use o script `sign-file` do kernel para assinar cada módulo. Defina o diretório dos cabeçalhos:
```sh
KBUILD_DIR=/usr/src/linux-headers-$(uname -r)
```
Assine os módulos (ajuste os nomes conforme o resultado do passo 4):
```sh
sudo $KBUILD_DIR/scripts/sign-file sha256 /root/mok/MOK.priv /root/mok/MOK.der /lib/modules/6.1.0-32-amd64/updates/dkms/nvidia.ko
sudo $KBUILD_DIR/scripts/sign-file sha256 /root/mok/MOK.priv /root/mok/MOK.der /lib/modules/6.1.0-32-amd64/updates/dkms/nvidia-modeset.ko
sudo $KBUILD_DIR/scripts/sign-file sha256 /root/mok/MOK.priv /root/mok/MOK.der /lib/modules/6.1.0-32-amd64/updates/dkms/nvidia-drm.ko
...
```
<hr/>

### 6. Atualize o initramfs
Inclua os módulos assinados no initramfs:
```sh
sudo update-initramfs -u
```
<hr/>

### 7. Inscreva a chave pública no MOK
Registre o certificado público (`MOK.der`) no MOK para que o kernel o aceite:
```sh
sudo mokutil --import /root/mok/MOK.der
```
-   Defina uma senha temporária quando solicitado (anote-a).
-   Reinicie o sistema:
```sh
sudo reboot
```
Durante o boot, o MokManager (uma tela azul) aparecerá:
-   Selecione **Enroll MOK**.
-   Escolha **Continue** e confirme.
-   Digite a senha definida.
-   Reinicie novamente quando solicitado.
<hr/>

### 8. Teste o carregamento do módulo
Após o reboot, carregue o módulo NVIDIA
```sh
sudo modprobe nvidia
```
Verifique os módulos carregados:
```sh
lsmod | grep nvidia
```
Teste o driver:
```sh
nvidia-smi
```
Se `nvidia-smi` exibir informações da GPU, o processo foi bem-sucedido.
<hr/>

## Solução de problemas
-   **Erro "Key was rejected by service"**: O Secure Boot rejeitou o módulo. Certifique-se de que ele foi assinado e a chave inscrita corretamente.
-   **Erro "Unknown symbol"**: O módulo pode não ser compatível com o kernel, verifique os logs:
```sh
sudo dmesg | grep -i nvidia
```
Caso necessário, reinstale o driver:
```sh
sudo apt purge nvidia-driver
sudo apt install nvidia-driver
```
**Módulo não encontrado**: Confirme o nome exato em `/lib/modules/$(uname -r)/updates/dkms/`.

## Opcional: Automatização com DKMS
Para evitar assinar manualmente após atualizações do kernel ou driver, configure o DKMS para usar sua chave automaticamente. Edite `/etc/dkms/framework.conf` e adicione:
```sh
mok_signing_key="/root/mok/MOK.priv"
mok_certificate="/root/mok/MOK.der"
```
Isso fará com que o DKMS assine os módulos automaticamente em futuras compilações.
Pronto! Se tudo correr bem, seu driver NVIDIA estará funcionando com o Secure Boot.

## Notas
-   Testado em: Debian 12, kernel `6.1.0-32-amd64`, driver NVIDIA `535.216.01`.
-   Data: Março de 2025 (baseado no contexto fornecido).
-   Autor: Adaptado de interações com Grok 3 (xAI).