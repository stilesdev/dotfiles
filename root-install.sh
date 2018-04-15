#!/usr/bin/env bash

set -x
dir=$(pwd)
euid=$(id -u)
packages="vim i3 arandr lxappearance thunar gnome-icon-theme-full rofi compton i3blocks xbacklight pactl"

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





apt update
apt install -y $packages