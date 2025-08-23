#!/usr/bin/env -S nu -n --no-std-lib

def --wrapped main [...rest] {
	if ($rest | length) == 0 {
		exec ov -X --section-delimiter ^Group --hide-other-section -M Failed,Running,Queued,Success,,,,Paused -Ae -- pueue status
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
