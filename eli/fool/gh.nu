#!/usr/bin/env -S nu -n --no-std-lib

def --wrapped main [...rest] {
	^gh ...$rest
}

def --wrapped 'main repo clone' [url: string, --dir(-d): directory, --shallow(-s), ...rest] {
	let dir = $dir | default ($url | path basename)
	let rest = $rest | shallow include $shallow
	^gh repo clone $url $dir ...$rest
	# shallow enqueue $shallow $dir
	$dir | commit
}

def --wrapped 'main repo create' [name: string, ...rest] {
	^gh repo create --clone -l MIT $name ...$rest
	$name | commit
}

def --wrapped 'main repo fork' [url: string, --dir(-d): directory, --shallow(-s), ...rest] {
	let dir = $dir | default ($url | path basename)
	let rest = $rest | shallow include $shallow
	^gh repo fork --clone --default-branch-only $url --fork-name $dir ...$rest
	# shallow enqueue $shallow $dir
	$dir | commit
}

def commit [] {
	save -f /tmp/mine/github-directory
}

def 'shallow include' [shallow: bool]: list<string> -> list<string> {
		if $shallow {
			if ($in | where $it == '--' | length | $in > 0) {
				$in | append ['--depth=1']
			} else {
				$in | append ['--' '--depth=1']
			}
		} else {
			$in
		}
}

def 'shallow enqueue' [shallow: bool, dir: directory] {
	pueue add -w ($env.PWD | path join $dir) -g network -- 'git fetch --unshallow'
}
