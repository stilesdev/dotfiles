#!/usr/bin/env bash

set -x
dir=$(pwd)

source "${dir}/utils.sh"

uninstall() {
	if [ -e ${HOME}/.bashrc.original ]; then
		mv ${HOME}/.bashrc.original ${HOME}/.bashrc
	fi
}

if ask "Restore all original files?" N; then
	uninstall
fi
