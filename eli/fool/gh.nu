#!/usr/bin/env -S nu -n --no-std-lib

def --wrapped main [...rest] {
	^gh ...$rest
}

def --wrapped 'main repo clone' [url: string, --dir(-d): directory, --shallow(-s), ...rest] {
	let dir = $dir | default ($url | path basename)
	let rest = $rest | shallow include $shallow
	try { gh repo clone (expand-me $url) $dir ...$rest }
	# shallow enqueue $shallow $dir
	$dir | commit
}

def --wrapped 'main give' [url: string = '', ...rest] {
	cd ~/fes/ork/duc
	main repo clone ($url | default -e (wl-paste -n)) -s ...$rest
}

def --wrapped 'main repo create' [name: string, ...rest] {
	^gh repo create --clone -l MIT $name ...$rest
	$name | commit
}

def --wrapped 'main repo fork' [url: string, --dir(-d): directory, --shallow(-s), ...rest] {
	let dir = $dir | default ($url | path basename)
	let rest = $rest | shallow include $shallow
	^gh repo fork --clone --default-branch-only (expand-me $url) --fork-name $dir ...$rest
	# shallow enqueue $shallow $dir
	$dir | commit
}

def commit [] {
	$env.PWD + '/' + $in | save -f /tmp/mine/github-directory
}

def expand-me [url: string] {
	$url
	| path split
	| each {
		if $in == '@' {
			'Axlefublr'
		} else if $in ends-with ':' {
			$in + '/'
		} else { $in }
	}
	| str join /
	| tee { print -ne ($in + "\n") }
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
