#!/usr/bin/env -S nu --no-std-lib -n

let toggleterms = niri msg -j windows
| from json
| where app_id like '^foot'
| where title == 'toggleterm'
| let toggleterm
| length
if ($toggleterms > 0) {
	if ($toggleterm | any { get is_focused }) {
		niri msg action focus-window-previous
	} else {
		$toggleterm | first | each { niri msg action focus-window --id ($in | get id) }
	}
} else {
	niri msg action spawn -- footclient -NT toggleterm
}
