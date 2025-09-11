# Debian 13

## 1. Add user to sudores
>save current user in a temp file and log as root user
```bash
echo "$USER" > /tmp/current_user.txt
su - 
```

>then execute this
```bash
ORIGINAL_USER=$(cat /tmp/current_user.txt)
sed -i "/^root.*ALL=(ALL:ALL) ALL$/a $ORIGINAL_USER ALL=(ALL) ALL" /etc/sudoers
rm /tmp/current_user.txt
exit
```

## 2. Update repositories
>update system repositories and run `update` and `upgrade`
```bash
echo "Types: deb deb-src
URIs: https://deb.debian.org/debian
Suites: trixie trixie-updates
Components: main contrib non-free non-free-firmware
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb deb-src
URIs: https://security.debian.org/debian-security
Suites: trixie-security
Components: main contrib non-free non-free-firmware
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
"| sudo tee /etc/apt/sources.list.d/debian.sources > /dev/null && sudo apt update && apt list --upgradable && sudo apt upgrade
```

## 3. Install NVIDIA driver
See [NVIDIA-DRIVER-INSTALLATION.md](https://github.com/jrfernandodasilva/debian-guide/blob/main/Debian-13/NVIDIA-DRIVER-INSTALLATION.md) document instructions.

## 4. Atualizar Firefox ESR

1. **Baixar o Firefox ESR**  
   Acesse [https://www.firefox.com/pt-BR/download/all/desktop-esr/](https://www.firefox.com/pt-BR/download/all/desktop-esr/), selecione "Português (Brasil)" e baixe o arquivo `.tar.bz2` para Linux 64 bits.

2. **Descomprimir e substituir**  
   Extraia o arquivo e substitua a pasta `/lib/firefox-esr`:  
   ```sh
   cd ~/Downloads
   tar -xjf firefox-*.tar.bz2
   sudo rm -rf /lib/firefox-esr
   sudo mv firefox /lib/firefox-esr
   ```

3. **Criar atalho**  
   Crie um link simbólico `firefox-esr` para `firefox`:  
   ```sh
   cd /lib/firefox-esr
   sudo ln -s firefox firefox-esr
   sudo ln -s /usr/share/firefox-esr/distribution distribution
   ```

4. **Verificar**  
   Teste a instalação:  
   ```sh
   firefox-esr --version
   ```

## Conclusão  
O Firefox ESR foi atualizado em `/lib/firefox-esr` e pode ser iniciado com o comando `firefox`.

## Fontes  
- [Download do Firefox ESR](https://www.firefox.com/pt-BR/download/all/desktop-esr/)