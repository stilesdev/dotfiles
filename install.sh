#!/usr/bin/env bash

set -x
dir=$(pwd)

source "${dir}/utils.sh"

install() {
	if ask "Install symlink for .bashrc and .profile?" Y; then
		ln -sfb -S .original ${dir}/.bashrc ${HOME}/.bashrc
		ln -sfb -S .original ${dir}/.profile ${HOME}/.profile
	fi
	
	if ask "Install symlinks for i3 files?" Y; then
		mkdir -p ${HOME}/.config/i3
		ln -sfb -S .original ${dir}/.config/i3/config ${HOME}/.config/i3/config
		ln -sfb -S .original ${dir}/.config/i3/i3blocks.conf ${HOME}/.config/i3/i3blocks.conf
		mkdir -p ${HOME}/Scripts
		ln -sfb -S .original ${dir}/Scripts/toggle-touchpad.sh ${HOME}/Scripts/toggle-touchpad.sh
		ln -sfb -S .original ${dir}/Scripts/lock.sh ${HOME}/Scripts/lock.sh
		ln -sfb -S .original ${dir}/Scripts/lock-icon.png ${HOME}/Scripts/lock-icon.png
	fi
	
	if [ -e ${HOME}/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox ]; then
		if ask "Install symlink to ~/.local/bin for JetBrains Toolbox?" Y; then
			mkdir -p ${HOME}/.local/bin
			ln -sfb -S .original ${HOME}/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox ${HOME}/.local/bin/jetbrains-toolbox
		fi
	fi
	
	if [ -e /opt/pia/run.sh ]; then
		if ask "Install symlink to ~/.local/bin for PrivateInternetAccess?" Y; then
			mkdir -p ${HOME}/.local/bin
			ln -sfb -S .original /opt/pia/run.sh ${HOME}/.local/bin/pia
		fi
	fi
}

install
