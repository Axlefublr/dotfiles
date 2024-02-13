#!/usr/bin/env fish

alias --save wm_logout "killall xremap ; awesome-client 'awesome.quit()'" > /dev/null
alias --save wm_toggle_float "awesome-client 'require(\'awful\').client.floating.toggle()'" > /dev/null
alias --save wm_toggle_on_top "awesome-client 'client.focus.ontop = not client.focus.ontop'" > /dev/null
alias --save wm_toggle_maximized "awesome-client 'client.focus.maximized = not client.focus.maximized'" > /dev/null
alias --save wm_toggle_fullscreen "awesome-client 'client.focus.fullscreen = not client.focus.fullscreen'" > /dev/null
alias --save wm_toggle_sticky "awesome-client 'client.focus.sticky = not client.focus.sticky'" > /dev/null

alias --save clear_all_notifications "awesome-client 'naughty.destroy_all_notifications()'" > /dev/null
alias --save prompt_ignore_output "awesome-client 'Prompt_ignore_output()'" > /dev/null

alias --save set_volume 'pactl set-sink-volume @DEFAULT_SINK@' > /dev/null
alias --save toggle_mute 'pactl set-sink-mute @DEFAULT_SINK@ toggle' > /dev/null
alias --save get_volume 'pactl get-sink-volume @DEFAULT_SINK@ | string match -rg \'Volume: front-left: \\d* \\/\\s*(\\d+)%\\s*\\/.*\'' > /dev/null

alias --save set_mic_volume 'pactl set-source-volume @DEFAULT_SOURCE@' > /dev/null
alias --save toggle_mic_mute 'pactl set-source-mute @DEFAULT_SOURCE@ toggle' > /dev/null
alias --save get_mic_volume 'pactl get-source-volume @DEFAULT_SOURCE@ | string match -rg \'Volume: front-left: \\d* \\/\\s*(\\d+)%\\s*\\/.*\'' > /dev/null

alias --save toggle_layout 'xkblayout-state set +1' > /dev/null
alias --save get_internet 'nmcli networking connectivity' > /dev/null
alias --save get_mic_mute 'pactl get-source-mute @DEFAULT_SOURCE@ | string match -gr "Mute: (no|yes)"' > /dev/null
alias --save get_mute 'pactl get-sink-mute @DEFAULT_SINK@ | string match -gr "Mute: (no|yes)"' > /dev/null

alias --save widget_update_volume 'awesome-client \'Widget_update_volume()\'' > /dev/null
alias --save widget_update_muteness 'awesome-client \'Widget_update_muteness()\'' > /dev/null
alias --save widget_update_mic_volume 'awesome-client \'Widget_update_mic_volume()\'' > /dev/null
alias --save widget_update_mic_muteness 'awesome-client \'Widget_update_mic_muteness()\'' > /dev/null
alias --save widget_update_layout 'awesome-client \'Widget_update_layout()\'' > /dev/null
alias --save widget_disable_compositor 'awesome-client \'Widget_disable_compositor()\'' > /dev/null
alias --save widget_enable_compositor 'awesome-client \'Widget_enable_compositor()\'' > /dev/null

function enable_compositor
	picom >> /tmp/log/picom.txt & disown
	widget_enable_compositor
end
funcsave enable_compositor > /dev/null

function disable_compositor
	killall picom
	widget_disable_compositor
end
funcsave disable_compositor > /dev/null

function is_compositor
	if pgrep -x picom &> /dev/null
		printf 'enabled'
	else
		printf 'disabled'
	end
end
funcsave is_compositor > /dev/null

function is_xremap
	if pgrep -x xremap &> /dev/null
		printf 'enabled'
	else
		printf 'disabled'
	end
end
funcsave is_xremap > /dev/null

function toggle_compositor
	if pgrep -x picom
		disable_compositor
	else
		enable_compositor
	end
end
funcsave toggle_compositor > /dev/null

function toggle_xzoom
	if pgrep -x xzoom
		killall xzoom
		enable_compositor
	else
		disable_compositor
		xzoom -mag 3
	end
end
funcsave toggle_xzoom > /dev/null

function get_layout
	set layout (xkblayout-state print '%n')
	if test $layout = 'English'
		printf 'eng'
	else if test $layout = 'Russian'
		printf 'rus'
	end
end
funcsave get_layout > /dev/null

function get_capslock
	xset -q | string match -gr 'Caps Lock:\\s* (off|on)'
end
funcsave get_capslock > /dev/null

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