#!/usr/bin/env -S nu -n --no-std-lib

source coco.nu

print 'time   cpu  gpu    ppt  cpu° gpu°  cpu*  ram'
radeontop -d - -i 1 | lines | skip 1 | each { str substring 30..33 | into float | math round | fill -w 3 -a r }
| zip {
	mpstat 1 | lines | skip 3 | each { str substring 91..92 | into int | 100 - $in | fill -w 3 -a r }
}
| each {
	let timestamp = date now | format date '%M:%S'

	let sensor_output = sensors -j e> /dev/null | from json
	let ppt = $sensor_output | get amdgpu-pci-0300.PPT.power1_average | into int | fill -w 3 -a r
	let ppt_cap = $sensor_output | get amdgpu-pci-0300.PPT.power1_cap | into int
	let cpu_temp = $sensor_output | get coretemp-isa-0000.'Package id 0'.temp1_input | into int | fill -w 3 -a r
	let gpu_temp = $sensor_output | get amdgpu-pci-0300.junction.temp2_input | into int | fill -w 3 -a r
	let cpu_fan = $sensor_output | get it8620-isa-0a30.fan1.fan1_input | into int | fill -w 4 -a r
	# let cha_fan = $sensor_output | get it8620-isa-0a30.fan2.fan2_input | into int | fill -w 4 -a r
	# let cha_fan_2 = $sensor_output | get it8620-isa-0a30.fan3.fan3_input | into int | fill -w 4 -a r
	let memory = free -h | detect columns | get used.0 | str substring ..-3 | str replace , . | fill -w 4 -a r

	print $'($timestamp) ($in.1)% ($in.0)% ($ppt)/($ppt_cap) ($cpu_temp)° ($gpu_temp)° ($cpu_fan)* ($memory)'
} | ignore
