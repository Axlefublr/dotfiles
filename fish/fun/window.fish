#!/usr/bin/env fish

function get_windows
	wmctrl -xl | awk '{printf "%s — %s —", $1, $3; for (i=5; i<=NF; i++) printf " %s", $i; print ""}'
end
funcsave get_windows > /dev/null

function matches
	get_windows | rg $argv[1]
end
funcsave matches > /dev/null

function matches_except
	get_windows | rg -v $argv[1] | rg $argv[2]
end
funcsave matches_except > /dev/null

function win_wait
	loopuntil "matches '$argv[1]'" $argv[2..] | awk '{print $1}'
end
funcsave win_wait > /dev/null

function win_wait_except
	loopuntil "matches_except '$argv[1]' '$argv[2]'" $argv[3..] | awk '{print $1}'
end
funcsave win_wait_except > /dev/null

function move_all
	if not set -q argv[2]
		return 1
	end
	set -l tag (math $argv[1] - 1)
	for win_id in $argv[2..]
		wmctrl -ir $win_id -t $tag
	end
end
funcsave move_all > /dev/null

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