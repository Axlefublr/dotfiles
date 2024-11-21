#!/usr/bin/env fish

fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.cargo/env"
bash "$HOME/.cargo/env"
rustup update
rustup default stable
rustup toolchain install nightly
rustup component add rust-analyzer
cargo login

cargo binstall -y cargo-quickinstall
cargo binstall -y cargo-info
cargo binstall -y scriptisto
