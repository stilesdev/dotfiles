# Dotfiles #
A current snapshot of my personal dotfiles from Arch Linux.

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
yadm clone https://github.com/mstiles92/dotfiles.git
```

## Manual Installations ##

* [PrivateInternetAccess](https://www.privateinternetaccess.com/installer/download_installer_linux)
```
tar -xzf pia*.tar.gz
./pia-*-installer-linux.sh
```