#!/usr/bin/env fish

# pueue add -g s 'RUST_LOG=debug axleizer'

fc
pueue restart -g s
playerctld daemon
xremap ~/r/dot/xremap.yml & disown
wlr-randr --output HDMI-A-1 --mode 1920x1080@75

footclient -D ~/r/dot & disown
firefox & disown
