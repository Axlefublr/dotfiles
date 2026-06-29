#!/usr/bin/env -S nu -n --no-std-lib

def main [] {}

def 'main help' [] {
	let input = open ~/.local/share/magazine/c-comma | lines | reverse | to text | ^fuzzel -d --match-mode exact --cache ~/fes/zufi/help-frecency
	^indeed.rs -u ~/.local/share/magazine/c-comma $input
	let args = ($input | split row -r '\s+')
	help.fish ...$args
}

def 'main man' [] {
	let input = open ~/fes/zufi/man-list | ^fuzzel -d --match-mode fzf --cache ~/fes/zufi/man-frecency
	let the = try {
		$input | parse '{name} (fish)' | $in.name.0 | { manpage: $in, section: fish, should_fish: true }
	} catch {
		try {
			$input | parse '{name} ({section})' | { manpage: $in.name.0, section: $in.section.0 should_fish: false }
		} catch {
			{ manpage: $input, section: '', should_fish: true }
		}
	}
	man.fish $the.manpage $the.section $the.should_fish
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
	mv -f /tmp/mine/man-atomic ~/fes/zufi/man-list
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
	| fuzzel -d --match-mode fzf --cache ~/fes/zufi/nushell-frecency
	let input = try {
		$input | parse '{name} ({search_terms})' | get name.0
	} catch {
		$input
	}
	let title = $'nushell ($input)'
	let found = niri msg -j windows | from json
	| where app_id starts-with foot
	| where title == $title
	if ($found | is-empty) {
		niri msg action spawn -- footclient -NT $title -- nu --no-std-lib --config ~/fes/dot/nu/nonf.nu -c $'help ($input) | ov --wrap=true --caption=`($input)`'
	} else {
		niri msg action focus-window --id ($found | get id | first)
	}
}
