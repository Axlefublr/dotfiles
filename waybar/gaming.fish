#!/usr/bin/env fish

not test -p ~/fes/zufi/waybar-gaming && mkfifo ~/fes/zufi/waybar-gaming
tail -f ~/fes/zufi/waybar-gaming
