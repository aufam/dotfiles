#!/bin/bash

if python3 -c 'import sys; exit(sys.version_info >= (3, 11))'; then
  sudo pip install httpie cmake-language-server debugpy pyright
else
  sudo pip install httpie cmake-language-server debugpy pyright --break-system-packages
fi
