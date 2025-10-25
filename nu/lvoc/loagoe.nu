#!/usr/bin/env -S nu -n --no-std-lib
source coco.nu

const ignored = [
	# [[sort on]]
	belosalik
	eat
	facewash
	puff
	roll
	sludge
	soap
	# [[sort off]]
]

const known = {
	razor: 4
	dish: 5
	mug: 5
	bed: 6
	cloth: 6
	nose: 6
	floor: 7
	towels: 7
	vacuum: 8
	dust: 12
	nails: 13
	vacuat: 14
	bottle: 15
	disc: 15
	glasses: 15
	liked: 15
	photos: 15
	update: 15
	utencils: 15
	wilter: 23
	doodads: 30
	keyboard: 30
	ov: 30
	yazi: 30
	tails: 40
	filter: 45
	fsrs: 60
	iso: 60
	treesitter-markdown: 90
	moch: 122
	toothbrush: 122
	tongue: 183
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

def 'main pick' [] {
  loago list
  | parse '{name} — {days}'
  | str trim name
  | get name
  | interleave { $known | columns }
  | interleave { $ignored }
  | sort
  | uniq
  | to text
  | fuzzel -dl 7
  | each { |thingy|
    loago do ($thingy | str trim)
  } | ignore
}
