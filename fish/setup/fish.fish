#!/usr/bin/env fish

mkdir -p ~/.config/fish
ln -sf /mnt/c/Programming/dotfiles/fish/config.fish ~/.config/fish/config.fish
command -q starship || curl -sS https://starship.rs/install.sh | sh
ln -s /mnt/c/Programming/dotfiles/starship.toml ~/.config/starship.toml