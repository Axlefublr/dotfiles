#!/usr/bin/env fish

function fish_greeting
end
funcsave fish_greeting > /dev/null

function fish_title
	if set -q title
		echo $title
	else
		set auto_title (set -q argv[1] && echo " : $argv" || echo '')
		echo (basename $PWD)$auto_title
	end
end
funcsave fish_title > /dev/null