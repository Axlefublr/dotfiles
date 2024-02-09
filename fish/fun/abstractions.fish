#!/usr/bin/env fish

alias --save wm-logout "killall xremap ; awesome-client 'awesome.quit()'" > /dev/null
alias --save wm-toggle-float "awesome-client 'require(\'awful\').client.floating.toggle()'" > /dev/null
alias --save wm-toggle-on-top "awesome-client 'client.focus.ontop = not client.focus.ontop'" > /dev/null
alias --save wm-toggle-maximized "awesome-client 'client.focus.maximized = not client.focus.maximized'" > /dev/null
alias --save wm-toggle-fullscreen "awesome-client 'client.focus.fullscreen = not client.focus.fullscreen'" > /dev/null

function is-internet
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
funcsave is-internet > /dev/null

function emoji-picker-clipboard
	kitty -T emoji-picker --start-as maximized sh -c "kitty +kitten unicode_input --tab $argv[1] > /tmp/unicode_input"
	if test -s /tmp/unicode_input
		cat /tmp/unicode_input | xclip -r -selection clipboard
	end
end
funcsave emoji-picker-clipboard > /dev/null