#!/usr/bin/env -S nu -n --no-std-lib

const alphabet = [a b c d e f g h i j k l m n o q r s t u v w x z]
const pleasantries = {
	a: [  b c d   f   h i j k l m n o         u v      ]
	b: [a   c d e f g         l     o   r s     v w   z]
	c: [  b           h i j k l m n o     s   u v   x z]
	d: [  b           h i j k l m n o     s   u   w    ]
	e: [  b       f   h i j k l m n o   r   t u v      ]
	f: [  b     e     h i j k l m n o     s   u   w    ]
	g: [              h i j k l m n o                  ]
	h: [a   c d e f g   i           o q r s t   v w x z]
	i: [a   c d e f g     j     m n   q r s t   v w x z]
	j: [a   c d e f g         l     o q r s t   v w x z]
	k: [a   c d e f       j     m n   q r s t   v w x z]
	l: [a   c d e f g   i j     m     q r s t   v w x  ]
	m: [a   c d e f g       k l     o q r s t   v w x z]
	n: [a   c d e f g   i     l       q r s t   v w x z]
	o: [a   c d e f g     j           q r s t   v w x z]
	q: [          f   h i j k l m n o   r     u        ]
	r: [  b           h i j k l m n o         u   w    ]
	s: [  b   d   f   h i j k l m n o         u        ]
	t: [  b             i j k l m n o         u        ]
	u: [a   c d e f g         l   n o   r s t   v w x z]
	v: [a b           h i j k l m n o     s   u   w x z]
	w: [  b       f   h i j k l m n o   r     u        ]
	x: [  b           h i j k l m n o         u        ]
	z: [  b c     f   h i j k l m n o         u     x  ]
}

def main [--words(-w): int = 1, length: int = 5] {
	1..$words | each {
		let first_letter = $alphabet | random item
		[$first_letter] | amalgamate $length | str join
	} | to text
}

def 'random item' []: list<string> -> string {
	let input_list = $in
	let input_length = $input_list | length
	$input_list | get (random int 0..($input_length - 1))
}

def 'next' []: list<string> -> list<string> {
	let the = $in
	let last_character = $the | last
	let next_character = $pleasantries | get $last_character | random item
	$the ++ [$next_character]
}

def amalgamate [count: int]: list<string> -> list<string> {
	let the = $in
	if ($the | length) >= $count { return $the } else {
		$the | next | amalgamate $count
	}
}
