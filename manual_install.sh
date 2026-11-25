#!/bin/sh
set -eu

cd "$(dirname "$0")"

if [ "$(id -u)" -eq 0 ]; then
    echo "Do not run this script as root."
    exit 1
fi

# Проверка наличия stow
if ! command -v stow >/dev/null 2>&1; then
    echo "Error: 'stow' is not installed. Please install it first."
    exit 1
fi

# --- Блок Stow (перенос конфигов) ---
conflicts=$(mktemp)
stow -n -t "$HOME" home 2>&1 \
    | sed -n \
        -e 's/.*existing target is not owned by stow: //p' \
        -e 's/.*over existing target \(.*\) since.*/\1/p' \
    > "$conflicts" || true

if [ -s "$conflicts" ]; then
    backup="$HOME/.dotfiles-backup/$(date +%F_%H-%M-%S)"
    while IFS= read -r f; do
        if [ -e "$HOME/$f" ] || [ -L "$HOME/$f" ]; then
            mkdir -p "$backup/$(dirname "$f")"
            mv "$HOME/$f" "$backup/$f"
        fi
    done < "$conflicts"
    echo "Moved conflicting files to $backup"
fi
rm -f "$conflicts"

stow -t "$HOME" home
fc-cache -f

# --- Systemd services ---
if systemctl --user daemon-reload 2>/dev/null; then
    systemctl --user enable update-notification.timer maintenance-notification.timer
fi

if [ -x system/install.sh ] && printf "Install system files (SDDM theme and config)? (y/N): " && read -r ans && [ "$ans" = "y" ]; then
    ./system/install.sh
fi

echo "Done."
echo "Next steps:"
echo "  - put monitor settings into ~/.config/sway/outputs.d/local"
echo "  - switch the display manager: sudo systemctl enable sddm"
