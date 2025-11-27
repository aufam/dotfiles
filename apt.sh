#!/bin/bash

set -e

sudo apt update

install_all_of() {
    sudo apt install -y "$*"
}

install_one_of() {
    for pkg in "$@"; do
        if apt-cache show "$pkg" >/dev/null 2>&1; then
            echo "Installing $pkg..."
            sudo apt install -y "$pkg"
            return 0
        fi
    done
    echo "None of the packages ($*) found in repositories."
    return 1
}

install_all_of ca-certificates libssl-dev git curl wget axel pv

install_all_of build-essential g++ ninja-build cmake clang \
               python3 python3-pip \
               npm

# System tools
install_all_of xclip xdotool acpi scrot usbutils dunst rofi playerctl

# Dev tools
install_all_of vim fish tmux neofetch ranger jq ueberzug \
               libopencv-dev libprotobuf-dev libprotoc-dev \
               libsqlite3-dev libpq-dev postgresql-client

# Better tools
install_one_of eza exa
install_one_of btop htop
install_all_of fzf bat fd-find rsync ripgrep
