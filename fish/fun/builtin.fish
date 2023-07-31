#!/usr/bin/env fish

function fish_greeting
end
funcsave fish_greeting > /dev/null

function fish_title
	if set -q title && not test "$title" = ''
		echo $title
		return
	end

	set -l command_name
	if set -q argv[1]
		set command_name ':'(string match -r '^\\s*\w+' $argv[1])
	else
		set command_name ''
	end
	echo (basename $PWD)$command_name
end
funcsave fish_title > /dev/null

function fish_command_not_found
	echo "sorry, but the `$argv[1]` command doesn't exist"
end
funcsave fish_command_not_found > /dev/null

function list_current_token -d "List contents of token under the cursor (including dotfiles) if it is a directory, otherwise list the contents of the current directory"
	set -l val (commandline -t)
	clear -x
	if test -d $val
		ls -A $val
	else
		set -l dir (dirname -- $val)
		if test $dir != . -a -d $dir
			ls -A $dir
		else
			ls -A
		end
	end

	string repeat -N \n --count=(math (count (fish_prompt)) - 1)

	commandline -f repaint
end
funcsave list_current_token > /dev/null