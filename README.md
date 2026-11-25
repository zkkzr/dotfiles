# Dotfiles

Sway setup, based on [martin-djakovic/dotfiles](https://github.com/martin-djakovic/dotfiles)

## Auto Installation Script

**Please note:** The installation script is for **Arch Linux** only.

For other distributions, please refer to the **Manual Installation**

~~~bash
git clone https://github.com/zkkzr/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
~~~

## Manual installation

This is not a fully manual installation. Although, you still will have to install the following packages yourself:

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

After installing the packages, run:

~~~bash
git clone https://github.com/zkkzr/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
~~~

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

In main Sway config, Keybinds are listed under [General Keybinds]("https://github.com/zkkzr/dotfiles/blob/main/home/.config/sway/config") Section

## Notes

- **Monitors:** Configurations are located in `~/.config/sway/outputs.d/local` (not tracked by git).
- **Backgrounds:** Wallpapers are stored in `~/.local/share/backgrounds`.

## Credits

### Base
Source: [martin-djakovic/dotfiles](https://github.com/martin-djakovic/dotfiles)  
This repository **is** the base for these dotfiles.

### Sounds

#### AOSP
Notification sounds are sourced from AOSP (Android Open Source Project) (`platform/frameworks/base`, `data/sounds`) and converted from `.ogg` to `.wav`:

- `Notification.wav`: `notifications/ogg/Selenium.ogg`
- `Warning.wav`: `notifications/ogg/Syrma.ogg`

Source: [AOSP/platform/frameworks/base/+/5ac72a2/data/sounds/](https://android.googlesource.com/platform/frameworks/base/+/5ac72a2/data/sounds/)
