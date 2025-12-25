#!/usr/bin/env -S nu -n --no-std-lib

const grabber = '(cmd wtype '

def fint [] {
	$in | str join | print
	print ''
	$in
}

let potential_men = open ~/fes/dot/kanata/symbol.kbd
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
