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
}

def main [--give, ...args] {
	print -n '(` 40 '
	$args | each { |arg|
		let the = $arg | split chars | each { |chr| try { $switch | get $chr } catch { $chr } } | str join ' '
		$"($the) enter 40"
	} | str join ' ' | print -n
	if $give {
		print -n ' g i v e spc'
	} else {
		print -n ' esc'
	}
	print -n ')'
}
