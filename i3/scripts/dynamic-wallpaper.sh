#!/bin/bash

# Dynamic wallpaper collection by https://github.com/adi1090x/dynamic-wallpaper
WALLPAPER_COLLECTION="$HOME/dynamic-wallpaper/images"

# If collection doesn't exist, log and exit
if [ ! -d "$WALLPAPER_COLLECTION" ]; then
    echo "[ERROR] $WALLPAPER_COLLECTION does not exist"
    exit 1
fi

# Pick a random wallpaper directory from the collection
WALLPAPER_DIR=$(find "$WALLPAPER_COLLECTION" -mindepth 1 -maxdepth 1 -type d | shuf -n 1)

# If no directory was found, log and exit
if [ -z "$WALLPAPER_DIR" ]; then
    echo "[ERROR] No wallpaper directory found in $WALLPAPER_COLLECTION"
    exit 1
fi

# Loop to update wallpaper every hour
while true; do
    HOUR=$(date +'%-H')
    WALLPAPER=$(ls $WALLPAPER_DIR/$HOUR.*)

    # Only set wallpaper if the file exists
    if [ -f "$WALLPAPER" ]; then
        feh --bg-scale "$WALLPAPER"
    else
        echo "[ERROR] $WALLPAPER does not exist"
    fi

    # Sleep until the next hour mark
    sleep $((3600 - $(date +%M)*60 - $(date +%S)))
done

