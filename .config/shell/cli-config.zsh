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


bindkey "^H" backward-delete-word    # Ctrl+Backspace
bindkey "^[[3~" delete-char          # Del
bindkey "^[[3;5~" delete-word        # Ctrl+Del
bindkey "^[[H" beginning-of-line     # Home
bindkey "^[[F" end-of-line           # End
bindkey "^[[5~" beginning-of-history # PgUp
bindkey "^[[6~" end-of-history       # PgDown
bindkey "^[[1;5C" forward-word       # Ctrl+Right
bindkey "^[[1;5D" backward-word      # Ctrl+Left

# Skip over duplicate history entries when using up arrow to access previous commands
setopt histignoredups
