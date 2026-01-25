# Configure history
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000

# Set up completions
autoload -Uz compinit colors zcalc
compinit -d
colors

# Speed up completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# automatically find new executables in path
zstyle ':completion:*' rehash true

# Highlight menu selection
zstyle ':completion:*' menu select

# Append session history list to history file rather than replace it, and do so incrementally instead of waiting until the shell exits
setopt inc_append_history

# Do not enter command lines into the history list if they are duplicates of the previous event
setopt hist_ignore_dups

# If numeric filenames are matched by a filename generation pattern, sort the filenames numerically rather than lexicographically
setopt numeric_glob_sort

# Report the status of background jobs immediately, rather than waiting until just before printing a prompt
setopt notify

unsetopt autocd beep nomatch

function set_my_keybinds() {
    bindkey "^H" backward-delete-word    # Ctrl+Backspace
    bindkey "^[[3~" delete-char          # Del
    bindkey "^[[3;5~" delete-word        # Ctrl+Del
    bindkey "^[[1~" beginning-of-line    # Home
    bindkey "^[[4~" end-of-line          # End
    bindkey "^[[5~" beginning-of-history # PgUp
    bindkey "^[[6~" end-of-history       # PgDown
    bindkey "^[[1;5C" forward-word       # Ctrl+Right
    bindkey "^[[1;5D" backward-word      # Ctrl+Left

    # Same tmux-sessionizer keybind as tmux config
    bindkey -s ^p "sessionizer\n"
}
set_my_keybinds
# need to re-bind keys after zsh-vi-mode init
zvm_after_init_commands+=(set_my_keybinds)
