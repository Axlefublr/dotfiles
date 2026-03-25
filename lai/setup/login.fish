#!/usr/bin/env fish

fcf.nu fix
cat ~/fes/uviw/afen/sudo | sudo -S modprobe uinput
systemctl --user restart kanata.service

niri msg action focus-workspace main
gtk-launch firefox
footclient -NT toggleterm
footclient -NT dotfiles -D ~/fes/dot helix
niri msg action move-column-to-last
footclient -NT finances helix ~/ake/finances
footclient -NT earnings earnings.fish
footclient -NT abilities abilities.fish
footclient -NT loago-tracker fish -c loago_tracker
footclient -NT calcure calcure
footclient -NT receiver receiver.fish
gtk-launch anki
playerctld daemon
footclient -NT voe -D ~/iwm/voe yazi
