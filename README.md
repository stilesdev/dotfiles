Dotfiles
========

A snapshot of my personal dotfiles, used to set up new Linux installations. Currently tested only on Ubuntu 16.04 LTS.


YubiKey GPG Setup
-----------------

```
sudo apt install git gnupg2 gnupg-agent pinentry-gnome3 scdaemon pcscd libusb-1.0.0-dev
alias gpg=gpg2
gpg --keyserver keys.gnupg.net --recv C0AC1B5B

** Insert YubiKey **

gpg --card-status
gpg --edit-key C0AC1B5B
```
Enter `trust`, then `5` to trust the key ultimately, then finally `quit` to exit.


Create `~/.gnupg/gpg-agent.conf` with the contents:
```
enable-ssh-support
pinentry-program /usr/bin/pinentry-gnome3
default-cache-ttl 60
max-cache-ttl 120
```
Add the following to the end of `~/.bashrc` and restart the terminal
```
export GPG_TTY=`tty`
pkill ssh-agent
pkill gpg-agent
eval $(gpg-agent --daemon --enable-ssh-support --log-file ~/.gnupg/gpg-agent.log)" >> ~/.bashrc
```


Manual .deb downloads
---------------------

Create a `debfiles` directory in the root of this repository once cloned, then download the .deb file for any of the following packages.

The root-install.sh script will prompt you to decide whether to install all .deb files in this directory.

* [Arc GTK Theme](https://github.com/horst3180/arc-theme/releases)
* [Moka/Faba/Faba Mono Icons](https://snwh.org/moka/download)
* [playerctl](https://github.com/acrisci/playerctl/releases)
* [Synergy](https://symless.com/synergy/downloads)


Manual installations
--------------------

* [PrivateInternetAccess](https://www.privateinternetaccess.com/installer/download_installer_linux)
```
tar -xzf pia*.tar.gz
./pia-*-installer-linux.sh
```

* [JetBrains Toolbox](https://www.jetbrains.com/toolbox/app/)
```
tar -xzf jetbrains-toolbox*.tar.gz
cd jetbrains-toolbox*
./jetbrains-toolbox
```


Fonts
-----

Extract .ttf or .otf files to `~/.fonts`.

* [Overpass](http://overpassfont.org/)
* [Source Code Pro](https://github.com/adobe-fonts/source-code-pro/releases)
* [Hasklig](https://github.com/i-tu/Hasklig/releases)
* [Fira Code](https://github.com/tonsky/FiraCode/releases)


Automatic setup scripts
-----------------------
* Run `root-install.sh` as root to install packages and set up system-wide settings.
* Run `install.sh` to set up symlinks to config files for the current user.
* Run `uninstall.sh` to remove symlinks to this repo and restore original config files.
