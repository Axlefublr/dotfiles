source duh.nu
$env.config.table.mode = 'compact'
$env.config.hooks.display_output = 'if (term size).columns >= 100 { table -e -w 128 } else { table -w 128 }'

def 'hxm rotate sectioning' []: string -> string {
	let IN = $in
	if ($IN | str substring 0..3) == '┃ ' {
		['┗ '] ++ [($IN | str substring 4..)]
		| str join
	} else if ($IN | str substring 0..3) == '┗ ' {
		$IN
		| str substring 4..
	} else {
		['┃ '] ++ [$IN]
		| str join
	}
}
