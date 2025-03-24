# Debian 12

[![License](https://img.shields.io/github/license/jrfernandodasilva/debian-12.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
[![Debian](https://img.shields.io/badge/Debian-A81D33?style=flat&logo=debian&logoColor=white)](https://www.debian.org/)
[![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat&logo=linux&logoColor=white)](https://www.linux.org/)
[![Shell](https://img.shields.io/badge/Shell-5391FE?style=flat&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Downloads](https://img.shields.io/github/downloads/jrfernandodasilva/golang-roadmap/total.svg?v1)](https://github.com/jrfernandodasilva/golang-roadmap/releases)
[![Contributors](https://img.shields.io/github/contributors/jrfernandodasilva/debian-12.svg)](https://github.com/jrfernandodasilva/debian-12/graphs/contributors)
[![Documentation](https://img.shields.io/badge/docs-latest-blue.svg)](https://github.com/jrfernandodasilva/debian-12/wiki)
[![Last Update](https://img.shields.io/github/last-commit/jrfernandodasilva/debian-12.svg)](https://github.com/jrfernandodasilva/debian-12/commits/main)

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
* _Note about Secureboot:_ if you have [SecureBoot](https://wiki.debian.org/SecureBoot) enabled, you need to sign the resulting modules. 
  - Detailed instructions are available on Debian doc: [Using_your_key_to_sign_modules](https://wiki.debian.org/SecureBoot#Using_your_key_to_sign_modules).
  - Or see [NVIDIA-MODULE-SIGNATURE.md](https://github.com/jrfernandodasilva/debian-12/blob/main/NVIDIA-MODULE-SIGNATURE.md) document instructions.

2. **Restart** your system to load the new driver.

Links:
- [Desktop Drivers](https://wiki.debian.org/NvidiaGraphicsDrivers#Desktop_Drivers)
- [Bookworm-525](https://wiki.debian.org/NvidiaGraphicsDrivers#bookworm-525)

## 5. Install programs
```bash
sudo apt install -y terminator htop xclip snapd chromium flameshot pngquant curl wget tree deluge
```

### 5.1 Terminator Themes
See instructions: https://github.com/EliverLara/terminator-themes

### 5.2 Gnome extension manager + extensions
Install Extension Manager:
```bash
sudo apt install gnome-shell-extension-manager
```
Open Extension Manager -> Browser. <br/>
Search and install:
- Blur my Shell
- Clipboard Indicator
- Coverflow Alt-Tab
- GNOME Fuzzy App Search
- Forge
- AppIndicator and KStatusNotifierItem Support
- Media Controls
- Dash to Dock  # similar OSx apps bar
    - Hide the dock in overview # can combine with "Dash to Dock" extension
- Dash to Panel # similar Windows system bar
    - App Icons Taskbar # can combine with "Dash to Panel" extension
    - ArcMenu # can combine with "Dash to Panel" extension
- V-Shell (Vertial Workspaces)
- User Themes
  > Download themes from Gnome Look, like: https://www.gnome-look.org/p/1687249 and follow install instructions <br/>
  > Dracula Theme for GTK full instructions: https://draculatheme.com/gtk
- Search Light 
  > _needs: sudo apt install imagemagick_

> Videos with extensions configs: <br/>
> https://www.youtube.com/watch?v=IedxEbwpjfs <br/>
> https://www.youtube.com/watch?v=AE1-W2bMVEs

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
- Pinta via snapd - [Install Pinta on Debian](https://snapcraft.io/install/pinta/debian)
- Postman via snapd - [Install Postman on Debian](https://snapcraft.io/install/postman/debian)
- kubectl - [Install and Set Up kubectl on Linux](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux)

### 9.1 Install bash-completion
```bash
sudo apt install bash-completion
```
#### Permanently enable
##### To bash:
```bash
echo "source <(kubectl completion bash)" >> ~/.bashrc
source ~/.bashrc
```

##### To Zsh:
```bash
echo "source <(kubectl completion zsh)" >> ~/.bashrc
source ~/.zshrc
```

## 10. Configure snap apps to show in xorg (If Necessary)
```bash
sudo ln -s /etc/profile.d/apps-bin-path.sh /etc/X11/Xsession.d/99snap
sudo nano /etc/login.defs

# Paste the following at the end of the file and save:
ENV_PATH PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

# Log out and log in again to your system
```
## 11. Install nvm

See repository instructions to install: [https://github.com/nvm-sh/nvm](https://github.com/nvm-sh/nvm)

## 12. Chrome Flags
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

## 13. ZSH and Oh My Zsh

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

#### Plugin zsh-completions
```bash
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
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
- [.p10k.zsh_v1](https://github.com/jrfernandodasilva/debian-12/blob/main/.p10k.zsh_v1) file example
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) repository
- [Medium Tutorial](https://medium.com/opensanca/personalizando-o-terminal-com-powerlevel10k-6c2609360a55)
- [Config files](https://gist.github.com/andrelugomes/29096774a35c7d9d4d787e1583aaafad#file-p10k-zsh) example
- [Plugins](https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins)

> .p10k.zsh <br/>
> ![image](https://github.com/user-attachments/assets/693d5fe3-9acf-4ab7-ba62-f55cb5cbe42b)

> .p10k.zsh_v1 <br/>
> ![image](https://github.com/user-attachments/assets/cca419dc-0489-4247-83b6-f84f27a7c77b)

## 14. Bash Aliases

Follow the instructions in [this repository](https://github.com/jrfernandodasilva/bash-aliases)

## 15. Emby

[See instructions here](https://emby.media/linux-server.html)

After install, run this command to add your system user to emby group:
```sh
sudo usermod -aG emby $USER 
```

## 16. Zram
[See instructions here](https://linuxdicasesuporte.blogspot.com/2022/03/zram-no-debian-gnu-linux-e-derivados.html) or [here](https://fosspost.org/enable-zram-on-linux-better-system-performance/)

## 17. Youtube Download (`yt-dlp`)

Download and install from [official repository](https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#installation)

The `yt-dlp` is an advanced CLI tool based on youtube-dl that allows you to download videos and audio from various platforms. Here are some useful combinations of options available:

#### Download Videos
1. **Specific quality:**
    - `-f bestvideo+bestaudio/best`: Downloads the best available video and audio, or the best combined format if the former is not available.
    - `-f 720p`: Downloads video in 720p, if available.

2. **Extract audio:**
    - `--extract-audio --audio-format mp3`: Extracts audio in MP3 format.
    - `--audio-quality 0`: Sets the audio quality (0 is the best quality).

3. **Playlist:**
    - `--yes-playlist`: Downloads all videos in the playlist.
    - `--playlist-start 10 --playlist-end 20`: Downloads videos from a specific position.

#### Output Settings
4. **Output Templates**:
    - `-o "%(title)s.%(ext)s"`: Sets the file name to the video title.
    - `-o "~/Downloads/%(uploader)s/%(title)s.%(ext)s"`: Saves files organized in folders based on the channel name.

5. **Prevent Duplicate Downloads**:
    - `--download-archive archive.txt`: Creates an archive to track previously downloaded videos and avoid duplication.

#### Integrations and Control

6. **Cookies and authentication**:
    - `--cookies-from-browser chrome`: Uses browser cookies to access restricted content.
    - `--username USER --password PASS`: Direct authentication.

7. **Video part manipulation (SponsorBlock)**:
    - `--sponsorblock-mark intro`: Marks intros using chapters.
    - `--sponsorblock-remove sponsor`: Removes specific parts as sponsors.

8. **Error resolution**:
    - `--ignore-errors`: Ignores errors and continues downloading.
    - `--retries infinite`: Retries downloading infinitely if there are failures.

These are just a few options. The `yt-dlp` offers a lot of flexibility and is highly configurable. <br/> 
For more details, you can refer to the [official documentation](https://github.com/yt-dlp/yt-dlp) and [related gists​](https://gist.github.com)

> Usage Example
> ```sh
> yt-dlp --audio-quality 0 --extract-audio --audio-format mp3 https://youtu.be/xxxxxx
> ```

### Links uteis
- [How to find notebook serial number](https://www.cyberciti.biz/faq/how-to-find-serial-number-of-lenovo-laptop-from-linux)
