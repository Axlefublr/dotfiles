#!/usr/bin/env -S nu -n --no-std-lib

def main [] {}

export def 'main binary-name' [] {
	cargo metadata --no-deps --format-version 1
	| from json
	| get packages.targets.0
	| where kind == [bin]
	| get name.0
}

def 'main inc' [the] { main increment $the }
export def 'main increment' [bigness: string] {
	if [major minor patch] not-has $bigness { exit 1 }
	let cargo = open Cargo.toml
	let new_version = $cargo
	| get package.version
	| split row '.'
	| { major: $in.0, minor: $in.1, patch: $in.2 }
	| update $bigness { ($in | into int) + 1 }
	| if $bigness == major {
		merge { minor: 0, patch: 0 }
	} else if $bigness == minor {
		merge { patch: 0 }
	} else { $in }
	| $'($in.major).($in.minor).($in.patch)'
	# doing this the stupid way to avoid messing up the formatting
	sd -n 1 '^version = .*' $'version = "($new_version)"' Cargo.toml
	rg -N -m 1 -B 2 -A 1 '^version =' Cargo.toml
}

export def 'main pollinate' [] {
	let horse = open Cargo.toml
	let name = $horse | get package.name
	let repo = $'https://github.com/Axlefublr/($name)'
	$horse | merge deep {
		package: {
			version: '0.0.1'
			authors: [ Axlefublr ]
			license: MIT
			description: ''
			readme: README.md
			homepage: $repo
			repository: $repo
		}
	}
	| save -f Cargo.toml
}
