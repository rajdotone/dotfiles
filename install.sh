#!/bin/bash

# Ensure native macOS system configuration directory exists
mkdir -p "$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles"

echo "--------------------------------------------"
echo "Checking System Prerequisites..."
echo "--------------------------------------------"

# Verify Homebrew Core Engine
if ! command -v brew &> /dev/null; then
    echo "→ Homebrew not found. Installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "✔ Homebrew engine is verified."
fi

# Verify Oh My Zsh Environment
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "→ Oh My Zsh missing. Deploying framework..."
    RUNZSH=no CHSH=no /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "✔ Oh My Zsh framework is verified."
fi

echo "--------------------------------------------"
echo "Processing Dependencies via Brewfile..."
echo "--------------------------------------------"
cd "$DOTFILES_DIR" || exit
brew bundle

echo "--------------------------------------------"
echo "Deploying System-Wide Dotfile Symlinks..."
echo "--------------------------------------------"

deploy_link() {
    local source_file="$1"
    local target_link="$2"
    
    if [ -d "$target_link" ] || [ -f "$target_link" ]; then
        if [ ! -L "$target_link" ]; then
            echo "→ Found existing physical target at $target_link. Backing up to .bak"
            mv "$target_link" "${target_link}.bak"
        fi
    fi
    ln -sfn "$source_file" "$target_link"
}

# Link Matrix
deploy_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
deploy_link "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty"
deploy_link "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
deploy_link "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

echo "--------------------------------------------"
echo "Done! Workstation architecture is synchronized."
echo "--------------------------------------------"
