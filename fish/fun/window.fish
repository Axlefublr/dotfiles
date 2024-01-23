#!/usr/bin/env fish

function winwaitname
	set -l counter 0
	while test (xdotool search --onlyvisible --name $argv[1] | count) -lt 1
		set counter (math $counter + 1)
		if set -q argv[2]
			sleep $argv[2]
		end
		if set -q argv[4]
			if test $counter -ge $argv[4]
				return 1
			end
		end
	end
	if set -q argv[3]
		sleep $argv[3]
	end
end
funcsave winwaitname > /dev/null

function winwaitclass
	set -l counter 0
	while test (xdotool search --onlyvisible --class $argv[1] | count) -lt 1
		set counter (math $counter + 1)
		if set -q argv[2]
			sleep $argv[2]
		end
		if set -q argv[4]
			if test $counter -ge $argv[4]
				return 1
			end
		end
	end
	if set -q argv[3]
		sleep $argv[3]
	end
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