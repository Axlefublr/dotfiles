#!/usr/bin/env fish

fcf.nu fix
cat ~/fes/uviw/afen/sudo | sudo -S modprobe uinput
systemctl --user restart kanata.service

niri msg action focus-workspace one
foot -ND ~/fes/dot
gtk-launch firefox
playerctld daemon
foot -NT abilities abilities.fish
foot -NT loago-tracker fish -c loago_tracker
foot -NT calcure calcure
gtk-launch anki
