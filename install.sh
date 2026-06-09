#!/bin/bash

# Ensure standard system configuration directory exists
mkdir -p "$HOME/.config"

# Define the root dotfiles path
DOTFILES_DIR="$HOME/dotfiles"

echo "--------------------------------------------"
echo "Initializing System-Wide Dotfile Symlinks..."
echo "--------------------------------------------"

# --- NEOVIM AUTO-LINKING ---
# If a real physical directory exists at ~/.config/nvim, back it up safely
if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    echo "→ Found existing physical Neovim directory. Backing up to ~/.config/nvim.bak"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
fi

# Create or overwrite the symlink pointing to your global dotfiles folder
echo "→ Linking Neovim configuration..."
ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# --- FUTURE APPS GO HERE ---
# When you want to track Ghostty later, you just drop lines like this here:
# ln -sfn "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"

echo "--------------------------------------------"
echo "Done! Workstation configuration is synchronized."
echo "--------------------------------------------"
