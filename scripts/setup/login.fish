#!/usr/bin/env fish

pueue restart -g s
playerctld daemon
wlr-randr --output HDMI-A-1 --mode 1920x1080@100.003998

floorp & disown
footclient -D ~/r/dot & disown
