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

setopt histignoredups

eval "$(starship init zsh)"

export EDITOR=vim

alias ls='ls --color=auto'
alias ll='ls -lAh'
alias dc='docker-compose'

bindkey "^H" backward-delete-word    # Ctrl+Backspace
bindkey "^[[3~" delete-char          # Del
bindkey "^[[3;5~" delete-word        # Ctrl+Del
bindkey "^[[H" beginning-of-line     # Home
bindkey "^[[F" end-of-line           # End
bindkey "^[[5~" beginning-of-history # PgUp
bindkey "^[[6~" end-of-history       # PgDown
bindkey "^[[1;5C" forward-word       # Ctrl+Right
bindkey "^[[1;5D" backward-word      # Ctrl+Left

# export GPG_TTY=`tty`
# export GPG_AGENT_INFO=/run/user/$(id -u)/gnupg/S.gpg-agent::
# export SSH_AUTH_SOCK=/run/user/$(id -u)/gnupg/S.gpg-agent.ssh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

for script in ~/.config/shell/*.(z|)sh; do
    . "$script"
done

