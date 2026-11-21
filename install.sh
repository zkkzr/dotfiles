#!/bin/sh
cd "$(dirname "$0")"
sudo pacman -S --needed - < pkglist.txt
stow -t ~ home
fc-cache -f
systemctl --user daemon-reload
systemctl --user enable update-notification.timer maintenance-notification.timer
