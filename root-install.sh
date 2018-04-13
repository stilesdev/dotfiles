#!/usr/bin/env bash

set -x
dir=$(pwd)
euid=$(id -u)

source "${dir}/utils.sh"

add_repos() {
	# Spotify
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	
	# Update packages
	apt update
}

install_packages() {
	apt install spotify-client
}

if [ $euid -ne 0 ]; then
	echo "This script must be run as root"
	exit 1
fi

add_repos
install_packages
