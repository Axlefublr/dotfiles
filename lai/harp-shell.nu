#!/usr/bin/env -S nu -n --no-std-lib

let columns = (term size).columns
let command_columns = $columns - 6
$env.config.hooks.display_output = $'table -w ($columns)'

def main [section: string] {
	try {
		open ~/.local/share/harp/harp.jsonc
		| from json
		| get $section
		| transpose register command
		| rename reg command
		| compact -e command
		| update cells -c [command] { |the|
			$the.0
			| str trim
			| lines
			| each { str trim }
			| str join '  '
			| split chars
			| take $command_columns
			| str join ''
		}
		| compact -e command
		| sort-by reg
		| table -i false
	}
}
