#!/usr/bin/env fish

command -q cargo || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup update
rustup component add clippy
cargo install binstall
cargo binstall -y cargo-quickinstall
cargo binstall -y cargo-info
command -q rg || cargo binstall -y ripgrep
command -q speedtest-rs || cargo binstall -y speedtest-rs
command -q bacon || cargo binstall -y bacon
ln -sf /mnt/c/Programming/dotfiles/bacon/prefs.toml ~/.config/bacon/prefs.toml
command -q watchexec || cargo binstall -y watchexec-cli
command -q fd || cargo binstall -y fd-find
