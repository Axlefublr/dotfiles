#!/usr/bin/env fish

for package in (cat ~/.local/share/magazine/W)
    echo $package | xargs eget --upgrade-only
end

stew upgrade --all
rustup update
cargo install-update -a
uv tool upgrade --all

cat ~/fes/uviw/afen/sudo | sudo -Sv
yes | sudo pacman -Syyu
pacclean

nu -c 'config nu --doc' >~/.local/share/frizz/defconf/nushell.nu

echo 'nom refresh' >&2
http_proxy=http://127.0.0.1:8118 https_proxy=http://127.0.0.1:8118 nom refresh
