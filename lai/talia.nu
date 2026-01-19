#!/usr/bin/env -S nu -n --no-std-lib

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

$talias
| to text
| fzf --height=5 '--bind=f12:become:echo :{}'
| if ($in starts-with :) {
	$in | str substring 1.. | open_result false
} else {
	open_result true
}
