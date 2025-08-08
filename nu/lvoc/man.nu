#!/usr/bin/env -S nu -n --no-std-lib

def main [] {}

def 'main help' [] {
	let input = open ~/.local/share/magazine/c-comma | lines | reverse | to text | ^fuzzel -d --match-mode exact --cache ~/.cache/mine/help-frecency
	^indeed.rs -u ~/.local/share/magazine/c-comma $input
	^footclient -N -- ov -e -- ...($input | split row -r '\s+') --help
}

def 'main man' [] {
	let input = open ~/.cache/mine/man-list | ^fuzzel -d --match-mode fzf --cache ~/.cache/mine/man-frecency
	let manpage = try {
		$input | try {
			parse '{name} (fish)' | $in.name.0
		} catch {
			parse '{name} ({section})' | $in.name.0 + '.' + $in.section.0
		}
	} catch {
		$input
	}
	^footclient -N -- man.fish $manpage
}

def 'main men' [] {
	^man -k .
	| parse -r '(?P<name>\S+ \([1-9]p?\)) +- \S'
	| get name
	| interleave { ^fish -c 'builtin -n' | lines | where $it not-in [':', '.', '[', '_'] | par-each { $in + ' (fish)' } }
	| to text
	| save -f /tmp/mine/man-atomic
	mv -f /tmp/mine/man-atomic ~/.cache/mine/man-list
	^fish -c dot
}

def 'main nushell' [] {
	let input = scope commands
	| select name search_terms
	| par-each {
		if ($in.search_terms | is-empty) {
			$in.name
		} else {
			$in.name + ' (' + $in.search_terms + ')'
		}
	}
	| to text
	| fuzzel -d --match-mode fzf --cache ~/.cache/mine/nushell-frecency
	^footclient -N -- nu --no-std-lib --config ~/fes/dot/nu/nonf.nu -c $'($input) --help | ov --wrap=true --caption=`($input)`'
}
