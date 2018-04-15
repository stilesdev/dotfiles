#!/usr/bin/env bash

set -x
dir=$(pwd)

source "${dir}/utils.sh"

uninstall() {
	if [ -e ${HOME}/.bashrc.original ]; then
		mv ${HOME}/.bashrc.original ${HOME}/.bashrc
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
}

if ask "Restore all original files?" N; then
	uninstall
fi
