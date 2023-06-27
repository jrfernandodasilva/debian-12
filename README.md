# Debian 12

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
echo "deb https://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

deb https://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware

deb https://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware

deb https://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware
"| sudo tee /etc/apt/sources.list > /dev/null && sudo apt update && apt list --upgradable && sudo apt upgrade
```

## 3. Install Firmware Wifi (if necessary)

Run this commands to see Wifi network infos
```bash
lspci
lsusb
```
Assuming the wireless card is "Atheros", run this command:
```bash
sudo apt install firmware-atheros
```
and reboot your system.

## 4. Install NVIDIA drivers

1. Install the [nvidia-driver](https://packages.debian.org/search?keywords=nvidia-driver) package, plus the necessary firmware:
```bash
sudo apt install nvidia-driver firmware-misc-nonfree
```
DKMS will build the nvidia module for your system, via the [nvidia-kernel-dkms](https://packages.debian.org/nvidia-kernel-dkms) package.
* _Note about Secureboot:_ if you have [SecureBoot](https://wiki.debian.org/SecureBoot) enabled, you need to sign the resulting modules. Detailed instructions are available [here](https://wiki.debian.org/SecureBoot#Using_your_key_to_sign_modules).

2. **Restart** your system to load the new driver.

Links:
- [Desktop Drivers](https://wiki.debian.org/NvidiaGraphicsDrivers#Desktop_Drivers)
- [Bookworm-525](https://wiki.debian.org/NvidiaGraphicsDrivers#bookworm-525)

## 5. Install programs
```bash
sudo apt install -y terminator htop apache2 xclip snapd chromium
```

## 6. Install VPN Plugin
```bash
sudo apt install openvpn
sudo apt install network-manager-openvpn
```

## 7. Git install and configs

### Install Git, Git Flow and Gitk
```bash
sudo apt install -y git git-flow gitk
```

### Configure your Git username/email globally
```bash
git config --global user.name "FIRST_NAME LAST_NAME"
git config --global user.email "MY_NAME@example.com"
```

### Enable multiples hotfix globally
```bash
git config --global gitflow.multi-hotfix true
```

### Disable TAG on finish hotfix globally
```bash
git config --global gitflow.hotfix.finish.notag true
```

### Disable automatic conversion of line endings
```bash
cd /var/www
git config --global core.autocrlf false
```

## 8. Enable syntax highlighting in nano
```bash
find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; >> ~/.nanorc
```

## 9. Complementary softwares
- Docker + Docker Compose - [Install instructions](https://docs.docker.com/engine/install/debian/#set-up-the-repository) - [Post install instructions](https://docs.docker.com/engine/install/linux-postinstall/)
- VSCode - [Download page](https://code.visualstudio.com/download)
- Discord - [Home to download](https://discord.com)
- Skype - [Download page](https://www.skype.com/pt-br/get-skype/)
- Chrome - [Home to download](https://www.google.com/intl/pt-BR/chrome/)
- MySQL Workbench via snapd - [2 ways to Install Mysql Workbench](https://linux.how2shout.com/2-ways-to-install-mysql-workbench-on-debian-11-bullseye-linux/#5_To_Uninstall_run)

## 10. Chrome Flags
Access chrome flags with this url [chrome://flags/](chrome://flags/) and enable this:
- GPU rasterization
- Overscroll history navigation
- Preferred Ozone platform (set `Wayland`)
![image](https://github.com/jrfernandodasilva/debian-12/assets/27747005/077bdec7-3bc2-41cd-96d5-df7f6a06df30)

Run this commant to force enable `Overscroll history navigation`:
```bash
sudo sed -ie 's/Exec=\/usr\/bin\/google-chrome-stable %U/Exec=\/usr\/bin\/google-chrome-stable %U --enable-features=TouchpadOverscrollHistoryNavigation/g' /usr/share/applications/google-chrome.desktop
```
> then restart Chrome browser to enable this config

## 11. ZSH and Oh My Zsh

### Install ZSH
```bash
sudo apt install zsh -y
```
### ZSH Autocomplete
```bash
zsh
autoload -Uz compinit
compinit
_comp_options+=(globdots)
```

### Set as default system interpreter commands
```bash
chsh -s $(which zsh)
```

>To rollback `chsh -s /bin/bash`

Then close and reopen terminal to apply changes.

### Install Oh My Zsh 
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Oh My Zsh - Plugins
Oh My Zsh plugins make it possible to add extra functionality to your shell. There are numerous existing plugins, to check all the possibilities, take a look at the [repository Wiki](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins). Check out some of these special plugins below.

#### Plugin zsh-syntax-highlighting
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

#### Plugin zsh-autosuggestions
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

#### Plugin fzf
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
```

#### Enable plugins

```bash
nano ~/.zshrc
```

and edit `plugins` to this:
```bash
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  fzf
)
````

#### Install fonts by script:
```bash
cd /tmp
curl -LO https://raw.githubusercontent.com/jrfernandodasilva/debian-12/main/oh-my-zsh.sh
chmod +x oh-my-zsh.sh 
 ./oh-my-zsh.sh  
```

#### Install Powerlevel10k Theme
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k 
````

#### Chante Theme

```bash
nano ~/.zshrc
```

Find `ZSH_THEME="robbyrussell"` and change to:
```bash
ZSH_THEME="powerlevel10k/powerlevel10k"

#powerlevel19k configuration
POWERLEVEL9K_MODE='awesome-fontconfig'
````

Then run:
```bash
source ~/.zshrc
```

to load new config.

#### See

- [.zshrc](https://github.com/jrfernandodasilva/debian-12/blob/main/.zshrc) file example
- [.p10k.zsh](https://github.com/jrfernandodasilva/debian-12/blob/main/.p10k.zsh) file example
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) repository
- [Medium Tutorial](https://medium.com/opensanca/personalizando-o-terminal-com-powerlevel10k-6c2609360a55)
- [Config files](https://gist.github.com/andrelugomes/29096774a35c7d9d4d787e1583aaafad#file-p10k-zsh) example
- [Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)
  
## 12. Install nvm

See repository instructions to install: [https://github.com/nvm-sh/nvm](https://github.com/nvm-sh/nvm)
