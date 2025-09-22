#!/usr/bin/env -S nu -n --no-std-lib

export-env {
	use coco.nu []
}

def main [] {
	main list
}

export def 'main list' [] {
	glob --follow-symlinks /sys/class/hwmon/hwmon*/temp*_input
	| each { |path|
		let source = $path | path dirname | path join name | open | str trim
		let label_path = $path | str replace -r '_input$' '_label'
		let sensor = if ($label_path | path exists) { open $label_path | str trim }
		let path = ($path | path expand)
		{ source: $source, sensor: $sensor, path: $path }
	}
}

export def 'main cpu' [] {
	main list
	| where sensor == 'Package id 0' and source == coretemp
	| get path.0
}

export def 'main fix' [] {
	let waybar_conf = open ~/fes/dot/waybar/waybar.jsonc
	| from json
	let set_cpu = $waybar_conf | get temperature#cpu.hwmon-path
	let correct_cpu = main cpu
	if $set_cpu == (main cpu) {
		print -e 'nothing to fix, quitting'
		return
	}
	let incorrect_cpu = $set_cpu
	^sd $incorrect_cpu $correct_cpu ~/fes/dot/waybar/waybar.jsonc
	# ^systemctl --user restart waybar

	let incorrect_hwmon = $incorrect_cpu | path split | reverse | skip 1 | take 1 | get 0
	open ~/fes/uviw/afen/sudo | ^sudo -Sv
	let correct_hwmon = $correct_cpu | path split | reverse | skip 1 | take 1 | get 0
	^sudo sd $incorrect_hwmon $correct_hwmon /etc/fancontrol
	^sudo systemctl restart fancontrol
}
