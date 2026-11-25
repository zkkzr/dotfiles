#!/bin/sh

if command -v yay >/dev/null 2>&1; then
    echo "Using yay..."
    AUR_HELPER="yay"
elif command -v paru >/dev/null 2>&1; then
    echo "Using paru..."
    AUR_HELPER="paru"
else
    echo "Neither paru nor yay found. Please install one of them first, or install the packages in 'pkglist-aur.txt' yourself! Otherwise, the Sway installation will not be complete correctly."
    printf "Do you want to continue anyway? (y/N): "
    read answer
    case "$answer" in
        [yY][eE][sS]|[yY]) 
            echo "Continuing..." 
            ;;
        *) 
            echo "Installation aborted."
            exit 1 
            ;;
    esac
fi

cd "$(dirname "$0")"

sudo pacman -S --needed - < pkglist.txt
yay -S --needed - < pkglist-aur.txt

stow -t ~ home --adopt
fc-cache -f
systemctl --user daemon-reload
systemctl --user enable update-notification.timer maintenance-notification.timer
