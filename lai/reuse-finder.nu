#!/usr/bin/env -S nu --no-std-lib -n

def main [path: path] {
	let title = $path | path basename
	let found = niri msg -j windows
	| from json
	| where is_focused == true
	| where app_id starts-with foot
	| where title == $title
	if ($found | is-empty) {
		niri msg action spawn -- foottitled.sh $title -ND $path fish -c $'finder ($path)'
	} else {
		wtype -k F4 # to trigger `finder` from the helix I confirmed I'm looking at
	}
}
