#!/usr/bin/env bash

set -x
dir=$(pwd)

source "${dir}/utils.sh"

uninstall() {
	if [ -e ${HOME}/.bashrc.original ]; then
		mv ${HOME}/.bashrc.original ${HOME}/.bashrc
	fi
	
	if [ -e ${HOME}/.profile.original ]; then
		mv ${HOME}/.profile.original ${HOME}/.profile
	fi
	
	if [ -e ${HOME}/.config/i3/config.original ]; then
		mv ${HOME}/.config/i3/config.original ${HOME}/.config/i3/config
	fi
	
	if [ -e ${HOME}/.config/i3/i3blocks.conf.original ]; then
		mv ${HOME}/.config/i3/i3blocks.conf.original ${HOME}/.config/i3/i3blocks.conf
	fi
	
	if [ -e ${HOME}/Scripts/toggle-touchpad.sh.original ]; then
		mv ${HOME}/Scripts/toggle-touchpad.sh.original ${HOME}/Scripts/toggle-touchpad.sh
	fi
	
	if [ -e ${HOME}/Scripts/lock.sh.original ]; then
		mv ${HOME}/Scripts/lock.sh.original ${HOME}/Scripts/lock.sh
	fi
	
	if [ -e ${HOME}/Scripts/lock-icon.png.original ]; then
		mv ${HOME}/Scripts/lock-icon.png.original ${HOME}/Scripts/lock-icon.png
	fi
	
	if [ -e ${HOME}/.local/bin/jetbrains-toolbox.original ]; then
		mv ${HOME}/.local/bin/jetbrains-toolbox.original ${HOME}/.local/bin/jetbrains-toolbox
	fi
	
	if [ -e ${HOME}/.local/bin/pia.original ]; then
		mv ${HOME}/.local/bin/pia.original ${HOME}/.local/bin/pia
	fi
}

if ask "Restore all original files?" N; then
	uninstall
fi
