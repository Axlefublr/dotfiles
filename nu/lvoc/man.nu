#!/usr/bin/env -S nu -n --no-std-lib

const fish_builtin_functions = [
	# [[sort on]]
	'fish_opt'
	'psub'
	'trap'
	# [[sort off]]
]

def main [] {}

def 'main help' [] {
	let input = open ~/.local/share/magazine/c-comma | lines | reverse | to text | ^fuzzel -d --match-mode exact --cache ~/.cache/mine/help-frecency
	^indeed.rs -u ~/.local/share/magazine/c-comma $input
	let args = ($input | split row -r '\s+')
	^footclient -N -- ov --caption $input -e -- ...$args --help
}

def 'main man' [] {
	let input = open ~/.cache/mine/man-list | ^fuzzel -d --match-mode fzf --cache ~/.cache/mine/man-frecency
	let the = try {
		$input | parse '{name} (fish)' | $in.name.0 | { manpage: $in, should_fish: true }
	} catch {
		try {
			$input | parse '{name} ({section})' | $in.name.0 + '.' + $in.section.0 | { manpage: $in, should_fish: false }
		} catch {
			{ manpage: $input, should_fish: true }
		}
	}
	^footclient -N -- man.fish $the.manpage $the.should_fish
}

def 'main men' [] {
	^man -k .
	| parse -r '(?P<name>\S+ \([1-9]p?\)) +- \S'
	| get name
	| interleave {
		ls /usr/share/fish/man/man1/*.1
		| get name
		#                           trimming `.1`
		| each { path basename | str substring 0..-3 | $in + ' (fish)' }
	}
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
	let input = try {
		$input | parse '{name} ({search_terms})' | get name.0
	} catch {
		$input
	}
	^footclient -N -- nu --no-std-lib --config ~/fes/dot/nu/nonf.nu -c $'($input) --help | ov --wrap=true --caption=`($input)`'
}
