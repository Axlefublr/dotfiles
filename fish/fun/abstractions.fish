#!/usr/bin/env fish

alias --save get_capslock "xset -q | string match -gr 'Caps Lock:\\s* (off|on)'" > /dev/null
alias --save toggle_layout 'xkblayout-state set +1 ; awesome-client "Widget_update_layout()"' > /dev/null
alias --save logout "killall xremap ; awesome-client 'awesome.quit()'" > /dev/null
alias --save get_internet 'nmcli networking connectivity check' > /dev/null
alias --save get_layout 'xkblayout-state print "%n"' > /dev/null

alias --save set_volume 'pactl set-sink-volume @DEFAULT_SINK@ $argv ; awesome-client "Widget_update_volume()"' > /dev/null
alias --save get_volume 'pactl get-sink-volume @DEFAULT_SINK@ | string match -rg \'Volume: front-left: \\d* \\/\\s*(\\d+)%\\s*\\/.*\'' > /dev/null
alias --save toggle_mute 'pactl set-sink-mute @DEFAULT_SINK@ toggle $argv ; awesome-client "Widget_update_muteness()"' > /dev/null
alias --save get_mute 'pactl get-sink-mute @DEFAULT_SINK@ | string match -gr "Mute: (no|yes)"' > /dev/null

alias --save set_mic_volume 'pactl set-source-volume @DEFAULT_SOURCE@ $argv ; awesome-client "Widget_update_mic_volume()"' > /dev/null
alias --save get_mic_volume 'pactl get-source-volume @DEFAULT_SOURCE@ | string match -rg \'Volume: front-left: \\d* \\/\\s*(\\d+)%\\s*\\/.*\'' > /dev/null
alias --save toggle_mic_mute 'pactl set-source-mute @DEFAULT_SOURCE@ toggle $argv ; awesome-client "Widget_update_mic_muteness()"' > /dev/null
alias --save get_mic_mute 'pactl get-source-mute @DEFAULT_SOURCE@ | string match -gr "Mute: (no|yes)"' > /dev/null

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
		gromit-mpx -o 1 -k "none" -u "none" &> /tmp/log/gromit.txt & disown
	end
end
funcsave toggle_compositor > /dev/null

function run_xzoom
	if pidof xzoom
		notify-send -t 2000 'xzoom already running'
		return 1
	end
	killall gromit-mpx
	killall picom
	xzoom -mag 3
	gromit-mpx -o 1 -k "none" -u "none" &> /tmp/log/gromit.txt & disown
	picom &> /tmp/log/picom.txt & disown
end
funcsave run_xzoom > /dev/null

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
	kitty -T emoji-picker --start-as maximized sh -c "kitty +kitten unicode_input --tab $argv[1] > /tmp/unicode_input"
	if test -s /tmp/unicode_input
		cat /tmp/unicode_input | xclip -r -selection clipboard
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
	set matches (loago list | tail -n 1 | string match -gr '(\\S+) — (\\d+)')
	set name $matches[1]
	set days $matches[2]
	set formatted_days ''
	for digit in (string split '' $days)
		switch $digit
			case 0
				set formatted_days $formatted_days⁰
			case 1
				set formatted_days $formatted_days¹
			case 2
				set formatted_days $formatted_days²
			case 3
				set formatted_days $formatted_days³
			case 4
				set formatted_days $formatted_days⁴
			case 5
				set formatted_days $formatted_days⁵
			case 6
				set formatted_days $formatted_days⁶
			case 7
				set formatted_days $formatted_days⁷
			case 8
				set formatted_days $formatted_days⁸
			case 9
				set formatted_days $formatted_days⁹
		end
	end
	printf "$name$formatted_days"
end
funcsave get_oldest_task > /dev/null