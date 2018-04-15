#!/usr/bin/env bash

set -x
dir=$(pwd)

source "${dir}/utils.sh"

install() {
	if ask "Install symlink for .bashrc?" Y; then
		ln -sfb -S .original ${dir}/.bashrc ${HOME}/.bashrc
	fi
	
	if ask "Install symlinks for i3 files?" Y; then
		mkdir -p ${HOME}/.config/i3
		ln -sfb -S .original ${dir}/.config/i3/config ${HOME}/.config/i3/config
		ln -sfb -S .original ${dir}/.config/i3/i3blocks.conf ${HOME}/.config/i3/i3blocks.conf
		mkdir -p ${HOME}/Scripts
		ln -sfb -S .original ${dir}/Scripts/toggle-touchpad.sh ${HOME}/Scripts/toggle-touchpad.sh
	fi
}

install
