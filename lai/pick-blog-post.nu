#!/usr/bin/env -S nu -n --no-std-lib

let the = ls ~/fes/ork/hirl/content/*.md
| interleave { ls ~/fes/ork/hirl/content/*/index.md }
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
	| if (open $it | find 'draft = true' | length | $in >= 1) { $in + ' (draft)' } else { $in }
	{ path: $it, name: $name }
}
let index = $the | get name | to text | fuzzel -d --index
let path  = $the | get path | get ($index | into int)
footclient -ND ~/fes/ork/hirl helix $path
