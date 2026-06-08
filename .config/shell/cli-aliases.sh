# File and Dir colors for ls and other outputs
export LS_OPTIONS='--color=auto'
eval "$(dircolors ~/.config/shell/.dircolors)"
alias ls='ls $LS_OPTIONS'

alias l='ls -lh'
alias ll='ls -lAh'

alias cp='cp -i' # Confirm before overwriting

