#!/usr/bin/env -S nu -n --no-std-lib

[
	[path         , delta];
	[/tmp/mine    , 2day ]
	[~/fes/ork/duc, 10day ]
	[~/iwm/sco    , 30day]
	[~/wlx        , 5day ]
	[~/wlx/tabs   , 7day ]
] | each {
	let IN = $in
	ls ($IN.path | path expand)
	| where ((date now) - $it.modified) >= $IN.delta
	| get name
	| try { rm -prv ...$in }
} | ignore
