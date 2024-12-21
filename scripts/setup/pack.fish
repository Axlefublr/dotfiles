#!/usr/bin/env fish

function pack-man
    sudo pacman -Syyu
    for package_name in (cat ~/.local/share/magazine/Z)
        sudo pacman -S --noconfirm $package_name
    end
    for package_name in (cat ~/.local/share/magazine/X)
        paru --noconfirm -aS $package_name
    end
end

function pack-fuck
    sudo pacman -Rns --noconfirm eos-update-notifier
    sudo pacman -Rns --noconfirm nano-syntax-highlighting
    sudo pacman -Rns --noconfirm htop
    sudo pacman -Rns --noconfirm meld
end

function pack-pip
    pipx install exrex
    pipx install git+https://github.com/cjbassi/rofi-copyq
end

function pack-rust
    cargo binstall -y cargo-quickinstall
    cargo binstall -y cargo-info
    cargo binstall -y scriptisto
end
