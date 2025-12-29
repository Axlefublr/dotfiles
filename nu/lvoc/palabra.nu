#!/usr/bin/env -S nu -n --no-std-lib


def main [] {
	let potential_men = potential_men
	| prepend (['[' ']' ';' "'" ',' '.' / '{' '}' : '"' < > ? ! @ '#' '$' % ^ '*' '(' ')' - _ = + '`' '|' '\'])
	| prepend ([a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z '0' '1' '2' '3' '4' '5' '6' '7' '8' '9'])

	loop {
		let thingy = $potential_men | shuffle | first
		print "\n\n\n\n\n\n\n\n"
		loop {
			let input = input -n ($thingy | str length) ($thingy + ' ')
			if ($input == $thingy) {
				break
			}
		}
		clear
	}
}

def 'main list' [] {
	potential_men | str join
}

def potential_men [] {
	const grabber = '(cmd wtype '
	open ~/fes/dot/kanata/symbol.kbd
	| lines
	| where ($it | str contains $grabber)
	| each { |line|
		let start_index = $line
		| str index-of $grabber
		| $in + ($grabber | str length)
		$line
		| str substring $start_index..
		| str trim -rc ')'
	}
}

def fint [] {
	$in | str join | print
	print ''
	$in
}
