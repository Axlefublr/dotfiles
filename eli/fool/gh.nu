#!/usr/bin/env -S nu -n --no-std-lib

def --wrapped main [...rest] {
	^gh ...$rest
}

def --wrapped 'main repo clone' [url: string, --dir(-d): directory, ...rest] {
	let dir = $dir | default ($url | path basename)
	^gh repo clone $url $dir ...$rest
	$dir | save -f /tmp/mine/github-directory
}

def --wrapped 'main repo create' [name: string, ...rest] {
	^gh repo create --clone -l MIT $name ...$rest
	$name | save -f /tmp/mine/github-directory
}

def --wrapped 'main repo fork' [url: string, --dir(-d): directory, ...rest] {
	let dir = $dir | default ($url | path basename)
	^gh repo fork --clone --default-branch-only $url --fork-name $dir ...$rest
	$dir | save -f /tmp/mine/github-directory
}
