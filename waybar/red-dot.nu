#!/usr/bin/env -S nu -n --no-std-lib

const symbol = ''
const flashing_speed = 130ms
const flashes_count = 5

tail -f ~/.local/share/mine/waybar-red-dot
| each {
	for _ in (seq 1 $flashes_count) {
		print $symbol
		sleep $flashing_speed
		print ''
		sleep $flashing_speed
	}
}
| ignore
