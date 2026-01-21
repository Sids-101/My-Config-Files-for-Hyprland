#!/bin/bash

# 1. Update the system first
echo "Updating system..."
sudo pacman -Syu --noconfirm

# 2. Install official packages
if [ -f pkglist.txt ]; then
    echo "Installing official packages..."
    sudo pacman -S --needed - < pkglist.txt
else
    echo "pkglist.txt not found!"
fi

# 3. Install AUR packages (assuming 'yay' is used)
if [ -f aur_pkglist.txt ]; then
    if command -v yay &> /dev/null; then
        echo "Installing AUR packages with yay..."
        yay -S --needed - < aur_pkglist.txt
    elif command -v paru &> /dev/null; then
        echo "Installing AUR packages with paru..."
        paru -S --needed - < aur_pkglist.txt
    else
        echo "No AUR helper (yay/paru) found. Please install one to restore AUR apps."
    fi
fi

echo "Done! All apps have been processed."
