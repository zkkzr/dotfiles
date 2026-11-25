#!/bin/sh

if ! command -v yay >/dev/null 2>&1; then
    echo "Installing yay..."
    cd ~/
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si
fi

cd "$(dirname "$0")"

sudo pacman -S --needed - < pkglist.txt
yay -S --needed - < pkglist-aur.txt

stow -t ~ home
fc-cache -f
systemctl --user daemon-reload
systemctl --user enable update-notification.timer maintenance-notification.timer
