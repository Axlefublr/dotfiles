#!/usr/bin/env fish

sudo apt install -y fish
chsh -s /usr/bin/fish
mkdir -p ~/.config/fish
ln -sf ~/Programming/dotfiles/fish/config.fish ~/.config/fish/config.fish