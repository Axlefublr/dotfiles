#!/usr/bin/env fish

fcf.nu fix
cat ~/fes/uviw/afen/sudo | sudo -S modprobe uinput
systemctl --user restart kanata.service

niri msg action focus-workspace main
foottitled.sh nugleterm -N nu
foottitled.sh toggleterm -N
niri msg action consume-or-expel-window-left
ntf_dismiss_all
foottitled.sh dotfiles -ND ~/fes/dot helix
gtk-launch firefox
foottitled.sh voe -ND ~/iwm/voe yazi
foottitled.sh finances -N ov --status-line=false --follow-name ~/.local/share/magazine/J
foottitled.sh earnings -N earnings.fish
foottitled.sh loago-tracker -N fish -c loago_tracker
foottitled.sh receiver -N receiver.fish
playerctld daemon
gtk-launch anki
niri msg action spawn -- Todoist.AppImage
make-em-shut-up.nu
