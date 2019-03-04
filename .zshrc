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
    eval "$($GOPATH/bin/powerline-go -error $? -shell zsh -eval -modules nix-shell,venv,user,ssh,cwd,perms,jobs,exit,vgo -modules-right git)"

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
