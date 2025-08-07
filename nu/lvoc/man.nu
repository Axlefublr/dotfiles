#!/usr/bin/env -S nu -n --no-std-lib

def main [] {}

def 'main help' [] {
	let input = open ~/.local/share/magazine/c-comma | lines | reverse | to text | ^fuzzel -d --match-mode exact --cache ~/.cache/mine/help-frecency
	if $input == null { return }
	^indeed.rs -u ~/.local/share/magazine/c-comma $input
	^footclient -N -- ov -e -- ...($input | split row -r '\s+') --help
}

def 'main man' [] {
	let input = ^man -k . | parse -r '(?P<name>\S+ \(\S+\)) +- \S' | get name | to text | ^fuzzel -d --match-mode fzf --cache ~/.cache/mine/man-frecency
	if $input == null { return }
	let manpage = try {
		$input | parse '{name} ({section})' | $in.name.0 + '.' + $in.section.0
	} catch {
		$input
	}
	^footclient -N -- man.fish $manpage
}
