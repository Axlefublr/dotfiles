#!/usr/bin/env fish

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fish_add_path "$HOME/.cargo/bin"
bash "$HOME/.cargo/env"
fish_add_path "$HOME/.cargo/env"
rustup update
rustup default stable
rustup toolchain install nightly

cargo binstall -y cargo-quickinstall
cargo binstall -y cargo-info
cargo binstall -y watchexec-cli
cargo binstall -y irust