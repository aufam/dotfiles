#!/bin/bash
# curl -s https://raw.githubusercontent.com/aufam/dotfiles/main/setup-cpp.sh | bash

sudo apt install -y build-essential cmake ninja-build clang clangd-19 clang-format

if python3 -c 'import sys; exit(sys.version_info >= (3, 11))'; then
  sudo pip install cmake-language-server
else
  sudo pip install cmake-language-server --break-system-packages
fi
