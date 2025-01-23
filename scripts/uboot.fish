#!/usr/bin/env fish

for package in (cat ~/.local/share/magazine/C)
    cat ~/prog/info/pswds/sudo | sudo -S pacman -Rns --noconfirm $package
end
truncate -s 0 ~/.local/share/magazine/C

for package in (cat ~/.local/share/magazine/W)
    eget $package
end

rustup update
cargo install-update -a

pipx upgrade-all

cat ~/prog/info/pswds/sudo | sudo -Sv
yes | sudo pacman -Syyu
pacclean
