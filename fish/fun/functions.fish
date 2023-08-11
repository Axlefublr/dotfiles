#!/usr/bin/env fish

function prli
	printf '%s\n' $argv
end
funcsave prli > /dev/null

function rga
	rg --color always $argv &| tee /tmp/pagie &| less
end
funcsave rga > /dev/null

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

function tg
	$EDITOR /tmp/gi
	set -l tempText (cat /tmp/gi)
	if test -z "$tempText"
		return 1
	end
	tgpt "$tempText"
end
funcsave tg > /dev/null

function set_title
	echo -ne "\e]0;$argv[1]\a"
end
funcsave set_title > /dev/null

function new --description='Creates new files or directories and all required parent directories'
	for arg in $argv
		if string match -rq '/$' -- $arg
			mkdir -p $arg
		else
			set -l dir (string match -rg '(.*)/.+?$' -- $arg)
			and mkdir -p $dir

			touch $arg
		end
	end
end
funcsave new > /dev/null