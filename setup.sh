#!/bin/bash

# Some useful CLI tools
# Usage: curl -s https://raw.githubusercontent.com/aufam/dotfiles/main/setup.sh | bash

sudo apt update
sudo apt install -y \
    ca-certificates libssl-dev git curl \
    build-essential \
    python3 python3-pip \
    libprotobuf-dev \
    tmux neofetch axel bat exa fzf fd-find rsync ascii ripgrep xclip

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
  sudo pip install httpie
else
  sudo pip install httpie --break-system-packages
fi
