#!/usr/bin/env fish

command -q cargo || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
command -q rg || cargo install ripgrep
rustup update
rustup component add clippy
command -q bacon || cargo install bacon
ln -sf /mnt/c/Programming/dotfiles/rust/prefs.toml ~/.config/bacon/prefs.toml