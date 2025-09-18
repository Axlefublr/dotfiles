#!/usr/bin/env -S nu -n --no-std-lib
source coco.nu

const ignored = [
	# [[sort on]]
	eat
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
	dust: 10
	nails: 13
	bottle: 15
	disc: 15
	glasses: 15
	liked: 15
	photos: 15
	update: 15
	utencils: 15
	wilter: 15
	keyboard: 30
	ov: 30
	qiri: 30
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
	produce
	| upsert separator '—'
	| move separator --after name
	| rename a b c
	| table -t none -i false
	| to text
	| lines
	| skip 1
	| to text
}

def 'main due pick' [] {
	produce
	| get name
	| to text
	| fuzzel -d --cache ~/.cache/mine/loago-pick-overdue
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
  | to text
  | fuzzel -d --cache ~/.cache/mine/loago-pick
  | each { |thingy|
    loago do ($thingy | str trim)
  } | ignore
}
