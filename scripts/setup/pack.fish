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
end

function pack-rust
    sudo pacman -S --noconfirm cargo-binstall
    sudo pacman -S --noconfirm cargo-update
    cargo binstall -y cargo-quickinstall
    cargo binstall -y cargo-info
    cargo binstall -y scriptisto
    # cargo binstall -y cargo-script
end

function pack-fish
    sudo pacman -S --noconfirm fisher
end
