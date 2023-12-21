#!/usr/bin/bash

yay ttf-twemoji
yay ascii-image-converter
yay tgpt
yay mapscii
yay unimatrix-git
yay zoom
yay anki-bin
yay kwin-bismuth
yay mullvad-vpn-bin
yay xremap-x11-bin

yay gromit-mpx
ln -sf ~/prog/dotfiles/gromit.cfg ~/.config/gromit-mpx.cfg

yay visual-studio-code-bin
mkdir -p ~/.config/Code/User
ln -sf ~/prog/dotfiles/vscode/settings.jsonc ~/.config/Code/User/settings.json
ln -sf ~/prog/dotfiles/vscode/keybindings.jsonc ~/.config/Code/User/keybindings.json