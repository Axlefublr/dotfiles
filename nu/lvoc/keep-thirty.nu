#!/usr/bin/env -S nu -n --no-std-lib

[
	~/iwm/sco
	~/wlx/tabs
] | each {
	path expand
	| ls $in
	| where ((date now) - $it.modified) > 30day
	| get name
	| try { rm -prv ...$in }
}
