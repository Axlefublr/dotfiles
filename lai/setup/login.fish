#!/usr/bin/env fish

fcf.nu fix
cat ~/fes/uviw/afen/sudo | sudo -S modprobe uinput
systemctl --user restart kanata.service

niri msg action focus-workspace main
gtk-launch firefox
footclient -NT toggleterm
footclient -NT dotfiles -D ~/fes/dot helix
niri msg action move-column-to-last
footclient -NT voe -D ~/iwm/voe yazi
footclient -NT finances ov --status-line=false --follow-name ~/.local/share/magazine/J
footclient -NT earnings earnings.fish
footclient -NT abilities abilities.fish
footclient -NT loago-tracker fish -c loago_tracker
footclient -NT receiver receiver.fish
playerctld daemon
gtk-launch anki
niri msg action spawn -- Todoist.AppImage
