#!/usr/bin/env -S nu -n --no-std-lib

const switch = {
	' ': 'spc'
	'1': 'Digit1'
	'2': 'Digit2'
	'3': 'Digit3'
	'4': 'Digit4'
	'5': 'Digit5'
	'6': 'Digit6'
	'7': 'Digit7'
	'8': 'Digit8'
	'9': 'Digit9'
	'0': 'Digit0'
	'→': 'tab 40'
	'_': 'S-(10 min)'
}

def main [--active, ...args] {
	if $active {
		active
	} else {
		$args | eval
	}
}

def active [] {
	^propose.rs etg-active-items 50% ~/ake/etg-active-items
	| str trim
	| prepend 'give'
	| str join ' '
	| eval
}

def eval []: [
	list<string> -> nothing
	string -> nothing
] {
	print -n '(` 40 '
	$in | each {
		$in
		| split chars
		| each { |chr|
			try { $switch | get $chr } catch { $chr }
		}
		| append 'enter 20'
		| str join ' '
	}
	| append ''
	| str join ' '
	| print -n
	print -n 'esc)'
}
