#!/usr/bin/env bash

set -x
dir=$(pwd)

source "${dir}/utils.sh"

unlink_file() {
	local relPath=$1
	local linkPath=$HOME/$relPath
	
	local actualLinkTarget=`readlink $linkPath`
	local expectedLinkTarget=$dir/$relPath
	
	if [[ $2 ]]; then
		expectedLinkTarget=$2
	fi

	if [ -L "$linkPath" ] && [ "$actualLinkTarget" = "$expectedLinkTarget" ]; then
		rm $linkPath
	fi
	
	if [ -e $linkPath.original ]; then
		mv $linkPath.original $linkPath
	fi
}

if ask "Restore all original files?" N; then
	unlink_file ".bashrc"
	unlink_file ".profile"
	unlink_file ".gitconfig"
	unlink_file ".config/i3/config"
	unlink_file ".config/i3/i3blocks.conf"
	unlink_file "Scripts/toggle-touchpad.sh"
	unlink_file "Scripts/lock.sh"
	unlink_file "Scripts/lock-icon.png"
	unlink_file ".config/gtk-3.0/settings.ini"
	unlink_file ".gtkrc-2.0"
	unlink_file ".local/bin/jetbrains-toolbox" "$HOME/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox"
	unlink_file ".local/bin/pia" "/opt/pia/run.sh"
	rm -rf $HOME/.nvm
fi
