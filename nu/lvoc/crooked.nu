source always.nu
$env.config.table.mode = 'compact'
$env.config.hooks.display_output = 'if (term size).columns >= 100 { table -e -w 128 } else { table -w 128 }'
alias shr = path shrink
alias exp = path expand
alias dn = date now date

def wind --wrapped [...args] {
	footclient -N ...$args
}

def sand --wrapped [...args] {
	footclient -HN ...$args
}

def queue --wrapped [...args] {
	pueue add -g cpu -- ($args | str join ' ') o+e>| ignore
}

def fox [] {
	default -e false | if not $in { exit 1 }
}

def lh [] {
	str replace 'github.com' 'raw.githubusercontent.com'
	| str replace 'blob' 'refs/heads'
}

def html_spaces [] {
	str replace -a ' ' '&nbsp;'
}

def html_special [] {
	str replace -a '&' '&amp;'
	| str replace -a '<' '&lt;'
	| str replace -a '>' '&gt;'
	| str replace "\n" '<br>'
}
