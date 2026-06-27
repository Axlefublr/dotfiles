#!/usr/bin/env -S nu --no-std-lib -n

for $index in (seq 1 60) {
	let found = niri msg -j windows
	| from json
	| where is_urgent == true
	| where app_id starts-with foot
	| where title == nugleterm
	| get id
	if ($found | is-not-empty) {
		$found | each { niri msg action unset-window-urgent --id $in }
		break
	}
	sleep 1sec
}
for $index in (seq 1 60) {
	let found = niri msg -j windows
	| from json
	| where is_urgent == true
	| where app_id =~ '[Tt]odoist'
	| get id
	if ($found | is-not-empty) {
		$found | each { niri msg action unset-window-urgent --id $in }
		break
	}
	sleep 1sec
}
