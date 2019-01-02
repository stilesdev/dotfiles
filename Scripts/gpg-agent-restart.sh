#!/usr/bin/env bash

pkill ssh-agent
pkill gpg-agent
while pgrep ssh-agent > /dev/null 2>&1; do sleep 0.1; done
while pgrep gpg-agent > /dev/null 2>&1; do sleep 0.1; done
eval $(gpg-agent --daemon --enable-ssh-support --log-file ~/.gnupg/gpg-agent.log)