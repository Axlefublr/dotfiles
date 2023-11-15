#!/usr/bin/env fish

function timer
	while true
		termdown $argv || return 1
		read -ln 1 response
		if not test $response
			return 1
		end
		if test $response = 'e'
			exit
		else if test $response = 'c' || test $response = ' ' || test $response = 'r'
			continue
		else
			break
		end
	end
end
funcsave timer > /dev/null

function alarm
	set -l input $argv[1]
	set -l first (string sub -l 1 $input)
	if test $first != 0 && test $first != 1 && test $first != 2
		set input '0'$input
	end
	set -l input (string pad -r -c 0 -w 6 $input)
	while test $input -gt (date +%H%M%S)
		sleep 0.1
	end
	sleep 0.5
end
funcsave alarm > /dev/null

function pom
	while true
		kitten @set-window-title action
		termdown 25m || break
		echo "You just acted! Rest now?"
		read -ln 1 should_continue
		if not test $should_continue
			break
		end
		clear

		kitten @set-window-title rest
		termdown 5m || break
		echo "You just rested! Act now?"
		read -ln 1 should_continue
		if not test $should_continue
			break
		end
		clear
	end
	clear
	kitten @set-window-title
end
funcsave pom > /dev/null