#!/usr/bin/env -S nu -n --no-std-lib

use always.nu

def --wrapped main [...rest] {
	if ($rest | length) == 0 {
		exec ov -X --section-delimiter ^Group -M Failed,Running,Queued,Success,,,,Paused -Ae -- pueue status
		return
	}
	pueue ...$rest
}

def 'main callback' [
	id
	command
	path
	result
	exit_code
	group
	output
	start
	end
] {
	let result_symbol = match $result {
        'Success' => '✅'
        'Failed' => '❌'
        'Killed' => '🔪'
        $other => $other
	}
	let command_str = $command
	| split chars
	| take 50
	| str join
	notify-send -t 3000 $'($command_str) ($result_symbol)'
}

def 'main brush' [] {
	let olds = ^pueue status -j
	| from json
	| get tasks
	| values
	| where { |it|
		let the = $it | get --optional status.Done.end
		$the != null and ((date now) - ($the | into datetime) > 2hr)
	}
	| get id
	if ($olds | is-not-empty) {
		^pueue remove ...$olds
	}
}

def 'main situation' [] {
	pueue status --json
	| from json
	| get tasks
	| values
	| rename -c { id: index }
	| each { |record|
		let status_name = $record.status | columns | first
		let result = $record.status | get -o result
		# $record.status | get $status_name | try {
		# 	get result | let result
		# 	$result | try {
		# 		columns | first | let first_column
		# 		$'($first_column) ($result | get $first_column)'
		# 	} catch { $result }
		# } catch { $status_name }
		# {
		# 	status: $status
		# }
	}
}

def 'main interact' [] {
	loop {
		pueue --color always status
		# | str replace -r "\n\nTask list is empty.+" ''
		# | print
		print -e '[k]ill [l]og [s]tart [r]estart [d]emove pa[u]se [c]lean [p]arallel'
		let input = input --reedline : | str trim
		if ($input | is-empty) { clear ; continue }
		let subcommand = match ($input | str substring 0..0) {
			'k' => 'kill'
			'l' => 'log'
			's' => 'start'
			'r' => 'restart'
			'd' => 'remove'
			'u' => 'pause'
			'c' => 'clean'
			'p' => 'parallel'
			$other => (continue)
		}
		let extra = try { $input | str substring 1.. | default -e null | split row -r '\s+' }
		try { clear ; pueue $subcommand ...$extra ; print '' }
	}
}
