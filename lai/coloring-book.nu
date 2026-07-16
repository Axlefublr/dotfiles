#!/usr/bin/env -S nu --no-std-lib -n

let stored_colors = '~/fes/dot/colors.nuon' | path expand

def main [] {}

def 'main list' [] {
	$env.config.color_config.leading_trailing_space_bg = {}
	$env.config.footer_mode = 'never'
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
	let new_data = open $stored_colors
	| merge {
		$name: {
			hex: (pastel format hex -- $color)
			hsl: (pastel format hsl -- $color)
			rgb: (pastel format rgb -- $color)
		}
	}
	let longest_name = $new_data
	| columns
	| each { str length }
	| default -e [1]
	| math max
	$new_data | items { |name, color|
		let name_part = $"'($name)': " | fill -w ($longest_name + 3)
		let hsl_part = $"'($color.hsl)'" | fill -w 26
		$"\t($name_part) { hex: '($color.hex)' hsl: ($hsl_part) rgb: '($color.rgb)' }"
	}
	| prepend '{'
	| append '}'
	| to text
	| save -f $stored_colors
}

def 'main all' [] {
	let stored_colors = open $stored_colors
	let longest_name = $stored_colors | columns | each { str length } | math max
	$stored_colors | items { |name, color|
		print -n ('' | fill -w (term size).columns)
		print -n "\r"
		print -n $"(ansi $color.hex)($name | fill -w $longest_name)(ansi rst)   "
		print $"(ansi -e { fg: '#282828', bg: $color.hex })($name)(ansi rst)"
	}
	| ignore
}

def 'main all count' [] {
	open $stored_colors
	| columns
	| length
	| $in + 1
}
