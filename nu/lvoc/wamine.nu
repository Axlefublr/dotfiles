#!/usr/bin/env -S nu -n --no-std-lib

let then = (date now) + 2hr
notify-send 'wamine started'
loop {
	if ($then <= (date now)) { break }
	sleep 1sec
}
let text = open ~/.local/share/magazine/0 | str trim
if ($text | is-empty) {
	"wamine\n" | save -f ~/.local/share/magazine/0
} else {
	$text + " wamine\n" | save -f ~/.local/share/magazine/0
}
