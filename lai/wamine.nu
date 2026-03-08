#!/usr/bin/env -S nu -n --no-std-lib

loago do wamine
let then = (date now) + 1hr + 40min
notify-send 'wamine started'
loop {
	if ($then <= (date now)) { break }
	sleep 1sec
}
"wamine\n" | save -a ~/.local/share/magazine/0
