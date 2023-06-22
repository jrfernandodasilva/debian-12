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

## 4. Install programs
```bash
sudo apt install -y terminator htop
```

## 5. Enable syntax highlighting in nano
```bash
find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; >> ~/.nanorc
```

## 6. Complementary softwares
- Docker + Docker Compose - [Install instructions](https://docs.docker.com/engine/install/debian/#set-up-the-repository) - [Post install instructions](https://docs.docker.com/engine/install/linux-postinstall/)
- VSCode - [Download page](https://code.visualstudio.com/download)
- Discord - [Home to download](https://discord.com)
- Skype - [Download page](https://www.skype.com/pt-br/get-skype/)
- Chrome - [Home to download](https://www.google.com/intl/pt-BR/chrome/)

## 7. Chrome Flags
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
