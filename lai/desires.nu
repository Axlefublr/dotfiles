#!/usr/bin/env -S nu --no-std-lib -n

use always.nu 'date now date'

def 'main' [] {}

def 'main output' [] {
	open ~/.local/share/magazine/V
	| lines
	| parse '{date} {spending}'
	| update cells -c [date] {
		into datetime -f '%y.%m.%d'
	}
	| update cells -c [spending] { into int }
	| where date > (date now | $in - 30day)
	| get spending
	| math sum
}

def 'main input' [...amounts: int] {
	if ($amounts | is-empty) { return }
	let total = $amounts | math sum
	let date = date now date
	$'($date) ($total)'
}
