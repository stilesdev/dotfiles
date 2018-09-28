#!/usr/bin/env bash

export GPG_TTY=`tty`
pkill ssh-agent
pkill gpg-agent
eval $(gpg-agent --daemon --enable-ssh-support --log-file ~/.gnupg/gpg-agent.log)
