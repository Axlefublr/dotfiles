#!/usr/bin/env fish

systemctl --user restart kanata.service
playerctld daemon
wlr-randr --output HDMI-A-1 --mode 1920x1080@100.003998

floorp & disown
foot -D ~/fes/dot & disown
