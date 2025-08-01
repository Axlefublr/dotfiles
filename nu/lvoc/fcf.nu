#!/usr/bin/env -S nu -n --no-std-lib

source coco.nu

def main [] {
	sensors list
}

export def 'sensors list' [] {
	glob --follow-symlinks /sys/class/hwmon/hwmon*/temp*_input
	| each { |path|
		let source = $path | path dirname | path join name | open | str trim
		let label_path = $path | str replace -r '_input$' '_label'
		let sensor = if ($label_path | path exists) { open $label_path | str trim }
		let path = ($path | path expand)
		{ source: $source, sensor: $sensor, path: $path }
	}
}

export def 'sensors cpu' [] {

}
