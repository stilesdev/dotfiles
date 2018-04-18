#!/usr/bin/env bash
set -x
dir=$(pwd)

source "${dir}/utils.sh"

link_file() {
	local relPath=$1
	local linkPath=$HOME/$relPath
	local linkTarget=$dir/$relPath
	
	if [[ $2 ]]; then
		linkTarget=$2
	fi

	ln -sfb -S .original "$linkTarget" "$linkPath"
}

if ask "Install symlink for .bashrc and .profile?" Y; then
	link_file ".bashrc"
	link_file ".profile"
fi

if ask "Install symlinks for i3 files?" Y; then
	mkdir -p $HOME/.config/i3
	mkdir -p $HOME/Scripts
	link_file ".config/i3/config"
	link_file ".config/i3/i3blocks.conf"
	link_file "Scripts/toggle-touchpad.sh"
	chmod u+x $dir/Scripts/toggle-touchpad.sh
	link_file "Scripts/lock.sh"
	chmod u+x $dir/Scripts/lock.sh
	link_file "Scripts/lock-icon.png"
fi

if [ -e $HOME/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox ]; then
	if ask "Install symlink to ~/.local/bin for JetBrains Toolbox?" Y; then
		mkdir -p $HOME/.local/bin
		link_file ".local/bin/jetbrains-toolbox" "$HOME/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox"
	fi
fi

if [ -e /opt/pia/run.sh ]; then
	if ask "Install symlink to ~/.local/bin for PrivateInternetAccess?" Y; then
		mkdir -p $HOME/.local/bin
		link_file ".local/bin/pia" "/opt/pia/run.sh"
	fi
fi
