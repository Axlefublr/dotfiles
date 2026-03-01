#!/usr/bin/env fish

fcf.nu fix
cat ~/fes/uviw/afen/sudo | sudo -S modprobe uinput
systemctl --user restart kanata.service

niri msg action focus-workspace one
foot -T toggleterm & disown
foot -D ~/fes/dot & disown
gtk-launch firefox
playerctld daemon
footclient -NT abilities abilities.fish
footclient -NT loago-tracker fish -c loago_tracker
footclient -NT calcure calcure
footclient -NT bluetui bluetui
footclient -NT voe -D ~/iwm/voe yazi
gtk-launch anki
