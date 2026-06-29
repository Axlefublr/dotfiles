#!/usr/bin/env fish

not test -p ~/fes/zufi/waybar-mouse-mode && mkfifo ~/fes/zufi/waybar-mouse-mode
tail -f ~/fes/zufi/waybar-mouse-mode
