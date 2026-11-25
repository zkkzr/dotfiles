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
