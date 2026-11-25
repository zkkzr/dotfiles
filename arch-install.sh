#!/bin/sh

if command -v yay >/dev/null 2>&1; then
    echo "Using yay..."
    AUR_HELPER="yay"
elif command -v paru >/dev/null 2>&1; then
    echo "Using paru..."
    AUR_HELPER="paru"
else
    echo "Neither paru nor yay found. Please install one of them first, or install the packages in 'pkglist-aur.txt' yourself! Otherwise, the Sway installation will not be complete correctly."
fi

cd "$(dirname "$0")"

sudo pacman -S --needed - < pkglist.txt
yay -S --needed - < pkglist-aur.txt

stow -t ~ home
fc-cache -f
systemctl --user daemon-reload
systemctl --user enable update-notification.timer maintenance-notification.timer
