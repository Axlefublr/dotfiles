#!/usr/bin/env python3

magazine_openers: dict[str, str] = {
    'q': ':open ~/.local/share/magazine/q',
    'w': ':open ~/.local/share/magazine/w',
    'e': ':open ~/.local/share/magazine/e',
    'r': ':open ~/.local/share/magazine/r',
    't': ':open ~/.local/share/magazine/t',
    'y': ':open ~/.local/share/magazine/y',
    'u': ':open ~/.local/share/magazine/u',
    'i': ':open ~/.local/share/magazine/i',
    'o': ':open ~/.local/share/magazine/o',
    'p': ':open ~/.local/share/magazine/p',
    '[': ':open ~/.local/share/magazine/leftbrace',
    ']': ':open ~/.local/share/magazine/rightbrace',
    'a': ':open ~/.local/share/magazine/a',
    's': ':open ~/.local/share/magazine/s',
    'd': ':open ~/.local/share/magazine/d',
    'f': ':open ~/.local/share/magazine/f',
    'g': ':open ~/.local/share/magazine/g',
    'h': ':open ~/.local/share/magazine/h',
    'j': ':open ~/r/dot/project.txt',
    'k': ':open ~/.local/share/magazine/k',
    'l': ':open ~/.local/share/magazine/l',
    ';': ':open ~/.local/share/magazine/semicolon',
    "'": ':open ~/.local/share/magazine/apostrophe',
    'z': ':open ~/.local/share/magazine/z',
    'x': ':open ~/.local/share/magazine/x',
    'c': ':open ~/.local/share/magazine/c',
    'v': ':open ~/.local/share/magazine/v',
    'b': ':open ~/.local/share/magazine/b',
    'n': ':open ~/.local/share/magazine/n',
    'm': ':open ~/.local/share/magazine/m',
    ',': ':open ~/.local/share/magazine/comma',
    '.': ':open ~/.local/share/magazine/period',
    '/': ':open ~/.local/share/magazine/slash',
    'Q': ':open ~/.local/share/magazine/Q',
    'W': ':open ~/.local/share/magazine/W',
    'E': ':open ~/.local/share/magazine/E',
    'R': ':open ~/.local/share/magazine/R',
    'T': ':open ~/.local/share/magazine/T',
    'Y': ':open ~/.local/share/magazine/Y',
    'U': ':open ~/.local/share/magazine/U',
    'I': ':open ~/.local/share/magazine/I',
    'O': ':open ~/.local/share/magazine/O',
    'P': ':open ~/.local/share/magazine/P',
    '{': ':open ~/.local/share/magazine/leftcurl',
    '}': ':open ~/.local/share/magazine/rightcurl',
    'A': ':open ~/.local/share/magazine/A',
    'S': ':open ~/.local/share/magazine/S',
    'D': ':open ~/.local/share/magazine/D',
    'F': ':open ~/.local/share/magazine/F',
    'G': ':open ~/.local/share/magazine/G',
    'H': ':open ~/.local/share/magazine/H',
    'J': ':open project.txt',
    'K': ':open ~/.local/share/magazine/K',
    'L': ':open ~/.local/share/magazine/L',
    ':': ':open ~/.local/share/magazine/colon',
    '"': ':open ~/.local/share/magazine/doublequote',
    'Z': ':open ~/.local/share/magazine/Z',
    'X': ':open ~/.local/share/magazine/X',
    'C': ':open ~/.local/share/magazine/C',
    'V': ':open ~/.local/share/magazine/V',
    'B': ':open ~/.local/share/magazine/B',
    'N': ':open ~/.local/share/magazine/N',
    'M': ':open ~/.local/share/magazine/M',
    'A-q': ':open ~/.local/share/magazine/a-q',
    'A-w': ':open ~/.local/share/magazine/a-w',
    'A-e': ':open ~/.local/share/magazine/a-e',
    'A-r': ':open ~/.local/share/magazine/a-r',
    'A-t': ':open ~/.local/share/magazine/a-t',
    'A-y': ':open ~/.local/share/magazine/a-y',
    'A-u': ':open ~/.local/share/magazine/a-u',
    'A-i': ':open ~/.local/share/magazine/a-i',
    'A-o': ':open ~/.local/share/magazine/a-o',
    'A-p': ':open ~/.local/share/magazine/a-p',
    'A-[': ':open ~/.local/share/magazine/a-leftbrace',
    'A-]': ':open ~/.local/share/magazine/a-rightbrace',
    'A-a': ':open ~/.local/share/magazine/a-a',
    'A-s': ':open ~/.local/share/magazine/a-s',
    'A-d': ':open ~/.local/share/magazine/a-d',
    'A-f': ':open ~/.local/share/magazine/a-f',
    'A-g': ':open ~/.local/share/magazine/a-g',
    'A-h': ':open ~/.local/share/magazine/a-h',
    'A-j': ':open ~/.local/share/magazine/a-j',
    'A-k': ':open ~/.local/share/magazine/a-k',
    'A-l': ':open ~/.local/share/magazine/a-l',
    'A-;': ':open ~/.local/share/magazine/a-semicolon',
    "A-'": ':open ~/.local/share/magazine/a-apostrophe',
    'A-z': ':open ~/.local/share/magazine/a-z',
    'A-x': ':open ~/.local/share/magazine/a-x',
    'A-c': ':open ~/.local/share/magazine/a-c',
    'A-v': ':open ~/.local/share/magazine/a-v',
    'A-b': ':open ~/.local/share/magazine/a-b',
    'A-n': ':open ~/.local/share/magazine/a-n',
    'A-m': ':open ~/.local/share/magazine/a-m',
    'A-,': ':open ~/.local/share/magazine/a-comma',
    'A-.': ':open ~/.local/share/magazine/a-period',
    'A-/': ':open ~/.local/share/magazine/a-slash',
    '<': ':open ~/.local/share/magazine/leftpointy',
    '>': ':open ~/.local/share/magazine/rightpointy',
    '?': ':open ~/.local/share/magazine/question',
    '0': ':open ~/.local/share/magazine/0',
    '1': ':open ~/.local/share/magazine/1',
    '2': ':open ~/.local/share/magazine/2',
    '3': ':open ~/.local/share/magazine/3',
    '4': ':open ~/.local/share/magazine/4',
    '5': ':open ~/.local/share/magazine/5',
    '6': ':open ~/.local/share/magazine/6',
    '7': ':open ~/.local/share/magazine/7',
    '8': ':open ~/.local/share/magazine/8',
    '9': ':open ~/.local/share/magazine/9',
}
