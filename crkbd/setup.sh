#!/bin/bash

rm -rf ~/qmk_firmware/keyboards/crkbd/crkbd.c \
       ~/qmk_firmware/keyboards/crkbd/info.json \
       ~/qmk_firmware/keyboards/crkbd/rules.mk \
       ~/qmk_firmware/keyboards/crkbd/keymaps/aufam/

mkdir -p ~/qmk_firmware/keyboards/crkbd/keymaps/aufam/

ln -s $PWD/crkbd.c ~/qmk_firmware/keyboards/crkbd/crkbd.c
ln -s $PWD/info.json ~/qmk_firmware/keyboards/crkbd/info.json
ln -s $PWD/rules.mk ~/qmk_firmware/keyboards/crkbd/rules.mk
ln -s $PWD/keymap.c ~/qmk_firmware/keyboards/crkbd/keymaps/aufam/keymap.c
ln -s $PWD/config.h ~/qmk_firmware/keyboards/crkbd/keymaps/aufam/config.h
