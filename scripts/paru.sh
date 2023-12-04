#!/usr/bin/bash
yay -S paru

paru ttf-twemoji
paru ascii-image-converter
paru tgpt
paru mapscii
paru unimatrix-git
paru zoom
paru anki-bin
paru kwin-bismuth
paru mullvad-vpn-bin
paru xremap-x11-bin

paru gromit-mpx
ln -sf ~/prog/dotfiles/gromit.cfg ~/.config/gromit-mpx.cfg

paru visual-studio-code-bin
mkdir -p ~/.config/Code/User
ln -sf ~/prog/dotfiles/vscode/settings.jsonc ~/.config/Code/User/settings.json
ln -sf ~/prog/dotfiles/vscode/keybindings.jsonc ~/.config/Code/User/keybindings.json