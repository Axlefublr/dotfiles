#!/usr/bin/env fish

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fish_add_path "$HOME/.cargo/bin"
bash "$HOME/.cargo/env"
fish_add_path "$HOME/.cargo/env"
rustup update

mkdir -p ~/.config/rustfmt
ln -sf ~/prog/dotfiles/rustfmt.toml ~/.config/rustfmt/rustfmt.toml

cargo install cargo-binstall
cargo binstall -y cargo-quickinstall
cargo binstall -y cargo-info
cargo binstall -y ripgrep
cargo binstall -y watchexec-cli
cargo binstall -y fd-find
cargo binstall -y irust
cargo binstall -y cargo-update

cargo binstall -y bacon
mkdir -p ~/.config/bacon
ln -sf ~/prog/dotfiles/bacon/prefs.toml ~/.config/bacon/prefs.toml