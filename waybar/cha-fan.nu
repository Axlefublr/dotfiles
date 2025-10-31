#!/usr/bin/env -S nu -n --no-std-lib

let sensor_data = sensors -j e> /dev/null | from json | get it8620-isa-0a30
let fan1_speed = $sensor_data | get fan2.fan2_input | math round -p -2 | into int
let fan2_speed = $sensor_data | get fan3.fan3_input | math round -p -2 | into int
if $fan1_speed == $fan2_speed {
	if $fan1_speed == 0 {
		print
	} else {
		print $fan1_speed
	}
} else {
	if $fan1_speed == 0 or $fan2_speed == 0 {
		print $'($fan1_speed)/($fan2_speed)'
	} else {
		print $fan1_speed
	}
}
