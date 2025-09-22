#!/usr/bin/env fish

cat ~/fes/uviw/fux/sudo | sudo -S modprobe uinput
systemctl --user restart kanata.service
fcf.nu fix
playerctld daemon
# wlr-randr --output HDMI-A-1 --mode 1920x1080@100.003998

foot -D ~/fes/dot & disown
gtk-launch floorp
