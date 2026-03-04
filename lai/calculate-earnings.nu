#!/usr/bin/env -S nu --no-std-lib -n --stdin

use always.nu 'date now date'

def main [] {
	let data = split row -r '\s+'
	let start_time = $data | first
	let end_time = $data | last
	let earnings = $data | skip 1 | drop 1 | each { into int } | math sum | math round
	let time_delta = calc -t $'($end_time) - ($start_time) to time'
	let rate = calc -t $'($earnings) / ($time_delta)' | into float | math round
	$'(date now date) ($time_delta) ($earnings) ($rate)'
}
