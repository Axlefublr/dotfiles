#!/usr/bin/env fish

fcf.nu fix
cat ~/fes/uviw/afen/sudo | sudo -S modprobe uinput
systemctl --user restart kanata.service
playerctld daemon

foot -D ~/fes/dot & disown
gtk-launch floorp
