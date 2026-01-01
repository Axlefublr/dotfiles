#!/usr/bin/env na

let talias = ls ~/fes/talia/
| sort-by modified
| get name
| each { path basename }

let filled = $talias
| each { |talia|
	let plans_path = $"~/fes/talia/($talia)/plans.md" | path expand
	let contents = try { open $plans_path }
	if ($contents | default '' | is-empty) {
		$'(ansi "#e49641")(ansi bo)($talia)(ansi reset)' | print
	} else {
		$"(ansi '#e49641')(ansi bo)($talia)(ansi reset)\n" ++ $contents
	}
}
print ''
$filled
| each { print }

def open_result [should_plans: bool] {
	let parent = $"~/fes/talia/($in)" | path expand
	mkdir $parent
	cd $parent
	if $should_plans {
		helix ($parent + '/plans.md')
	} else {
		yazi
	}
}

let talias = $talias | reverse

loop {
	mut input = input --reedline :
	if ($input | is-empty) {
		cd ~/fes/talia
		yazi
		continue
	}
	mut should_plans = true
	$input = if (($input | split chars | last) == ',') {
		$should_plans = false
		$input | str substring ..-2
	} else { $input }
	let should_plans = $should_plans
	if (($input | split chars | last) == ';') {
		$input | str substring ..-2 | open_result $should_plans
		continue
	}
	$talias | where $it == $input
	| append ($talias | where ($it | str downcase) == $input)
	| append ($talias | where ($it | str contains $input))
	| append ($talias | where (($it | str downcase) | str contains $input))
	| uniq
	| each { open_result $should_plans }
}
