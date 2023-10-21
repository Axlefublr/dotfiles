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
		else if test $response = 'c'
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

function work
	clear

	set -l was_title_set
	if set -q title
		set was_title_set true
	else
		set was_title_set false
	end

	set -l prev_title
	if test was_title_set
		set prev_title $title
	end

	while true
		set -g title work
		set_title work
		termdown 25m || break
		echo "You just worked! Rest now?"
		read -ln 1 should_continue
		if not test $should_continue
			break
		end
		clear

		set -g title rest
		set_title rest
		termdown 5m || break
		echo "You just rested! Work now?"
		read -ln 1 should_continue
		if not test $should_continue
			break
		end
		clear
	end

	if test was_title_set
		set -g title $prev_title
	else
		set -e title
	end

	clear
end
funcsave work > /dev/null