#!/usr/bin/env -S nu -n --no-std-lib

mut timestamp = (date now)
mut rest_time = 0sec
mut phase = 'work'

def commit [class] {
	into string
	| $'{ "text": "($in)", "class": "($class)" }' + "\n"
	| save -f ~/.local/share/mine/waybar-tomato
}

def log [phase] {
	tee { $"($phase): ($in)\n" | save -a /tmp/mine/tomato-log }
}

def evaluate [phase, rest_time, timestamp] {
	if $phase == work {
		((date now) - $timestamp) | log $phase | $in // 1min | commit work
	} else {
		let the = ($rest_time - ((date now) - $timestamp))
		if $the >= 0sec {
			$the | log $phase | $in // 1min | commit rest
		} else {
			'0' | log $phase | commit rest
		}
	}
}

loop {
	let action = try { open /tmp/mine/tomato-action } | default '' | str trim
	'' | save -f /tmp/mine/tomato-action
	match $action {
		toggle => {
			if $phase == work {
				$phase = 'rest'
				$rest_time = $rest_time + ((date now) - $timestamp) / 3
				$timestamp = (date now)
				evaluate $phase $rest_time $timestamp
			} else {
				$phase = 'work'
				$rest_time = if $rest_time < 0sec { 0sec } else {
					$rest_time - ((date now) - $timestamp)
				}
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
