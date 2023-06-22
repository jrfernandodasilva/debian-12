# Debian 12

## Add user to sudores
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

## Update repositories
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

## Install programs
```bash
sudo apt install -y terminator htop
```
