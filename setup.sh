#!/usr/bin/env bash

# Dotfiles setup
# How to use:
# curl -s https://raw.githubusercontent.com/aufam/dotfiles/main/setup.sh | bash

### Some useful CLI tools
sudo apt update
sudo apt install -y ca-certificates libssl-dev build-essential git cmake curl ninja-build python3-pip vim neofetch axel bat exa fzf fd-find rsync ascii ripgrep xclip


if grep -iq "ubuntu" /etc/os-release && grep -q "24.04" /etc/os-release; then
  sudo apt install -y eza
else
  sudo apt install -y exa
fi

if grep -q "ARM" /proc/cpuinfo; then
  sudo apt install -y htop
else
  sudo apt install -y btop cpufetch duf
fi

if python3 -c 'import sys; exit(sys.version_info >= (3, 11))'; then
  sudo pip install httpie thefuck cmake-language-server
else
  sudo pip install httpie thefuck cmake-language-server --break-system-packages
fi

### Vim setup
if [ ! -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "Vim-Plug already installed."
fi

curl https://raw.githubusercontent.com/aufam/dotfiles/main/.vimrc -o ~/.vimrc
curl https://raw.githubusercontent.com/aufam/dotfiles/main/fish/config.fish -o ~/.config/fish/config.fish
vim -u NONE -c 'source ~/.vim/plugins.vim' -c 'PlugInstall' -c 'qa'
python3 ~/.vim/plugged/YouCompleteMe/install.py

### Fish setup
if ! command -v fish &> /dev/null; then
  echo "Fish shell is not installed. Skipping Oh My Fish installation."
else
  echo $(which fish) | sudo tee -a /etc/shells
  chsh -s $(which fish)

  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
  fisher install jorgebucaran/fisher
  fisher install ilancosman/tide@v6
  fisher install patrickf1/fzf.fish
fi

### Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

echo "Installation complete."
