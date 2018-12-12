Dotfiles
========

A snapshot of my personal dotfiles, used to set up new Linux installations.


YubiKey GPG Setup
-----------------

```
sudo pacman -S git gnupg2 pinentry pcsclite ccid libusb-compat gcr
systemctl --user mask --now gpg-agent.service gpg-agent.socket gpg-agent-ssh.socket gpg-agent-extra.socket gpg-agent-browser.socket
systemctl enable pcscd
gpg --keyserver keys.gnupg.net --recv C0AC1B5B
```

Create `~/.gnupg/gpg-agent.conf` with the contents:
```
enable-ssh-support
pinentry-program /usr/bin/pinentry-gnome3
default-cache-ttl 60
max-cache-ttl 120
```

Insert YubiKey
```
gpg --card-status
gpg --edit-key C0AC1B5B
```

Enter `trust`, then `5` to trust the key ultimately, then finally `quit` to exit.

```
export GPG_TTY=`tty`
pkill ssh-agent
pkill gpg-agent
eval $(gpg-agent --daemon --enable-ssh-support --log-file ~/.gnupg/gpg-agent.log)
```

Manual installations
--------------------

* [PrivateInternetAccess](https://www.privateinternetaccess.com/installer/download_installer_linux)
```
tar -xzf pia*.tar.gz
./pia-*-installer-linux.sh
```

Automatic setup scripts
-----------------------
* Run `root-install.sh` as root to install packages and set up system-wide settings.
* Run `install.sh` to set up symlinks to config files for the current user.
* Run `uninstall.sh` to remove symlinks to this repo and restore original config files.
