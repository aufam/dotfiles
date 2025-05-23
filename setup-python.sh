#!/bin/bash
# curl -s https://raw.githubusercontent.com/aufam/dotfiles/main/setup-python.sh | bash

sudo apt install -y python3 python3-pip

if python3 -c 'import sys; exit(sys.version_info >= (3, 11))'; then
  sudo pip install debugpy
else
  sudo pip install debugpy --break-system-packages
fi
