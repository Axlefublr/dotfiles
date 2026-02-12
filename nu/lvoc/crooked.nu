source always.nu

$env.config.table.mode = 'compact'
$env.config.hooks.display_output = 'if (term size).columns >= 100 { table -e -w 128 } else { table -w 128 }'

alias shr = path shrink
alias exp = path expand
alias dn = date now date
alias html_spaces = str replace -a ' ' '&nbsp;'
alias html_special = str replace -a '&' '&amp;' | str replace -a '<' '&lt;' | str replace -a '>' '&gt;' | str replace "\n" '<br>'

def fox [] {
	default -e false | if not $in { exit 1 }
}
