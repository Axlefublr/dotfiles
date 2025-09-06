#!/usr/bin/env -S nu -n --no-std-lib

mut timestamp = (date now)
mut rest_time = 0sec
mut phase = 'work'

def commit [class: string] {
	into string
	| $'{ "text": "($in)", "class": "($class)" }' + "\n"
	| save -f ~/.local/share/mine/waybar-tomato
}

def log [phase: string] {
	tee { $"($phase): ($in)\n" | save -a /tmp/mine/tomato-log }
}

def elapsed [timestamp: datetime] {
	(date now) - $timestamp
}

def evaluate [phase: string, rest_time: duration, timestamp: datetime] {
	if $phase == work {
		elapsed $timestamp | log $phase | $in // 1min | commit $phase
	} else {
		let remains = ($rest_time - (elapsed $timestamp)) | log $phase
		if $remains >= 0sec {
			$remains // 1min | commit $phase
		} else {
			'0' | commit $phase
		}
	}
}

def toggle []: string -> string {
	match $in {
		'work' => 'rest'
		'rest' => 'work'
	}
}

loop {
	let action = try { open /tmp/mine/tomato-action } | default '' | str trim
	'' | save -f /tmp/mine/tomato-action
	match $action {
		toggle => {
			if $phase == work {
				$phase = $phase | toggle
				$rest_time = [$rest_time 0sec] | math max | $in + (elapsed $timestamp) / 3
				$timestamp = (date now)
				evaluate $phase $rest_time $timestamp
			} else {
				$phase = $phase | toggle
				$rest_time = $rest_time - (elapsed $timestamp) | append [0sec] | math max
				$timestamp = (date now)
				evaluate $phase $rest_time $timestamp
			}
		}
		stop => { break }
		_ => { evaluate $phase $rest_time $timestamp }
	}
	try { inotifywait -qq -t 60 -e close_write /tmp/mine/tomato-action }
}
"\n" | save -f ~/.local/share/mine/waybar-tomato
