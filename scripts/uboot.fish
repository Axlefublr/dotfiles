#!/usr/bin/env fish

for package in (cat ~/.local/share/magazine/C)
    cat ~/r/info/pswds/sudo | sudo -S pacman -Rns --noconfirm $package
end
truncate -s 0 ~/.local/share/magazine/C

for package in (cat ~/.local/share/magazine/W)
    echo $package | xargs eget --upgrade-only
end

rustup update
cargo install-update -a

pipx upgrade-all

cat ~/r/info/pswds/sudo | sudo -Sv
yes | sudo pacman -Syyu
pacclean
