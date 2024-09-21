#!/usr/bin/env bash

# Dotfiles setup
# How to use:
# curl -s https://raw.githubusercontent.com/aufam/dotfiles/main/setup.sh | bash

### Some useful CLI tools
sudo apt update
sudo apt install -y git cmake curl build-essential ninja-build python3-pip vim-gtk3 fish neofetch axel bat eza fzf fd-find rsync ascii ripgrep xclip

if grep -q "ARM" /proc/cpuinfo; then
  sudo apt install -y htop
else
  sudo apt install -y btop cpufetch duf
fi

sudo pip install httpie thefuck cmake-language-server --break-system-packages

### Vim setup
if [ ! -f ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  echo "Vim-Plug already installed."
fi

curl https://raw.githubusercontent.com/aufam/dotfiles/main/.vimrc -o ~/.vimrc
vim -u NONE -c 'source ~/.vim/plugins.vim' -c 'PlugInstall' -c 'qa'
python3 ~/.vim/plugged/YouCompleteMe/install.py

### Fish setup
if ! command -v fish &> /dev/null; then
  echo "Fish shell is not installed. Skipping Oh My Fish installation."
else
  echo $(which fish) | sudo tee -a /etc/shells
  chsh -s $(which fish)

  curl -L https://get.oh-my.fish | fish
  omf install bobthefish
  curl https://raw.githubusercontent.com/aufam/dotfiles/main/config.fish -o ~/.config/fish/config.fish 
  omf reload
fi

### Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

echo "Installation complete."