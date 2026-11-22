#!/bin/sh
set -e
cd "$(dirname "$0")"
sudo cp -rT --no-preserve=mode,ownership root /
magick "$HOME/.local/share/backgrounds/wallpaper_field.jpg" -blur 0x12 /tmp/sddm-bg.jpg
sudo install -m 644 /tmp/sddm-bg.jpg /usr/share/sddm/themes/hyprlock/background.jpg
rm -f /tmp/sddm-bg.jpg
sudo install -d /usr/share/fonts/TTF
sudo install -m 644 "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Regular.ttf" "$HOME/.local/share/fonts/JetBrainsMonoNerdFont-Bold.ttf" /usr/share/fonts/TTF/
sudo fc-cache -f
