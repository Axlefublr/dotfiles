#!/usr/bin/env -S nu -n --no-std-lib

def main [dir: string = '.', --number(-n): int = 1] {
	ls ($dir | into glob) | sort-by -r modified | first $number | get name | to text | str trim
}
