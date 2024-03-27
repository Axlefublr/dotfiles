#!/usr/bin/env fish

fish_add_path "$HOME/.cargo/bin"
bash "$HOME/.cargo/env"
fish_add_path "$HOME/.cargo/env"
rustup update
rustup default stable
rustup toolchain install nightly
cargo login

cargo binstall -y cargo-quickinstall
cargo binstall -y cargo-info
cargo binstall -y irust