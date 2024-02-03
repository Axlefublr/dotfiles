#!/usr/bin/env fish

function winwaitname
	loopuntil "xdotool search --onlyvisible --name $argv[1] &> /dev/null" $argv[2..]
end
funcsave winwaitname > /dev/null

function winwaitclass
	loopuntil "xdotool search --onlyvisible --class $argv[1] &> /dev/null" $argv[2..]
end
funcsave winwaitclass > /dev/null

function winmoveall
	for win_id in (wmctrl -lx | rg $argv[1] | awk '{print $1}')
		wmctrl -ir $win_id -t $argv[2]
	end
end
funcsave winmoveall > /dev/null

function minigun-save
	set -l coords (xdotool getmouselocation | string match -gr '\\w:(\\d+) \\w:(\\d+)')
	printf $coords[1]' '$coords[2] > ~/.local/share/minigun/$argv[1]
end
funcsave minigun-save > /dev/null

function minigun-apply
	set -l coords (cat ~/.local/share/minigun/$argv[1] | string split ' ')
	xdotool mousemove $coords[1] $coords[2]
end
funcsave minigun-apply > /dev/null