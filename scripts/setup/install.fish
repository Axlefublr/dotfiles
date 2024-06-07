#!/usr/bin/env fish

sudo pacman -Syu

for package_name in (cat ~/.local/share/magazine/Z)
    sudo pacman -S --noconfirm $package_name
end

for package_name in (cat ~/.local/share/magazine/X)
    paru --noconfirm -aS $package_name
end