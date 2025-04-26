# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Add Vim keybindings for shell
bindkey -v
export KEYTIMEOUT=1

# Set default editor
export EDITOR='nvim'

# Load machine-specific configurations from a separate file that isn't tracked by git
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Conditionally load tools if they exist
# ghcup
[[ -f "$HOME/.ghcup/env" ]] && source "$HOME/.ghcup/env"

# thefuck
command -v thefuck >/dev/null && eval $(thefuck --alias)

# conda - only load if exists
if [ -f "$HOME/opt/anaconda3/bin/conda" ]; then
    __conda_setup="$('$HOME/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/opt/anaconda3/etc/profile.d/conda.sh" ]; then
            . "$HOME/opt/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/opt/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
fi

# Tool-specific configurations - can go in .zshrc.local if they're machine-specific
