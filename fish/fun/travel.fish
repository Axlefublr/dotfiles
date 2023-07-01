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

function ks
	set -l picked (pick . true)
	if not test $picked
		return 1
	end
	cd $picked
end
funcsave ks > /dev/null

function js
	set -l picked (pick .)
	if not test $picked || not test -f $picked
		return 1
	end
	$EDITOR $picked
end
funcsave js > /dev/null

function kd
	ranger --choosedir /tmp/dickie
	set -l picked (cat /tmp/dickie)
	if not test $picked
		return 1
	end
	cd $picked
end
funcsave kd > /dev/null

function paste_ranger_file
	ranger --choosefile /tmp/flickie
	commandline -i (cat /tmp/flickie)
	commandline -f repaint
end
funcsave paste_ranger_file > /dev/null

function paste_ranger_dir
	ranger --choosedir /tmp/dickie
	commandline -i (cat /tmp/dickie)
	commandline -f repaint
end
funcsave paste_ranger_dir > /dev/null

function paste_relative_path
	set -l picked (pick .)
	if not test $picked
		return 1
	end
	commandline -i $picked
end
funcsave paste_relative_path > /dev/null