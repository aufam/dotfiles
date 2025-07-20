#!/bin/bash

choice=$(printf "Yes\nNo" | rofi -dmenu -p "Close window?")
if [[ "$choice" == "Yes" ]]; then
    i3-msg kill
fi

