#!/usr/bin/env fish

command -q cargo || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
rustup component add clippy
cargo install binstall
cargo binstall cargo-quickinstall
cargo binstall cargo-info
command -q rg || cargo binstall ripgrep
command -q speedtest-rs || cargo binstall speedtest-rs
# command -q bacon || cargo binstall bacon
# ln -sf /mnt/c/Programming/dotfiles/bacon/prefs.toml ~/.config/bacon/prefs.toml
command -q watchexec || cargo binstall watchexec-cli