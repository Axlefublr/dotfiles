#!/usr/bin/env -S nu --no-std-lib -n

let stored_colors = '~/fes/dot/colors.nuon' | path expand

def main [] {}

def 'main list' [] {
	$env.config.color_config.leading_trailing_space_bg = {}
	open $stored_colors
	| transpose name value
	| flatten # name, hex, hsl, rgb
	| upsert z '│'
	| move z --after name
	| upsert y '│'
	| move y --after hex
	| upsert x '│'
	| move x --after hsl
	| rename a z b y c x d
	| table -t none -i false
	| to text
	| lines
	| skip 1
	| to text
}

def 'main resolve' [color] {
	let color = $color | into string
	$color | if ($in | str contains '|') {
		split row ' | ' | skip 1 | first
	} else {}
}

def 'main write' [color, name] {
	let color = $color | str substring 1..-2 # I need to hack because for some odd reason passing an argument that starts with `#` to nushell makes it consider a comment 💀
	open $stored_colors
	| merge {
		$name: {
			hex: (pastel format hex -- $color)
			hsl: (pastel format hsl -- $color)
			rgb: (pastel format rgb -- $color)
		}
	}
	| collect
	| to nuon -cpt 1
	| save -f $stored_colors
}
