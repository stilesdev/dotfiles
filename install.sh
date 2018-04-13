#!/usr/bin/env bash

set -x
dir=$(pwd)

source "${dir}/utils.sh"

install() {
	if ask "Install symlink for .bashrc?" Y; then
		ln -sfb -S .original ${dir}/.bashrc ${HOME}/.bashrc
	fi
}

install
