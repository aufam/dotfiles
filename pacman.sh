#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed \
    ca-certificates openssl git \
    base-devel g++ cmake ninja clang \
    python python-pip \
    protobuf protobuf-c \
    curl wget axel \
    fish tmux neofetch bat eza fzf fd rsync ascii ripgrep xclip acpi \
    scrot ranger ueberzugpp

if grep -q "ARM" /proc/cpuinfo; then
  sudo pacman -S --noconfirm --needed htop
else
  sudo pacman -S --noconfirm --needed btop duf
fi
