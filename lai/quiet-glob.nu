#!/usr/bin/env -S nu -n --no-std-lib

def main [glob: glob] {
	try { ls $glob | sort-by -r modified | get name | to text }
}
