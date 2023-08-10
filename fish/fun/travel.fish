#!/usr/bin/env fish

function pick
	set -l current $argv[1]
	set -l here $argv[1]
	while test -d $current
		set here (ls $current -Ab -w 1 2> /dev/null)
		if test (echo $here) = ''
			break
		end
		if set -q argv[2] # prune out files if you pass the 2nd argument
			set -l newHere
			for obj in $here
				if not test -f $current/$obj
					set newHere $newHere $obj
				end
			end
			set here $newHere
		end
		if test (echo $here) = ''
			break
		end
		set here (prli $here | fzf -e --cycle --tac)
		if not test $here
			break
		end
		set current "$current/$here"
	end
	if test $current = '.'
		return 1
	end
	set current (string replace -r '^\/\/' '/' $current)
	printf $current | tee /tmp/pickie
end
funcsave pick > /dev/null

function paste_relative_path
	set -l picked (pick .)
	if not test $picked
		return 1
	end
	commandline -i $picked
end
funcsave paste_relative_path > /dev/null

function swoosh
	set -l parent_path
	set -l base_path
	set -l index 0
	for dir in $starred_directories
		set index (math $index + 1)
		set base_path $base_path $index.\ (basename $dir)
		set parent_path $parent_path (path dirname $dir)
	end

	set -l picked_index (prli $base_path | fzf -e --cycle | string match -r '^\\d+')
	if not test $picked_index
		return 1
	end

	set -l no_index_base_path
	for indexed_dir in $base_path
		set no_index_base_path $no_index_base_path (string replace -r '^\\d+\\. ' '' $indexed_dir)
	end

	set -l final_dir "$parent_path[$picked_index]/$no_index_base_path[$picked_index]"
	set -l cd_cmd 'cd '(string escape -n $final_dir | string replace -r "^$HOME" '~')
	commandline $cd_cmd
	commandline -f execute
end
funcsave swoosh > /dev/null