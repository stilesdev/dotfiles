# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory notify
unsetopt autocd beep nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/matthew/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

function powerline_precmd() {
    unset RPROMPT
    eval "$($GOPATH/bin/powerline-go -error $? -shell zsh -eval -hostname-only-if-ssh -modules nix-shell,venv,user,host,ssh,cwd,perms,jobs,exit,vgo -modules-right git)"

}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

export EDITOR=vim

alias ls='ls --color=auto'
alias ll='ls -lAh'
alias dc='docker-compose'

if which psql > /dev/null; then
    alias pg="psql -U postgre -d distributed -h localhost"
fi

if which autossh > /dev/null; then
    alias localtun='AUTOSSH_POLL=300 AUTOSSH_FIRST_POLL=10 AUTOSSH_GATETIME=5 autossh -M 20000 -N -p 2222 -R 8080:localhost:80 -R 8081:localhost:8081 tun.stiles.me'
fi

if [ -f '/opt/cisco/anyconnect/bin/vpn' ]; then
    alias vpn='/opt/cisco/anyconnect/bin/vpn'
fi

bindkey "^H" backward-delete-word     # Ctrl+Backspace
bindkey "^[[3~" delete-char           # Del
bindkey "^[[3;5~" delete-word         # Ctrl+Del
bindkey "^[[H" beginning-of-line      # Home
bindkey "^[[F" end-of-line            # End
bindkey "^[[5~" beginning-of-history  # PgUp
bindkey "^[[6~" end-of-history        # PgDown
bindkey "^[[1;5C" forward-word        # Ctrl+Right
bindkey "^[[1;5D" backward-word       # Ctrl+Left

export GPG_TTY=`tty`
export GPG_AGENT_INFO=/run/user/$(id -u)/gnupg/S.gpg-agent::
export SSH_AUTH_SOCK=/run/user/$(id -u)/gnupg/S.gpg-agent.ssh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f "$HOME/.zshrc-local" ]; then
    source "$HOME/.zshrc-local"
fi
