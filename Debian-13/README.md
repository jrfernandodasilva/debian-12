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
