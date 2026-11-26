#!/bin/sh
set -eu

cd "$(dirname "$0")"

if [ "$(id -u)" -eq 0 ]; then
    echo "Do not run this script as root."
    exit 1
fi

ask() {
    printf "%s (y/N): " "$1"
    read -r answer
    case "$answer" in
        [yY][eE][sS]|[yY]) return 0 ;;
        *) return 1 ;;
    esac
}

list() {
    grep -vE '^[[:space:]]*(#|$)' "$1" | tr '\n' ' '
}

install_arch_packages() {
    AUR_HELPER=""
    if command -v yay >/dev/null 2>&1; then
        AUR_HELPER="yay"
    elif command -v paru >/dev/null 2>&1; then
        AUR_HELPER="paru"
    fi

    if [ -n "$AUR_HELPER" ]; then
        echo "Using $AUR_HELPER..."
    else
        echo "Neither paru nor yay found. Please install one of them first, or install the packages in 'pkglist-aur.txt' yourself! Otherwise, the Sway installation will not be completed correctly."
        ask "Do you want to continue anyway?" || { echo "Installation aborted."; exit 1; }
    fi

    sudo pacman -S --needed git stow

    pkgs=$(list pkglist.txt)
    if [ -n "$pkgs" ]; then
        sudo pacman -S --needed $pkgs
    fi

    if [ -n "$AUR_HELPER" ]; then
        aur=$(list pkglist-aur.txt)
        if [ -n "$aur" ]; then
            "$AUR_HELPER" -S --needed $aur
        fi
    fi
}

check_manual_packages() {
    if ! command -v stow >/dev/null 2>&1; then
        echo "Error: 'stow' is not installed. Please install it first."
        exit 1
    fi

    echo "This is not an Arch based system, packages are not installed automatically."
    echo "The following packages are required (names are from Arch, yours may differ):"
    echo "  $(list pkglist.txt)"
    echo "  $(list pkglist-aur.txt)"
    ask "Have you installed all of them yourself?" || { echo "Installation aborted."; exit 1; }
}

if command -v pacman >/dev/null 2>&1; then
    install_arch_packages
else
    check_manual_packages
fi

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

bookmarks="$HOME/.config/gtk-3.0/bookmarks"
if [ ! -e "$bookmarks" ]; then
    mkdir -p "$(dirname "$bookmarks")"
    printf 'file://%s/%s\n' "$HOME" Downloads "$HOME" Pictures "$HOME" Videos "$HOME" Music > "$bookmarks"
fi

stow -t "$HOME" home
fc-cache -f

if systemctl --user daemon-reload 2>/dev/null; then
    systemctl --user enable update-notification.timer maintenance-notification.timer
else
    echo "No user systemd session found. After logging in run:"
    echo "  systemctl --user daemon-reload"
    echo "  systemctl --user enable update-notification.timer maintenance-notification.timer"
fi

if [ -x system/install.sh ] && ask "Install system files (SDDM theme and config)?"; then
    ./system/install.sh
fi

echo "Done."
echo "Next steps:"
echo "  - put monitor settings into ~/.config/sway/outputs.d/local"
echo "  - switch the display manager: sudo systemctl enable sddm"
