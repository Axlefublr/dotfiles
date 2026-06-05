#!/usr/bin/env -S nu -n --no-std-lib

const ignored = [
	# [[sort on]]
	eat
	# [[sort off]]
]

const known = {
	# disc: 15
	# floor: 7
	# keyboard: 30
	# liked: 15
	dish: 5
	cloth: 8
	bed: 10
	nose: 7
	towels: 8
	vacuum: 8
	mug: 10
	nails: 13
	bottle: 15
	brushes: 30
	dust: 15
	photos: 30
	tea: 15
	update: 20
	wilter: 30
	tails: 30
	filter: 60
	fsrs: 60
	iso: 60
	moch: 122
	tongue: 122
	toothbrush: 122
}

def main [] {}

def 'main due' [] {
	produce
	| upsert separator $'(ansi '#e49641')(ansi bo)—(ansi reset)'
	| move separator --after name
	| update cells -c [indicator] { $'(ansi '#e49641')(ansi bo)($in)(ansi reset)' }
	| update cells -c [days] { $'(ansi '#e491b2')($in)(ansi reset)' }
	| rename a b c d # to remove padding we get in the final text output
	| table -t none -i false
	| to text
	| lines
	| skip 1
	| to text
	| tee { ansi strip | tee { save -f ~/iwm/kss/loago-output.txt } | save -f ~/iwm/nak/↓loago.txt }
	| print
}

def 'main pick' [] {
	let listing = loago list

	let listed_tasks = $listing
	| lines
	| parse '{name} — {days}'
	| str trim name
	| get name

	$listing
	| lines
	| interleave { $known | columns | where $it not-in $listed_tasks }
	| interleave { $ignored | where $it not-in $listed_tasks }
	# | sort
	| to text
	| fuzzel -dl 7
	| each { |thingy|
		if ($thingy | str contains '—') {
			loago do ($thingy | split row — | get 0 | str trim)
		} else {
			loago do ($thingy | str trim)
		}
	} | ignore
}

def produce [] {
	loago list
	| parse '{name} — {days}'
	| str trim name
	| where name not-in $ignored
	| where name not-starts-with 'o-'
	| each { |row|
		$known
		| get --optional $row.name
		| if $in == null {
			$row | update days '!'
		} else {
			let difference = (($row.days | into int) - $in)
			if $difference >= 0 { $row | update days $difference }
		}
	}
	| sort-by days -rn
}
