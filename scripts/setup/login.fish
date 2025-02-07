#!/usr/bin/env fish

# playerctld daemon
# copyq & disown

# pueue add -g s 'RUST_LOG=debug axleizer'

xremap ~/r/dot/xremap.yml & disown

wlr-randr --output HDMI-A-1 --mode 1920x1080@75

kitty -T editor -d ~/r/dot & disown
firefox & disown
niri msg action do-screen-transition -d 1000

xwayland-satellite & disown

loopuntil is_internet 0.5 0 60
pueue restart -g s
