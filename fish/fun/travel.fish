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
