export EDITOR=vim

export TERMINAL=/usr/bin/wezterm

export PATH="$HOME/bin:$PATH"

export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

export GPG_TTY=`tty`
export GPG_AGENT_INFO=/run/user/$(id -u)/gnupg/S.gpg-agent::
export SSH_AUTH_SOCK=/run/user/$(id -u)/gnupg/S.gpg-agent.ssh

eval "$(fnm env --corepack-enabled)"

# fzf catppuccin mocha color theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export TMUX_SESSIONIZER_PROJECTS=(\
~/projects \
)
