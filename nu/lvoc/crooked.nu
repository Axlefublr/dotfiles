source duh.nu
$env.config.table.mode = 'compact'
$env.config.hooks.display_output = 'if (term size).columns >= 100 { table -e -w 128 } else { table -w 128 }'

def 'hx-blammo' [full_path: path, relative_path: path, buffer_parent: directory, selection: string] {
	$full_path | str replace -r '^~' $env.HOME | save -f ~/.cache/mine/blammo
	$relative_path | str replace -r '^~' $env.HOME | save -f ~/.cache/mine/blammo-relative
	$buffer_parent | str replace -r '^~' $env.HOME | save -f ~/.cache/mine/blammo-parent
	$selection | save -f ~/.cache/mine/blammo-selection
}

def 'hx-replace' []: string -> string {
	let the = $in | str length
	let input = fuzzel -dl 0
	$input | fill -w $the
}

def 'format color hex' []: string -> string {
	pastel format hex $in
}

def 'format color hsl' []: string -> string {
	pastel format hsl $in
}

def 'format color rgb' []: string -> string {
	pastel format rgb $in
}
