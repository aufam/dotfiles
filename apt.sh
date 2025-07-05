#!/bin/bash

sudo apt update
sudo apt install -y \
    ca-certificates libssl-dev \
    git curl wget axel \
    libopencv-dev libprotobuf-dev libprotoc-dev \
    build-essential g++ cmake ninja-build clang \
    python3 python3-pip \
    fish tmux neofetch batcat fzf fd-find rsync ascii ripgrep xclip acpi \
    scrot ranger

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
