# Dotfiles

Sway setup, based on [martin-djakovic/dotfiles](https://github.com/martin-djakovic/dotfiles)

## Auto Installation Script

please note that installation script is arch-linux only
for other distros refer to Manual installation

~~~bash
git clone https://github.com/zkkzr/dotfiles.git ~/dotfiles
cd ~/dotfiles
./arch-install.sh
~~~

## Manual installation
this is not fully manual installation, but you have to install those packages yourself:

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

after that:

~~~
git clone https://github.com/zkkzr/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
~~~

## Notes

- monitors go to ~/.config/sway/outputs.d/local (not tracked)
- backgrounds are used from ~/.local/share/backgrounds

## Credits

### Base
source: [martin-djakovic/dotfiles](https://github.com/martin-djakovic/dotfiles)

Base for these dotfiles

### Sounds

#### AOSP

Notification sounds come from AOSP (Android Open Source Project) (platform/frameworks/base, data/sounds),
converted from ogg to wav:

- Notification.wav: notifications/ogg/Selenium.ogg
- Warning.wav: notifications/ogg/Syrma.ogg

Source: [AOSP/platform/frameworks/base/+/5ac72a2/data/sounds/](https://android.googlesource.com/platform/frameworks/base/+/5ac72a2/data/sounds/)
