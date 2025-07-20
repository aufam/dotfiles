#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed \
    pacman-contrib \
    ca-certificates openssl git \
    base-devel g++ cmake ninja clang \
    python python-pip \
    protobuf protobuf-c \
    curl wget axel \
    fish tmux neofetch bat eza fzf fd rsync ascii ripgrep xclip acpi usbutils \
    scrot ranger ueberzugpp btop jq dunst

