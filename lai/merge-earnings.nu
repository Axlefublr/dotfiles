#!/usr/bin/env -S nu --no-std-lib -n --stdin

def main [] {
	$in
	| lines
	| parse '{date} {time} {earnings} {rate}'
	| group-by date --to-table
	| each {
		let combined_time = $in.items.time | str join ' + ' | calc -t $'($in) to time'
		let combined_earnings = $in.items.earnings | into int | math sum
		let combined_rate = calc -t $'($combined_earnings) / ($combined_time)' | into float | math round
		$'($in.date) ($combined_time) ($combined_earnings) ($combined_rate)'
	}
	| to text
}
