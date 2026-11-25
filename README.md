# Dotfiles

Sway setup, based on [martin-djakovic/dotfiles](https://github.com/martin-djakovic/dotfiles)

## Auto Installation Script

**Please note:** The installation script is for **Arch Linux** only.

For other distributions, please refer to the **Manual Installation**

~~~bash
git clone https://github.com/zkkzr/dotfiles.git ~/dotfiles
cd ~/dotfiles
./arch-install.sh
~~~

## Manual installation

This is a not a fully manual installation. Although, you still will have to install the following packages yourself:

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

~~~txt
Super+t             - Terminal              (By default Alacritty)
Super+b             - Browser               (By default Firefox)
Super+.             - Emoji manager         (By default rofmoji)
Super+f             - File manager          (By default Thunar)
Super+Lalt+f        - Terminal File manager (By default nnn) 
Super+Lshift+s      - Screenshooter         (By default custom script)
Super+Enter         - Launcher              (By default rofi drun)

Super+q             - To kill focused window
Lalt+f4             - To kill focused window

Super+Lshift+c      - Reload Sway and Waybar

Super+Lshift+Space  - Swap focus between the tiling area and the floating area
(Hold) Super+Mouse1 - To drag focused window

Super+h             - Switch to horizontal tiling
Super+v             - Switch to vertical   tiling

Super+Lalt+q        - Display power menu
~~~

In config, Keybinds are listed under (https://github.com/zkkzr/dotfiles/blob/main/home/.config/sway/config)["General Keybinds"] Section

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
