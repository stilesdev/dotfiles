if [ -f "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

if [ -f "/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" ]; then
    source "/usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"

    zmodload zsh/terminfo
    function set_history_substring_search_keybinds() {
        bindkey "$terminfo[kcuu1]" history-substring-search-up
        bindkey "$terminfo[kcud1]" history-substring-search-down
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down
    }
    set_history_substring_search_keybinds
    # need to re-bind keys after zsh-vi-mode init
    zvm_after_init_commands+=(set_history_substring_search_keybinds)
fi

if [ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if [ -f "/usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh" ]; then
    function zvm_config() {
        ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
        ZVM_CURSOR_STYLE_ENABLED=false
        # ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
    }
    source "/usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.zsh"
fi
