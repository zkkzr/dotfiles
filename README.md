<h1 align="center">Dotfiles</h1>

<div align="center">
  <img src="./screenshots/main.png" alt="Main Screenshot">
</div>

<p align="center">Sway setup based on <a href="https://github.com/martin-djakovic/dotfiles">martin-djakovic/dotfiles</a></p>

## Installation

### Auto Installation Script

**Please note:** The installation script is for **Arch Linux** only.

For other distributions, please refer to the [Manual Installation](https://github.com/zkkzr/dotfiles/blob/main/README.md#manual-installation)

Auto Installation Script:

~~~bash
git clone https://github.com/zkkzr/dotfiles.git ~/dotfiles
cd dotfiles
chmod +x install.sh
./install.sh
~~~

### Manual installation

To install manually, first install the following packages:

~~~txt
alacritty
alsa-utils
brightnessctl
dunst
grim
hyprlock
lightdm
nnn
rofi
rsync
stow
sway
swaybg
swayidle
waybar
wl-clipboard
wofi
sway-audio-idle-inhibit-git
~~~

After installing the packages, run this script to symlink the configuration files:

~~~bash
git clone https://github.com/zkkzr/dotfiles.git ~/dotfiles
cd dotfiles
chmod +x manual_install.sh
./manual_install.sh
~~~

Alternatively, you can link the files manually

## Keybinds

### General
| Keybind | Action | Default Tool |
| :--- | :--- | :--- |
| `Super+t` | Terminal | Alacritty |
| `Super+b` | Browser | Firefox |
| `Super+.` | Emoji manager | rofmoji |
| `Super+f` | File manager | Thunar |
| `Super+Lalt+f` | Terminal File manager | nnn |
| `Super+Lshift+s` | Screenshooter | Custom script |
| `Super+Enter` | Launcher | rofi drun |

### Window Management
| Keybind | Action |
| :--- | :--- |
| `Super+q` | Kill focused window |
| `Lalt+f4` | Kill focused window |
| `Super+h` | Switch to horizontal tiling |
| `Super+v` | Switch to vertical tiling |
| `Super+Lalt+Space` | Switch focused winodow between tiling / floating |
| `Super+Mouse1` (Hold) | Drag focused window |

### System
| Keybind | Action |
| :--- | :--- |
| `Super+Lshift+c` | Reload Sway and Waybar |
| `Super+Lalt+q` | Display power menu |

In main Sway config, Keybinds are listed under [General Keybinds](https://github.com/zkkzr/dotfiles/blob/main/home/.config/sway/config) Section

## Notes

- **Monitors:** Configurations are located in `~/.config/sway/outputs.d/local` (not tracked by git).
- **Backgrounds:** Wallpapers are stored in `~/.local/share/backgrounds`.

## Gallery

### Floating Window
<div align="center">
  <img src="./screenshots/main.png" alt="Main">
</div>

### Tiled Windows
<div align="center">
  <img src="./screenshots/tile.png" alt="Tile">
</div>

### Locked Screen
<div align="center">
  <img src="./screenshots/lock.png" alt="Lock">
</div>

### SDDM Greeter
<div align="center">
  <img src="./screenshots/sddm.png" alt="Sddm">
</div>


## Credits

### Base
This repository is the base for these dotfiles.

Source: [martin-djakovic/dotfiles](https://github.com/martin-djakovic/dotfiles)  

### Sounds

#### AOSP
Notification sounds are sourced from AOSP (Android Open Source Project) (`platform/frameworks/base`, `data/sounds`) and converted from `.ogg` to `.wav`:

- `Notification.wav`: `notifications/ogg/Selenium.ogg`
- `Warning.wav`: `notifications/ogg/Syrma.ogg`

Source: [AOSP/platform/frameworks/base/+/5ac72a2/data/sounds/](https://android.googlesource.com/platform/frameworks/base/+/5ac72a2/data/sounds/)
