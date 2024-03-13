#!/usr/bin/env fish

alias --save logout "killall xremap ; awesome-client 'awesome.quit()'" > /dev/null
alias --save ukboot 'alacritty -T uboot -e fish -c uboot' > /dev/null
alias --save screen_off 'xset dpms force "off"' > /dev/null

alias --save get_capslock "xset -q | string match -gr 'Caps Lock:\\s* (off|on)'" > /dev/null
alias --save toggle_layout 'xkblayout-state set +1 ; awesome-client "Widget_update_layout()"' > /dev/null
alias --save get_layout 'xkblayout-state print "%n"' > /dev/null

alias --save get_internet 'nmcli radio wifi' > /dev/null
alias --save get_internet_connection 'nmcli networking connectivity check' > /dev/null
alias --save disable_internet 'nmcli radio wifi off' > /dev/null
alias --save enable_internet 'nmcli radio wifi on' > /dev/null
function toggle_internet
	if test (get_internet) = 'enabled'
		disable_internet
		awesome-client 'Widget_disable_wifi()'
	else
		enable_internet
		awesome-client 'Widget_enable_wifi()'
	end
end
funcsave toggle_internet > /dev/null

alias --save media_state 'playerctl status' > /dev/null
alias --save media_next 'playerctl next' > /dev/null
alias --save media_prev 'playerctl previous' > /dev/null
alias --save media_position 'playerctl position' > /dev/null
alias --save ms 'media_position' > /dev/null
function get_media_volume
	math "round($(playerctl volume) * 100)"
end
funcsave get_media_volume > /dev/null

function set_media_volume
	playerctl volume "$argv"
	awesome-client 'Widget_update_media_volume()'
end
funcsave set_media_volume > /dev/null

function toggle_media
	playerctl play-pause
	awesome-client 'Widget_update_media_state()'
end
funcsave toggle_media > /dev/null

function get_media_time
	playerctl metadata --format '{{duration(position)}}' 2> /dev/null
end
funcsave get_media_time > /dev/null

function ml
	media_position "$argv-"
end
funcsave ml > /dev/null

function mm
	media_position "$argv+"
end
funcsave ml > /dev/null

alias --save get_volume 'pactl get-sink-volume @DEFAULT_SINK@ | string match -rg \'Volume: front-left: \\d* \\/\\s*(\\d+)%\\s*\\/.*\'' > /dev/null
alias --save toggle_mute 'pactl set-sink-mute @DEFAULT_SINK@ toggle $argv ; awesome-client "Widget_update_muteness()"' > /dev/null
alias --save get_mute 'pactl get-sink-mute @DEFAULT_SINK@ | string match -gr "Mute: (no|yes)"' > /dev/null

alias --save get_mic_volume 'pactl get-source-volume @DEFAULT_SOURCE@ | string match -rg \'Volume: front-left: \\d* \\/\\s*(\\d+)%\\s*\\/.*\'' > /dev/null
alias --save toggle_mic_mute 'pactl set-source-mute @DEFAULT_SOURCE@ toggle $argv ; awesome-client "Widget_update_mic_muteness()"' > /dev/null
alias --save get_mic_mute 'pactl get-source-mute @DEFAULT_SOURCE@ | string match -gr "Mute: (no|yes)"' > /dev/null

function set_volume
	pactl set-sink-volume @DEFAULT_SINK@ $argv
	awesome-client 'Widget_update_volume()'
end
funcsave set_volume > /dev/null

function set_mic_volume
	pactl set-source-volume @DEFAULT_SOURCE@ $argv
	awesome-client 'Widget_update_mic_volume()'
end
funcsave set_mic_volume > /dev/null

function get_bluetooth
	bluetoothctl show | string match -gr 'Powered: (no|yes)'
end
funcsave get_bluetooth > /dev/null

function get_bluetooth_connected
	for device in (bluetoothctl devices | string match -gr 'Device (\\S+) [^-]+$')
		bluetoothctl info $device | rg 'Connected: yes'
	end
end
funcsave get_bluetooth_connected > /dev/null

function toggle_compositor
	if pidof picom
		if pidof gromit-mpx
			killall gromit-mpx
		end
		killall picom
		awesome-client 'Widget_disable_compositor()'
	else
		picom &> /tmp/log/picom.txt & disown
		awesome-client 'Widget_enable_compositor()'
		if pidof gromit-mpx
			killall gromit-mpx
		end
		gromit &> /tmp/log/gromit.txt & disown
	end
end
funcsave toggle_compositor > /dev/null

function is_internet
	set -l response (nmcli networking connectivity check)
	if test $response = 'full'
		return 0
	else if test $response = 'none'
		return 1
	else if test $response = 'limited'
		return 1
	else
		echo "unexpected response ($response) from `nmcli networking connectivity`" &> /dev/stderr
		return 1
	end
end
funcsave is_internet > /dev/null

function emoji_picker_clipboard
	kitty -T emoji-picker --start-as maximized sh -c "kitty +kitten unicode_input --tab $argv[1] > /dev/shm/unicode_input"
	if test -s /dev/shm/unicode_input
		cat /dev/shm/unicode_input | xclip -r -selection clipboard
	end
end
funcsave emoji_picker_clipboard > /dev/null

function get_hunger
	set times (loago list -m eat | string match -gr 'eat — \\d+d (\\d+)h (\\d+)m')
	set hours $times[1]
	set minutes $times[2]
	if test $hours -eq 0
		printf $minutes
		return
	end
	printf $hours':'$minutes
end
funcsave get_hunger > /dev/null

function get_oldest_task
	clorange task-count increment
	set oldest (loago list | rg -v 'eat' | tac) # only get tasks done 5 or more days ago
	set filtered
	for task in $oldest
		set matches (string match -gr '(\\S+)\\s+— (\\d+)' $task)
		set task_name $matches[1]
		set task_days $matches[2]
		if string match -qr 'filter|lamp|razor|[nt]ails|[fw]ilter|bottle|[fb]scrub|nose|cloths' $task_name
			if test \( $task_name = 'filter' -a $task_days -gt 45 \) \
			-o \( $task_name = 'lamp' -a $task_days -ge 7 \) \
			-o \( $task_name = 'nose' -a $task_days -ge 7 \) \
			-o \( $task_name = 'cloths' -a $task_days -ge 7 \) \
			-o \( $task_name = 'nails' -a $task_days -ge 10 \) \
			-o \( $task_name = 'wilter' -a $task_days -ge 10 \) \
			-o \( $task_name = 'bottle' -a $task_days -ge 10 \) \
			-o \( $task_name = 'fscrub' -a $task_days -ge 10 \) \
			-o \( $task_name = 'bscrub' -a $task_days -ge 10 \) \
			-o \( $task_name = 'razor' -a $task_days -ge 20 \) \
			-o \( $task_name = 'tails' -a $task_days -ge 20 \)
				set filtered $filtered "$task_name $task_days"
			end
		else if test $task_days -ge 5
			set filtered $filtered "$task_name $task_days"
		end
	end
	set available (count $filtered)
	if test $available -eq 0
		printf 'done!'
		return 0
	end
	set index (clorange task-count show)
	if test $index -gt $available
		clorange task-count set 1
		set index 1
	end
	set picked $filtered[$index]
	printf $picked
end
funcsave get_oldest_task > /dev/null