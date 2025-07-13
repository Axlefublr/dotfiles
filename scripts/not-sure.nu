#!/usr/bin/env -S nu -n --no-std-lib

const alphabet = [a b c d e f g h i j k l m n o p q r s t u v w x y z]
const pleasantries = {
	a: [b c d f g h i k l m n o p q r s t u v w x y]
	b: [a i l o r s u w y]
	c: [a e h i k l o r s t u x y]
	d: [a e h i l m n o r s t u v w y]
	e: [a c d f g h i k l m n p q r s t u w x y z]
	f: [a e i l o r s u w y]
	g: [a d e h i l m n o r s u v w y]
	h: [a e f g i k l m n o r s u v w y]
	i: [c d e f g j k l m n p q r s t v w x z]
	j: [a d e i o r s u y]
	k: [a d e h i l o r s u v w y]
}
