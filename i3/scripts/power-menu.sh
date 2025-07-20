#!/bin/bash

ACTION=$(echo -e "Shutdown\nReboot\nLogout" | rofi -dmenu -p "Choose Action")
case "$ACTION" in
    Shutdown) systemctl poweroff ;;
    Reboot) systemctl reboot ;;
    Logout) i3-msg exit ;;
esac
