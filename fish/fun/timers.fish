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
	while test $argv[1] -gt (date +%H%M%S)
		sleep 0.5
	end
	bell
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

function screenie
	set -l current_date (date +%d-%m-%Y)
	set -l location ~/Pictures/Job/$current_date
	set -l start_notice 175950
	set -l report 2140
	set -l finish 2200

	mkdir -p $location

	alarm $start_notice
	notify-send -t 2000 -a 'Work' 'Starting in ten seconds' &
	sleep 10
	while true
		scrot -F $location/(date +"%d-%m-%Y-%H-%M.jpg") -q 30 &
		if test (date +%H%M) -eq $report
			notify-send -a 'Work' 'Send the report' &
		end
		if test (date +%H%M) -ge $finish
			notify-send -a 'Work' 'Stop right now!!'
			break
		end
		sleep 60
	end
	zip -r $location.zip $location
	math (cat ~/prog/info/pswds/ftp/days || printf 0) + 1 > ~/prog/info/pswds/ftp/days
	printf 'you now have: '
	plm
end
funcsave screenie > /dev/null
