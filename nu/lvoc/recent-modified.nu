#!/usr/bin/env -S nu -n --no-std-lib

def main [dir: directory = '.', --number(-n): int = 1] {
	ls $dir | sort-by -r modified | first $number | get name | to text | str trim
}
