#!/bin/bash

# Get the absolute path of the dotfiles directory
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

echo "Setting up dotfiles from: $DOTFILES"

# Create necessary directories
echo "Creating required directories..."
mkdir -p ~/.config/nvim
mkdir -p ~/.config/kitty
mkdir -p ~/.tmux/plugins

# Neovim setup
echo "Setting up Neovim configuration..."
if [ -d "$DOTFILES/nvim" ]; then
    ln -sf "$DOTFILES/nvim" ~/.config/
fi

# Tmux configuration
echo "Setting up tmux configuration..."
ln -sf "$DOTFILES/tmux/.tmux.conf" ~/.tmux.conf

# Set up TPM (Tmux Plugin Manager)
echo "Setting up Tmux Plugin Manager..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
    ln -sf "$DOTFILES/tmux/plugins/tpm" ~/.tmux/plugins/tpm
fi

# Zsh setup
echo "Setting up Zsh configuration..."
ln -sf "$DOTFILES/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES/zsh/.zshenv" ~/.zshenv


# OS-specific configurations
if [ "$OS" = "Darwin" ]; then
    # macOS specific
    echo "Setting up macOS-specific configurations..."
    if [ -d "$DOTFILES/kitty" ]; then
        ln -sf "$DOTFILES/kitty" ~/.config/
    fi
elif [ "$OS" = "Linux" ]; then
    # WSL/Linux specific
    echo "Setting up Linux/WSL-specific configurations..."
    # Windows Terminal settings need to be manually copied
    echo "Note: For Windows Terminal, manually copy settings from windows_terminal/settings.json"
    echo "to %LOCALAPPDATA%\\Packages\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\LocalState\\settings.json"
fi

# Create local config files if they don't exist
echo "Setting up local configuration files..."
touch ~/.zshrc.local

echo "Dotfiles installation complete!"
echo ""
echo "Next steps:"
echo "1. Start tmux using 'tmux'"
echo "2. Press prefix + I (capital I) to install tmux plugins"
echo "3. Reload zsh configuration with 'source ~/.zshrc'"
