#!/usr/bin/env fish

function pick
	set -l current $argv[1]
	set -l here $argv[1]
	while test -d $current
		set here (ls $current -Ab -w 1 2> /dev/null | fzf --cycle)
		if not test $here
			break
		end
		set current "$current/$here"
	end
	set current (string replace -r '^\/\/' '/' $current)
	printf $current
end
funcsave pick > /dev/null

function get_parent_dir
	set -l input (pwd)
	set input (string split '/' $input)[2..]
	set -l parts '/' $input '.'
	set -l picked (prli $parts | fzf --cycle --tac)
	set -l output $picked
	if not test $picked = '.' && not test $picked = '/'
		set output
		for segment in $parts[2..]
			set output "$output/$segment"
			if test $segment = $picked
				break
			end
		end
	end
	echo $output
end
funcsave get_parent_dir > /dev/null

function pick_plain
	prli $plain_directories | fzf --cycle
end
funcsave pick_plain > /dev/null

function ks
	set -l picked (pick .)
	if test $picked
		commandline "cd $picked"
		commandline -f execute
	end
end
funcsave ks > /dev/null

function kf
	set -l init (pick_parent_dir)
	if not test $init
		return 1
	end
	set -l picked (pick $init)
	if not test $picked
		return 1
	end
	commandline "cd $picked"
	commandline -f execute
end
funcsave kf > /dev/null

function js
	set -l picked (pick .)
	if test $picked
		commandline "nvim $picked"
		commandline -f execute
	end
end
funcsave js > /dev/null

function finde
	set -l paths
	set -l options
	set -l current_list paths

	for arg in $argv
		if test $arg = "--"
			set current_list options
			continue
		end

		if test $current_list = "paths"
			set paths $paths $arg
		else
			set options $options $arg
		end
	end
	find $paths \( -name .git -o -name .npm -o -name .vscode -o -name obj -o -name target \) -prune -o $options -not -name '.' -not -name '..' -print
end
funcsave finde > /dev/null

echo (set_color yellow)'functions written'