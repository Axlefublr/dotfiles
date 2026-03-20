#!/usr/bin/env -S nu -n --no-std-lib --stdin

use always.nu 'date now date'

def 'main' [] {
	let IN = $in
	let the = [held inc name lasts costs mult keep] | zip { $IN | from nuon } | into record

	mut held = $the.held
	mut remainder = ''

	if ($the.costs | is-not-empty) {
		let max_cost = $the.costs | math max
		if ($the.keep | is-not-empty) {
			let safe_max_cost = $the.keep * $max_cost
			if ($held >= $safe_max_cost) {
				$remainder = $held - $safe_max_cost | math round | into int
				$held = $safe_max_cost | math round | into int
			}
		}
	}

	let held  = $held | into string | fill -w 4
	let name  = $the.name | into string | fill -w 10
	let mult  = $the.mult | default 'null' | into string | fill -w 4
	let keep  = $the.keep | default 'null' | into string | fill -w 4

	let lasts = (formatfill 3 4 $the.lasts)
	let costs = (formatfill 4 3 $the.costs)

	let inc = if ($the.lasts | is-empty) or ($the.costs | is-empty) {
		$the.inc
	} else {
		let average_lasts = if ($the.lasts | describe) == int {
			$the.lasts * ($the.mult | default 1.0)
		} else {
			$the.lasts | math avg | $in * ($the.mult | default 1.0)
		}
		let average_costs = $the.costs | math avg
		$average_costs * 30.5 / $average_lasts | math ceil
	}
	| into string | fill -w 3

	print $'[($held), ($inc), ($name), ($lasts), ($costs), ($mult), ($keep)]($remainder)'

	def formatfill [width: int, numbers: int = 3, input?: list] {
		# you're supposed to pass the width that each number is supposed to occupy
		# so `width` might be 2, 3, 4
		# we know that there will be [space for] 3 numbers in total, so we add the 2 separator spaces on top
		let enclosed_values_length = $width * $numbers + 2
		# 2 for the missing brackets, 2 for the separator spaces
		let single_value_length = $width * $numbers + 4
		if $input == null {
			'null' | fill -w $single_value_length
		} else if ($input | is-empty) {
			'[' + (' ' | fill -w $enclosed_values_length) + ']'
		} else if ($input | describe) == 'int' {
			$input | fill -w $single_value_length
		} else {
			$input | each { fill -w $width } | str join ' ' | fill -w $enclosed_values_length | '[' + $in + ']'
		}
	}
}

def 'main calculate' [] {
	let data = split row -r '\s+'
	let time_worked = $data | first
	let earnings = $data | skip 1 | each { into int } | math sum | math round
	let rate = calc -t $'($earnings) / ($time_worked)' | into float | math round
	$'(date now date) ($time_worked) ($earnings) ($rate)'
}

def 'main parse' [trail: bool = false] {
	$in
	| lines
	| parse '{date} {time} {earnings} {rate}'
	| group-by date --to-table
	| update cells -c [date] { str replace -r '^' '20' | str replace -a '.' '-' | into datetime }
	| if $trail { where date > (date now | $in - 30day) } else {}
	| update cells -c [items] {
		reject date
		| update cells -c [time] { $in + ':0' | into duration }
		| update cells -c [earnings, rate] { into int }
	}
}

def 'support merge' [trail: bool = false] {
	main parse $trail
	| update cells -c [items] {
		let combined_time = $in | get time | math sum
		let combined_total = $in | get earnings | math sum
		let combined_rate = $combined_total / ($combined_time / 1hr)
		let combined_time = $combined_time
		let combined_total = $combined_total
		{ time: $combined_time, earnings: $combined_total, rate: $combined_rate }
	}
	| flatten
}

def 'support format duration' [] {
	let the = $in | into record
	let hours = $the | get -o hour | default 0
	let hours = $the | get -o day | default 0 | $in * 24 + $hours
	let minutes = $the | get -o minute | default 0 | fill -w 2 -a r -c 0
	let sign = $the | get -o sign | default '' | if ($in == '+') { '' } else {}
	$'($sign)($hours):($minutes)'
}

def 'main merge' [] {
	support merge
	| each {
		let date = $in.date | format date '%y.%m.%d'
		let time = $in.time | support format duration
		let earnings = $in.earnings
		let rate = $in.rate | math round
		$'($date) ($time) ($earnings) ($rate)'
	}
	| to text
}

def 'main data' [] {
	let data = open ~/ake/finances | support merge true
	let earnings_total = $data | get earnings | math sum
	let time_total = $data | get time | math sum
	let average_time = $time_total | $in / 30
	let earnings_perday = $earnings_total / 30 | math round
	let rate = $earnings_total / ($time_total / 1hr) | math round
	print $'(ansi '#ea6962')total(ansi reset): ($earnings_total | fill -a r -w 6)'
	print $'(ansi '#e49641')proj (ansi reset): (6 * $rate * 30 | math round | fill -a r -w 6)'
	print $'(ansi '#d3ad5c')hours(ansi reset): ($average_time | support format duration | fill -a r -w 6)'
	print $'(ansi '#a9b665')over (ansi reset): ($time_total - 6hr * 30 | support format duration | fill -a r -w 6)'
	print $'(ansi '#78bf84')daily(ansi reset): ($earnings_perday | fill -a r -w 6)'
	print $'(ansi '#7daea3')rate (ansi reset): ($rate | fill -a r -w 6)'
}
