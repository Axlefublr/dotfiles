#!/usr/bin/env -S nu -n --no-std-lib

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
        'Success' => ''
        'Failed' => '󱎘'
        'Killed' => '󰆐'
        $other => $other
	}
	let command_str = $command
	| split chars
	| take 50
	| str join
	notify-send -t 3000 $'($command_str) ($result_symbol)(char -u "2800")'
}

def 'main brush' [] {
	let olds = ^pueue status -j
	| from json
	| get tasks
	| values
	| where { |it|
		let the = $it | get --optional status.Done.end
		$the != null and ((date now) - ($the | into datetime) > 1day)
	}
	| get id
	if ($olds | is-not-empty) {
		^pueue remove ...$in
	}
}
