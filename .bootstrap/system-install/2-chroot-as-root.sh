#!/usr/bin/env bash

HOSTNAME=''
DOMAIN=''
USERNAME=''

if [ -z "$HOSTNAME" ]; then
    echo "The HOSTNAME variable at the top of this script must be configured before running this script!"
    exit 1
fi
if [ -z "$DOMAIN" ]; then
    echo "The DOMAIN variable at the top of this script must be configured before running this script!"
    exit 1
fi
if [ -z "$USERNAME" ]; then
    echo "The USERNAME variable at the top of this script must be configured before running this script!"
    exit 1
fi

# Set the time zone and hardware clock
ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc

# Configure localization
sed -i "s/^\#\(en_US\.UTF\-8.*$\)/\1/" /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen

# Configure the hostname
echo "$HOSTNAME" > /etc/hostname

# Add matching entries to `/etc/hosts`
cat > /etc/hosts << EOF
127.0.0.1   localhost
::1         localhost
127.0.0.1   $HOSTNAME.$DOMAIN $HOSTNAME
EOF

# Use traditional interface names (eth0, wlan0, etc...)
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules

# Install wifi-menu dependencies (only needed if wifi-menu will be used to configure wireless connections on the installed system)
pacman -S dialog wpa_supplicant

# Install Intel microcode updates
pacman -Syu intel-ucode

# Set up boot manager
bootctl --path=/boot install

cat > /boot/loader/entries/arch.conf << EOF
title	Arch Linux
linux 	/vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=$(mount | grep "on / " | cut -s -d ' ' -f 1) rootfstype=ext4 rw add_efi_memmap
EOF

cat > /boot/loader/loader.conf << EOF
default arch
timeout 1
editor 1
EOF

# Set root password
passwd

# Grant sudo priviledges to the 'wheel' group
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers.d/10-install

# Create a user account with sudo priviledges
useradd -m -G wheel "$USERNAME"
pa/sswd "$USERNAME"
