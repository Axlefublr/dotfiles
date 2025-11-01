#!/usr/bin/env -S nu -n --no-std-lib
source coco.nu

const ignored = [
	# [[sort on]]
	belosalik
	eat
	facewash
	roll
	sludge
	soap
	# [[sort off]]
]

const known = {
	# [[sort on]]
	# disc: 15
	# floor: 7
	# keyboard: 30
	# liked: 15
	bed: 6
	bottle: 15
	cloth: 6
	dish: 5
	doodads: 30
	dust: 12
	filter: 45
	fsrs: 60
	glasses: 15
	iso: 60
	moch: 122
	mug: 5
	nails: 13
	nose: 7
	ov: 30
	photos: 15
	razor: 4
	tails: 40
	tongue: 183
	toothbrush: 122
	towels: 7
	treesitter-markdown: 90
	update: 15
	upload: 15
	utencils: 15
	vacuat: 14
	vacuum: 8
	wilter: 23
	yazi: 30
	# [[sort off]]
}

def produce [] {
	loago list
	| parse '{name} — {days}'
	| str trim name
	| where name not-in $ignored
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

def main [] {}

def 'main due' [] {
	let the = produce
	| enumerate
	| each {
		let indicator = $in.index + 97 | char -i $in
		{ indicator: $indicator, name: $in.item.name, days: $in.item.days }
	}
	$the
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
	| print
	let input = input --reedline
	if ($input | is-empty) { return }
	let todos = $input | split chars
	$the
	| where indicator in $todos
	| get name
	| try { loago do ...$in }
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
	| sort
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

def 'main due pick' [] {
	produce
	| get name
	| to text
	| fuzzel -d
	| each { |thingy|
	  loago do ($thingy | str trim)
	}
	| ignore
}
