#!/usr/bin/env -S nu --no-std-lib -n

def main [path: path] {
	let title = $path | path basename
	let found = niri msg --json windows
	| from json
	| where app_id starts-with foot
	| where title == $title
	if ($found | is-empty) {
		niri msg action spawn -- foottitled.sh $title -ND $path fish -c $'finder ($path)'
	} else {
		if ($found | where is_focused == true | is-not-empty) {
			wtype -k F3
		} else {
			niri msg action focus-window --id ($found | get -o id | first)
		}
	}
}
