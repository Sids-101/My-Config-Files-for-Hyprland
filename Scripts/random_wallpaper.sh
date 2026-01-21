#!/bin/bash

# Directory containing your wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Select a random file
RANDOM_PICS=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) | shuf -n 1)

# Check if swww-daemon is running, if not, start it
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    # Give it a second to initialize the socket
    sleep 0.5
fi

# Set the wallpaper
swww img "$RANDOM_PICS" --transition-type grow --transition-pos top-right --transition-duration 2
