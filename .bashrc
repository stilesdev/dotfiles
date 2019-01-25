#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lAh'
PS1='[\u@\h \W]\$ '

export TERMINAL=/usr/bin/urxvt

export GPG_TTY=`tty`
export SSH_AUTH_SOCK=/run/user/$(id -u)/gnupg/S.gpg-agent.ssh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
