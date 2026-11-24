# dotfiles

Sway setup, based on [martin-djakovic/dotfiles](https://github.com/martin-djakovic/dotfiles)

## Install

    git clone git@github.com/zkkzr/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ./install.sh

## Notes

- monitors go to ~/.config/sway/outputs.d/local (not tracked)
- lightdm autologin is a manual step (see /etc/lightdm/lightdm.conf)
- backgrounds are used from ~/.local/share/backgrounds

## Credits

Notification sounds are from AOSP (Android Open Source Project)

## Credits

Notification sounds come from AOSP (platform/frameworks/base, data/sounds),
converted from ogg to wav:

- Notification.wav: notifications/ogg/Selenium.ogg
- Warning.wav: from the same directory tree

Source: https://android.googlesource.com/platform/frameworks/base/+/5ac72a2/data/sounds/
