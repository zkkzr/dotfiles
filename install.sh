#!/bin/sh

cd "$(dirname "$0")"

stow -t ~ home
fc-cache -f
systemctl --user daemon-reload
systemctl --user enable update-notification.timer maintenance-notification.timer
