#!/usr/bin/env bash

set -x
dir=$(pwd)
euid=$(id -u)
packages="vim i3 arandr lxappearance thunar gnome-icon-theme-full rofi compton i3blocks xbacklight scrot curl jq"

source "${dir}/utils.sh"

if [ $euid -ne 0 ]; then
	echo "This script must be run as root"
	exit 1
fi

if ask "Install Spotify?" Y; then
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
	echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list
	packages="${packages} spotify-client"
fi

if ask "Install Google Chrome?" Y; then
	curl -L https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
	echo deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main | tee /etc/apt/sources.list.d/google.list
	packages="${packages} google-chrome-stable"
fi

if ask "Install all .deb files in ${dir}/debfiles?" N; then
	packages="${packages} ${dir}/debfiles/*.deb"
fi

if ask "Run Synergy on startup?" Y; then
	read -p "Enter default IP/Hostname to connect to on startup: " REPLY </dev/tty
	cp ${dir}/etc/20-ubuntu.conf /etc/lightdm/lightdm.conf.d/20-ubuntu.conf
	echo $REPLY >> /etc/lightdm/lightdm.conf.d/20-ubuntu.conf
	chown root:root /etc/lightdm/lightdm.conf.d/20-ubuntu.conf
	chmod 644 /etc/lightdm/lightdm.conf.d/20-ubuntu.conf
fi

if ask "Disable apt HTTP Pipelining?" Y; then
	cp ${dir}/etc/99-disable-pipelining /etc/apt/apt.conf.d/99-disable-piplelining
	chown root:root /etc/apt/apt.conf.d/99-disable-piplelining
	chmod 644 /etc/apt/apt.conf.d/99-disable-piplelining
fi

if ask "Install video output switching script?" Y; then
	cp ${dir}/etc/90-video-output.rules /etc/udev/rules.d/90-video-output.rules
	chown root:root /etc/udev/rules.d/90-video-output.rules
	chmod 644 /etc/udev/rules.d/90-video-output.rules
	
	cp ${dir}/etc/video-output.sh /usr/local/bin/video-output.sh
	chown root:root /usr/local/bin/video-output.sh
	chmod 744 /usr/local/bin/video-output.sh
fi

if ask "Install touchpad settings?" Y; then
	cp ${dir}/etc/70-synaptics.conf /etc/X11/xorg.conf.d/70-synaptics.conf
	chown root:root /etc/X11/xorg.conf.d/70-synaptics.conf
	chmod 644 /etc/X11/xorg.conf.d/70-synaptics.conf
fi



udevadm control --reload
apt update
apt install -y $packages
