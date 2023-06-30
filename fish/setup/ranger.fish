#!/usr/bin/env fish

command -q ranger || sudo apt install ranger
ranger --copy-config all
cp -f ~/.config/ranger/rc.conf /mnt/c/Programming/dotfiles/rc.conf
ln -sf /mnt/c/Programming/dotfiles/rc.conf ~/.config/ranger/rc.conf