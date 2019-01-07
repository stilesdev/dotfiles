# MSI GF63-8RD Gaming Laptop #
Installation instructions for dual-booting Windows 10 and Arch Linux on the MSI GF63-8RD gaming laptop.

## Windows Installation ##
It is typically easiest to install Windows 10 before Arch Linux when dual-booting.

This laptop utilizes a UEFI BIOS, so the following steps are tailored for UEFI systems.

### Preparing the boot media ###
Use Rufus to create a bootable USB flash drive with GPT partition scheme, for a UEFI target system. If prompted, choose to write the image in ISO mode.

Note: When reinstalling Windows 10 on a machine that came with Windows 10 preinstalled from the manufacturer, it will typically activate the new installation automatically, using the original edition of Windows 10 that came with the machine. To bypass this and show a prompt for selecting the edition to install during setup, create a file on the installation media at `\sources\ei.cfg` with the following contents:
```
[Channel]
Retail
```

Proceed to install Windows 10 as usual, but remember to leave unpartitioned space on the boot drive for Arch Linux to be installed to later.

### Post-install setup ###
Once installed and booted into Windows 10, install base drivers and Windows Updates.

To prevent disk corruption when switching to Arch later on, disable fast boot before proceeding. Right-click on the battery/power tray icon and select 'Power Settings'. Select 'Choose what the power buttons do' in the sidebar, click 'Change settings that are currently unavailable', and uncheck 'Turn on fast startup (recommended)'.

Since Linux sets the hardware clock in UTC time, Windows needs to be configured to do the same. Using regedit, create a new DWORD entry at `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation\RealTimeIsUniversal` with a hexadecimal value of 1.

## Arch Linux Installation ##
Once Windows 10 has been installed, Arch Linux will then be installed on the remaining unpartitioned space on the drive.

### Booting the Arch installer media ###
Use Rufus to create a bootable USB flash drive with GPT partition scheme, for a UEFI target system. If prompted, choose to write the image in dd mode.

Connect the machine to the network via ethernet cable for easiest setup. DHCP will be enabled on wired connections by default when booted into the live media.

Boot the system from the flash drive. On the boot manager screen, press `e` with the Arch Linux entry selected to edit the kernel parameters, and add `pcie_aspm=off nouveau.modeset=0` to the end of the string. Press enter to continue booting with the entered options.

Once booted, check that the system is booted in UEFI mode using `ls /sys/firmware/efi/efivars`

Also verify internet connectivity by pinging any site.

### Update the system clock ###
```
timedatectl set-ntp true
timedatectl status
```

### Partition the remaining space on the disk ###
Display detected drives using `fdisk -l`.

With an NVME boot drive, the disk will be listed as `/dev/nvme0n1`.

Windows creates 4 partitions when installed on a UEFI system:
```
/dev/nvme0n1p1  Windows recovery environment
/dev/nvme0n1p2  EFI System
/dev/nvme0n1p3  Microsoft reserved
/dev/nvme0n1p4  Microsoft basic data
```

The simplest method for installing Arch uses just one additional partition for `/`, which will be created as `/dev/nvme0n1p5`. There is no need to create a separate boot partition, as Arch will use the same EFI partition created by Windows for this purpose.
```
fdisk /dev/nvme0n1
```
Enter `n` to create a new partition, then choose defaults to fill the remaining space on the drive.

Enter `t` to change the partition type, then enter `24` to set the new partition to the `Linux Root (x86-64)` partition type.

Enter `w` to write changes to the disk and exit.

### Format the new partition ###
```
mkfs.ext4 /dev/nvme0n1p5
```

### Mount the root and EFI partitions ###
```
mount /dev/nvme0n1p5 /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p2 /mnt/boot
```

### Download an updated pacman mirror list ###
```
curl "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on" | cut -c2- > /etc/pacman.d/mirrorlist
```

### Install base packages ###
```
pacstrap /mnt base base-devel vim git
```

### Generate fstab file ###
```
genfstab -U /mnt >> /mnt/etc/fstab
```
Verify the resulting file is correct.

### Chroot into the new system ###
```
arch-chroot /mnt
```

### Set the time zone and hardware clock ###
```
ln -sf /usr/share/zoneinfo/US/Eastern /etc/localtime
hwclock --systohc
```

### Configure localization ###
Edit `/etc/locale.gen` and uncomment the line containing `en_US.UTF-8 UTF-8`
```
locale-gen
```
Edit `/etc/locale.conf` and enter `LANG=en_US.UTF-8`

### Configure hostname ###
Edit `/etc/hostname` and enter the system's hostname.

Add matching entries to `/etc/hosts`
```
127.0.0.1   localhost
::1         localhost
127.0.0.1   <hostname>.<domain>     <hostname>
```

### Use traditional interface names (eth0, wlan0, etc...) ###
```
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
```

### Set up networking ###
Copy one of the example files from `/etc/netctl/examples` to `/etc/netctl` and modify it as needed.
```
systemctl enable dhcpcd.service
netctl enable <profile>
```

### Set root password
```
passwd
```

### Enable 32-bit packages ###
Edit `/etc/pacman.conf` and uncomment the `multilib` section.

### Install Intel microcode updates ###
```
pacman -S intel-ucode
```

### Set up boot manager (systemd-boot) ###
```
bootctl --path=/boot install
```
Edit `/boot/loader/entries/arch.conf` to create a new loader entry for Arch, with the following contents:
```
title	Arch Linux
linux 	/vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=/dev/nvme0n1p5 rootfstype=ext4 pcie_aspm=off nouveau.modeset=0 iwlwifi.11n_disable=1 iwlwifi.swcrypto=1 rw add_efi_memmap
```
Edit `/boot/loader/loader.conf` with the following contents:
```
default arch
timeout 3
editor 1
```

### Reboot into the installed system ###
```
exit
umount -R /mnt
reboot
```
If the BIOS boot order is configured correctly, you should be presented with the systemd-boot screen for 3 seconds after POST, with options to boot into either Arch Linux or Windows 10.