#!/usr/bin/env fish

# pueue add -g s 'RUST_LOG=debug axleizer'

xremap ~/r/dot/xremap.yml & disown
wlr-randr --output HDMI-A-1 --mode 1920x1080@75

kitty -d ~/r/dot & disown
firefox & disown

playerctld daemon

sleep 10
pueue restart -g s
