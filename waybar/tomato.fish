#!/usr/bin/env fish

not test -p ~/fes/zufi/waybar-tomato && mkfifo ~/fes/zufi/waybar-tomato
tail -f ~/fes/zufi/waybar-tomato
