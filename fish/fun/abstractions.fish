#!/usr/bin/env fish

alias --save wm_logout "killall xremap ; awesome-client 'awesome.quit()'" > /dev/null
alias --save wm_toggle_float "awesome-client 'require(\'awful\').client.floating.toggle()'" > /dev/null
alias --save wm_toggle_on_top "awesome-client 'client.focus.ontop = not client.focus.ontop'" > /dev/null
alias --save wm_toggle_maximized "awesome-client 'client.focus.maximized = not client.focus.maximized'" > /dev/null
alias --save wm_toggle_fullscreen "awesome-client 'client.focus.fullscreen = not client.focus.fullscreen'" > /dev/null

alias --save volume_set 'pactl set-sink-volume @DEFAULT_SINK@' > /dev/null
alias --save toggle_mute 'pactl set-sink-mute @DEFAULT_SINK@ toggle' > /dev/null
alias --save get_volume 'pactl get-sink-volume @DEFAULT_SINK@ | string match -rg \'Volume: front-left: \\d* \\/\\s*(\\d+)%\\s*\\/.*\'' > /dev/null

alias --save widget_update_volume 'awesome-client \'Widget_update_volume()\'' > /dev/null
alias --save widget_update_muteness 'awesome-client \'Widget_update_muteness()\'' > /dev/null

function get_mute
	set output (pactl get-sink-mute @DEFAULT_SINK@)
	if string match -r 'Mute: no' $output &> /dev/null
		printf ''
	else if string match -r 'Mute: yes' $output &> /dev/null
		printf ''
	else
		printf 'ඞ'
	end
end
funcsave get_mute > /dev/null

function is_internet
	set -l response (nmcli networking connectivity)
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