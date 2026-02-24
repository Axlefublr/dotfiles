#!/usr/bin/env fish

fcf.nu fix
cat ~/fes/uviw/afen/sudo | sudo -S modprobe uinput
systemctl --user restart kanata.service
playerctld daemon

niri msg action focus-workspace one
foot -ND ~/fes/dot
gtk-launch firefox
