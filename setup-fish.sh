#!/bin/bash
# curl -s https://raw.githubusercontent.com/aufam/dotfiles/main/setup-fish.sh | bash

set -e  # Exit on error

# Install Fish
echo "[+] Installing Fish shell..."
sudo apt update
sudo apt install -y fish

# Download config.fish
echo "[+] Downloading config.fish from GitHub..."
mkdir -p ~/.config/fish
curl -fsSL https://raw.githubusercontent.com/aufam/dotfiles/main/fish/config.fish -o ~/.config/fish/config.fish

# Check and change default shell
echo "[+] Changing default shell to Fish..."
FISH_PATH=$(which fish)
if ! grep -q "$FISH_PATH" /etc/shells; then
echo "$FISH_PATH" | sudo tee -a /etc/shells
fi
chsh -s "$FISH_PATH"

echo "[+] Installing Fisher and plugins..."
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fish -c "fisher install ilancosman/tide@v6"
fish -c "fisher install patrickf1/fzf.fish"

echo "[✓] Fish shell and plugins installed successfully!"

