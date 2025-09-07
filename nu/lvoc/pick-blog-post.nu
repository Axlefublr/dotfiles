#!/usr/bin/env -S nu -n --no-std-lib

let the = ls ~/fes/lai/bog/content/*.md
| interleave { ls ~/fes/lai/bog/content/*/index.md }
| sort-by -r modified
| get name
| each { |$it|
	let basename = $it | path basename
	let name = if ($basename == index.md) {
		$it | path dirname | path basename
	} else {
		$basename
	}
	| str replace -r '.md$' ''
	| str replace -a '-' ' '
	{ path: $it, name: $name }
}
let index = $the | get name | to text | fuzzel -d --index
let path  = $the | get path | get ($index | into int)
footclient -ND ~/fes/lai/bog helix $path
