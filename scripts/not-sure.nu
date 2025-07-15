#!/usr/bin/env -S nu -n --no-std-lib

const alphabet = [a b c d e f g h i j k l m n o p q r s t u v w x y z]
const pleasantries = {
	a: [  b c d   f   h i j k l m n o         u v      ]
	b: [a   c d e f g         l     o q r s t   v w x z]
	c: [  b           h i j k l m n o     s   u v   x z]
	d: [  b       f   h i j k l m n o     s   u   w    ]
	e: [  b       f   h i j k l m n o   r   t u v      ]
	f: [  b     e     h i j k l m n o     s   u   w    ]
	g: [  b           h i j k l m n o         u        ]
	h: [a   c d e f g   i     l     o q r s t   v w x z]
	i: [a   c d e f g     j     m n   q r s t   v w x z]
	j: [a   c d e f g         l     o q r s t   v w x z]
}
