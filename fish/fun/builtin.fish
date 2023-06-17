#!/usr/bin/env fish

function fish_greeting
end
funcsave fish_greeting > /dev/null

function fish_title
	if set -q title
		echo $title
	else
		set auto_title (set -q argv[1] && echo " : $argv" || echo '')
		echo (fish_prompt_pwd)$auto_title
	end
end
funcsave fish_title > /dev/null

function fish_command_not_found
	echo "sorry, but the `$argv[1]` command doesn't exist"
end
funcsave fish_command_not_found > /dev/null