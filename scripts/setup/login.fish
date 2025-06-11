#!/usr/bin/env fish

systemctl --user restart kanata.service
pueue restart -g s
playerctld daemon
wlr-randr --output HDMI-A-1 --mode 1920x1080@100.003998

floorp & disown
footclient -D ~/fes/dot & disown
