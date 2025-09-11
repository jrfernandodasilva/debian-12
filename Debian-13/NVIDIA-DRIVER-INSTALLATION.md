# Instalação dos Drivers Proprietários NVIDIA no Debian 13 "Trixie"

Este guia descreve os passos para instalar os drivers proprietários mais recentes da NVIDIA no Debian 13 "Trixie". Certifique-se de verificar a versão mais recente do driver para sua placa de vídeo NVIDIA em: [https://www.nvidia.com/pt-br/drivers](https://www.nvidia.com/pt-br/drivers).

## Passos

1. **Acessar o terminal TTY**  
   Abra o terminal TTY com o comando:  
   ```
   Ctrl + Alt + F4
   ```  
   Faça login com seu usuário e alterne para o modo root:  
   ```sh
   sudo -i
   ```

2. **Instalar o extrepo**  
   Instale o pacote `extrepo` para gerenciar repositórios externos:  
   ```sh
   apt install extrepo
   ```

3. **Atualizar a lista de repositórios**  
   Atualize a lista de repositórios disponíveis:  
   ```sh
   extrepo update
   ```

4. **Pesquisar repositórios NVIDIA**  
   Busque repositórios relacionados à NVIDIA:  
   ```sh
   extrepo search nvidia | less
   ```

5. **Habilitar o repositório nvidia-cuda**  
   Ative o repositório `nvidia-cuda`:  
   ```sh
   extrepo enable nvidia-cuda
   ```

6. **Atualizar pacotes disponíveis**  
   Atualize a lista de pacotes:  
   ```sh
   apt update
   ```

7. **Instalar pacotes necessários**  
   Instale os pacotes essenciais para compilação e suporte aos drivers:  
   ```sh
   apt install build-essential linux-headers-amd64 dkms
   ```

8. **Instalar os drivers NVIDIA**  
   Instale o pacote do driver NVIDIA (exemplo: versão 580):  
   ```sh
   apt install nvidia-open-580
   ```

9. **Instalar o utilitário MOK e configurar a chave**  
   Instale o `mokutil` e importe a chave MOK para o Secure Boot:  
   ```sh
   apt install mokutil
   mokutil -i /var/lib/dkms/mok.pub
   ```  
   Digite a senha solicitada e confirme.

10. **Reiniciar o sistema**  
    Reinicie o sistema para prosseguir com a configuração do MOK:  
    ```sh
    reboot
    ```

11. **Configurar o MOK na inicialização**  
    Após reiniciar, siga os passos no menu de inicialização:  
    1. Pressione qualquer tecla para acessar o menu.  
    2. Selecione **Enroll MOK**.  
    3. Escolha **Continue**.  
    4. Selecione **Yes**.  
    5. Digite a senha definida anteriormente.  
    6. Selecione **Reboot** para reiniciar novamente.

12. **Verificar o Secure Boot na BIOS**  
    Acesse a BIOS/UEFI do sistema e verifique se o **Secure Boot** está habilitado. Caso não esteja, ative-o e salve as alterações.

## Conclusão  
Os drivers NVIDIA foram instalados e configurados com sucesso. O sistema está pronto para uso com suporte à sua placa de vídeo NVIDIA.

## Fontes  
- [Vídeo no YouTube](https://www.youtube.com/watch?v=FaDENzwkzys)  
- [Documentação oficial do Debian](https://wiki.debian.org/NvidiaGraphicsDrivers#Debian_13_.22Trixie.22)