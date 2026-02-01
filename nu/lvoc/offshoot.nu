export def 'finance' [] {
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

export def 'parse_ffprobe' [] {
	parse -r 'Stream #0:(?P<id>\d+)\((?P<lng>\w+)\): (?P<type>Audio|Subtitle): .*?(?:\((?P<default>default)\))?\n(?:.*\n\s+title\s*: (?P<description>\w+))?'
	| update cells -c [default] { if $in == default { true } }
	| rename -c { id: index, default: dflt, description: descript }
}
