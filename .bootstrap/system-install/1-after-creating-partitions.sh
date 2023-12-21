#!/usr/bin/env bash

# Update the system clock
timedatectl set-ntp true
timedatectl status

# Download a current pacman mirror list
curl "https://archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on" | cut -c2- > /etc/pacman.d/mirrorlist

# Install base packages
pacstrap /mnt base base-devel linux linux-firmware dhcpcd inetutils man-db man-pages netctl openssh vim git

# Generate fstab file
genfstab -U /mnt >> /mnt/etc/fstab

echo "fstab generated for new system:"
cat /mnt/etc/fstab

echo "If this appears to be correct for your partition scheme, next run 'arch-chroot /mnt'" 

# Copy next script into place, to be run inside chroot
cp 2-chroot-as-root.sh /mnt/root
