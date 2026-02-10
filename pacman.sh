#!/bin/bash

sudo pacman -Syu --noconfirm

install_all_of() {
    sudo pacman -S --noconfirm --needed "$*"
}

install_all_of pacman-contrib \
               ca-certificates openssl git curl wget axel pv

install_all_of base-devel g++ ninja cmake clang \
               python python-pip \
               npm \
               rust go zig

# System tools
install_all_of xclip xdotool acpi scrot usbutils dunst rofi playerctl

# Dev tools
install_all_of nvim fish tmux neofetch ranger jq ueberzugpp \
               opencv protobuf protoc-dev grpc \
               sqlite postgresql

# Better tools
install_all_of fzf bat fd-find rsync ripgrep eza btop
