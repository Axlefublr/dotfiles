#!/usr/bin/env fish

for package in (cat ~/.local/share/magazine/W)
    echo $package | xargs eget --upgrade-only
end

frizz
stew upgrade --all
rustup update
cargo install-update -a
uv tool upgrade --all

cat ~/fes/ack/fux/sudo | sudo -Sv
yes | sudo pacman -Syyu
pacclean
