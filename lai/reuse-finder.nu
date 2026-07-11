#!/usr/bin/env -S nu --no-std-lib -n

def main [path: path] {
	let title = $path | path basename
	let found = niri msg -j windows
	| from json
	| where is_focused == true
	| where app_id starts-with foot
	| where title starts-with $title
	if ($found | is-empty) {
		# setting the title *only* for window ruling purposes; otherwise I *do* want titling logic to go on as normal
		# TIT is for specifying a *static* title
		niri msg action spawn -- footclient -T $'($title) finder' -o environment.FIX_WIDTH=true -ND $path fish -c $'finder ($path)'
	} else {
		wtype -k F4 # to trigger `finder` from the helix I confirmed I'm looking at
	}
}
