#!/usr/bin/env fish

command -q ranger || sudo apt install ranger
ranger --copy-config all
cp -f ~/.config/ranger/rc.conf ~/Programming/dotfiles/rc.conf
ln -sf ~/Programming/dotfiles/ranger/rc.conf ~/.config/ranger/rc.conf
cp -f ~/.config/ranger/rifle.conf ~/Programming/dotfiles/rifle.conf
ln -sf ~/Programming/dotfiles/ranger/rifle.conf ~/.config/ranger/rifle.conf