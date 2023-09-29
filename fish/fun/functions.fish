#!/usr/bin/env fish

function mkcd
	mkdir -p $argv && z $argv
end
funcsave mkcd > /dev/null

function prli
	printf '%s\n' $argv
end
funcsave prli > /dev/null

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

function rename
	mv $argv[1] _$argv[1]
	mv _$argv[1] $argv[2]
end
funcsave rename > /dev/null

function abbrad
	abbr -a $argv
	echo "abbr -a $argv[1] '$argv[2..]'" >> ~/prog/dotfiles/fish/abbreviations.fish
end
funcsave abbrad > /dev/null

function abbrap
	abbr -a :"$argv[1]" --position anywhere -- $argv[2..]
	echo "abbr -a ,$argv[1] --position anywhere -- '$argv[2..]'" >> ~/prog/dotfiles/fish/positional.fish
end
funcsave abbrap > /dev/null

function atglo
	cd ~/.local/share/alien_temple
	git log --oneline
	cd -
end
funcsave atglo > /dev/null

function ats
	set -l shark (alien_temple shark)
	prli $shark
	echo $shark[1] | xclip -r -selection clipboard
end
funcsave ats > /dev/null

function atc
	alien_temple consent | tee /dev/tty | xclip -r -selection clipboard
end
funcsave atc > /dev/null

function screenie
	set -l current_date (date +%y.%m.%d)
	set -l screenshots_dir "/home/axlefublr/Pictures/Job"
	set -l location "$screenshots_dir/$current_date"

	mkdir -p $location

	while true
		scrot -F (date +"$location/%y.%m.%d-%H:%M.jpg") -q 30 &
		sleep 60
	end
end
funcsave screenie > /dev/null