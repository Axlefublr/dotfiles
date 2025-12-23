#!/usr/bin/env -S nu -n --no-std-lib

source coco.nu

let talias = ls ~/fes/talia/
| sort-by modified
| get name
| each { path basename }

$talias
| each { |talia|
	let plans_path = $"~/fes/talia/($talia)/plans.md" | path expand
	if (try { open $plans_path } | default '' | is-empty) {
		$'(ansi "#e49641")(ansi bo)($talia)(ansi reset)' | print
	}
} | ignore
print ''
$talias
| each { |talia|
	let plans_path = $"~/fes/talia/($talia)/plans.md" | path expand
	if ($plans_path | path exists) {
		let contents = open $plans_path
		if ($contents | is-not-empty) {
			$'(ansi "#e49641")(ansi bo)($talia)(ansi reset)' | print
			$contents | print
		}
	}
} | ignore

def open_result [] {
	let parent = $"~/fes/talia/($in)" | path expand
	mkdir $parent
	cd $parent
	helix ($parent + '/plans.md')
}

let talias = $talias | reverse

loop {
	let input = input --reedline :
	if ($input | is-empty) {
		cd ~/fes/talia
		yazi
		continue
	}
	if (($input | str substring 0..0) == ',') {
		$input | str substring 1.. | open_result
		continue
	}
	$talias | where $it == $input
	| append ($talias | where ($it | str downcase) == $input)
	| append ($talias | where ($it | str contains $input))
	| append ($talias | where (($it | str downcase) | str contains $input))
	| uniq
	| each { open_result }
}
