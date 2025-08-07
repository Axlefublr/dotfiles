#!/usr/bin/env -S nu -n --no-std-lib

def main [] {}

def 'main help' [] {
	let input = open ~/.local/share/magazine/c-comma | lines | reverse | to text | ^fuzzel -d --match-mode exact --cache ~/.cache/mine/help-frecency
	^indeed.rs -u ~/.local/share/magazine/c-comma $input
	^footclient -N -- ov -e -- ...($input | split row -r '\s+') --help
}

def 'main man' [] {
	touch ~/.cache/mine/man-list
	let input = open ~/.cache/mine/man-list | ^fuzzel -d --match-mode fzf --cache ~/.cache/mine/man-frecency | complete | get stdout | str trim
	if ($input | is-empty) {
		men
		return
	}
	let manpage = try {
		$input | parse '{name} ({section})' | $in.name.0 + '.' + $in.section.0
	} catch {
		$input
	}
	^footclient -N -- man.fish $manpage
	men
}

def men [] {
	^man -k .
	| parse -r '(?P<name>\S+ \([1-9]p?\)) +- \S'
	| get name
	| interleave { ^fish -c 'builtin -n' | lines | where $it not-in [':', '.', '[', '_'] }
	| to text
	| save -f ~/.cache/mine/man-list
}
