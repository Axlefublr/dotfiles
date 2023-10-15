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

function screenie
	set -l current_date (date +%d-%m-%Y)
	set -l job ~/Pictures/Job
	set -l location $job/$current_date
	set -l start_notice 175940
	set -l start 18
	set -l report 2140
	set -l finish 2200

	echo 'waiting for the start'
	alarm $start_notice
	bell
	notify-send -t 2000 -a 'Work' 'Starting in 20 seconds' &
	echo 'starting in 20 seconds'
	alarm $start

	mkdir -p $location
	echo 'started'

	while true
		set -l minute (date +"%d-%m-%Y-%H-%M.jpg")
		scrot -F $location/$minute -q 30 &
		echo $minute
		if test (date +%H%M) -eq $report
			notify-send -a 'Work' 'Send the report' &
		end
		if test (date +%H%M) -ge $finish
			notify-send -a 'Work' 'Stop right now!!'
			break
		end
		sleep 60
	end
	sleep 1
	cd $job
	zip -r $current_date.zip $current_date
	math (cat ~/prog/info/pswds/ftp/days || printf 0) + 1 > ~/prog/info/pswds/ftp/days
	read -ln 1 a
	cat ~/prog/info/pswds/ftp/host | xclip -r -selection clipboard
	echo 'host copied'
	read -ln 1 a
	cat ~/prog/info/pswds/ftp/user | xclip -r -selection clipboard
	echo 'user copied'
	read -ln 1 a
	cat ~/prog/info/pswds/ftp/pass | xclip -r -selection clipboard
	echo 'password copied'
	printf 'you now have: '
	dengi
end
funcsave screenie > /dev/null