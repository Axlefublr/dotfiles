#!/usr/bin/env fish

not test -p ~/fes/zufi/waybar-screen-record && mkfifo ~/fes/zufi/waybar-screen-record
tail -f ~/fes/zufi/waybar-screen-record
