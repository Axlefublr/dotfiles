#!/usr/bin/env fish
mkdir -p ~/.config/fish
rm -f ~/.config/fish/config.fish
ln -s /mnt/c/Programming/dotfiles/fish/config.fish ~/.config/fish/config.fish

mkdir -p ~/.config/nvim
rm -f ~/.config/nvim/init.lua
ln -s /mnt/c/Programming/dotfiles/init.lua ~/.config/nvim/init.lua

ln -s /mnt/c/Programming/dotfiles/starship.toml ~/.config/starship.toml