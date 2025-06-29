#!/usr/bin/env nu
source coco.nu

const ignored = [
	eat
	sludge
]

const known = {
	# [[sort on]]
	bed: 5
	bottle: 15
	brushes: 10
	disc: 15
	dish: 5
	dust: 7
	filter: 45
	floor: 7
	fsrs: 60
	glasses: 10
	iso: 60
	keyboard: 30
	liked: 15
	moch: 122
	mug: 5
	nails: 14
	nose: 6
	photos: 15
	razor: 5
	tails: 30
	tongue: 122
	toothbrush: 122
	towels: 7
	update: 5
	vacuum: 7
	wilter: 15
	# [[sort off]]
}

def produce [] {
	loago list
	| parse '{name} — {days}'
	| reverse
	| str trim name
	| where name not-in $ignored
	| each { |row|
		$known
		| get --ignore-errors $row.name
		| if $in == null {
			$row | update days '!'
		} else {
			let difference = (($row.days | into int) - $in)
			if $difference >= 0 { $row | update days $difference }
		}
	}
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
	| each { |$thingy|
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
  each { |$thingy|
    loago do ($thingy | str trim)
  }
}
