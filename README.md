# Dotfiles #
A current snapshot of my personal dotfiles from Arch Linux, managed with [YADM](https://thelocehiliosan.github.io/yadm/).

If you are looking to use any part of these configurations, I highly recommend only copying the files or lines that you need. If cloned directly with yadm, the bootstrap script should *mostly* work on any Arch system, but will at least fail to configure GPG without my Yubikey connected to the system.

This is mostly here for my reference, but also available publicly for others who may be curious how I have configured my system. As such, I will be providing no warranty or support with the use of these configurations.

## Installation Instructions ##
Note: Make sure Yubikey is plugged in for later GPG configuration.

### Install yay AUR helper ###
```
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### Install yadm (Yet Another Dotfiles Manager) ###
```
yay -S yadm
```

### Clone this dotfiles repository (automatically runs bootstrap script) ###
```
yadm clone https://github.com/mstiles92/dotfiles.git --bootstrap
```

## Manual Installations ##

* [PrivateInternetAccess](https://www.privateinternetaccess.com/installer/download_installer_linux)
```
tar -xzf pia*.tar.gz
./pia-*-installer-linux.sh
```