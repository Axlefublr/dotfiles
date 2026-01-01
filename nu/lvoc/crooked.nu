source always.nu
$env.config.table.mode = 'compact'
$env.config.hooks.display_output = 'if (term size).columns >= 100 { table -e -w 128 } else { table -w 128 }'

def wind --wrapped [...args] {
	footclient -N ...$args
}

def sand --wrapped [...args] {
	footclient -HN ...$args
}

def queue --wrapped [...args] {
	pueue add -g cpu -- ($args | str join ' ') o+e>| ignore
}
