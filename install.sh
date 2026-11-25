#!/bin/sh
cd "$(dirname "$0")"
sudo pacman -S --needed - < pkglist.txt
command -v yay >/dev/null 2>&1 || sudo pacman -S git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -S --needed - < pkglist-aur.txt
stow -t ~ home
fc-cache -f
systemctl --user daemon-reload
systemctl --user enable update-notification.timer maintenance-notification.timer
