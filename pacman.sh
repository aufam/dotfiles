#!/bin/bash

sudo pacman -Syu --noconfirm

install_all_of() {
	sudo pacman -S --noconfirm --needed "$*"
}

install_all_of pacman-contrib ca-certificates openssl git curl wget

install_all_of base-devel g++ ninja cmake python python-pip npm
install_all_of opencv protobuf grpc sqlite postgresql

# System tools
install_all_of xclip xdotool acpi scrot usbutils dunst rofi playerctl neofetch

# Dev tools
install_all_of fish tmux ranger jq ueberzugpp

# Better tools
install_all_of fzf bat eza btop
