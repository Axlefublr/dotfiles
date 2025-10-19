#!/usr/bin/env fish

cat ~/fes/uviw/afen/sudo | sudo -S modprobe uinput
systemctl --user restart kanata.service
fcf.nu fix
playerctld daemon

foot -D ~/fes/dot & disown
gtk-launch floorp
