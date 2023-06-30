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

function get_parent_dir
	set -l input (pwd)
	set input (string split '/' $input)[2..]
	set -l parts '/' $input
	set -l picked (prli $parts | fzf -e --cycle --tac)
	if not test $picked
		return 1
	end
	set -l output $picked
	if not test $picked = '/'
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

function get_important_dir
	prli $important_directories | fzf -e --cycle
end
funcsave get_important_dir > /dev/null

function akd
	set important_directories $PWD $important_directories
end
funcsave akd > /dev/null

function ks
	set -l picked (pick . true)
	if not test $picked
		return 1
	end
	cd $picked
end
funcsave ks > /dev/null

function kd
	set -l init (get_important_dir)
	if not test $init
		return 1
	end
	set -l picked (pick $init true)
	if not test $picked
		return 1
	end
	cd $picked
end
funcsave kd > /dev/null

function kf
	set -l init (get_parent_dir)
	if not test $init
		return 1
	end
	set -l picked (pick $init true)
	if not test $picked
		return 1
	end
	cd $picked
end
funcsave kf > /dev/null

function js
	set -l picked (pick .)
	if not test $picked || not test -f $picked
		return 1
	end
	$EDITOR $picked
end
funcsave js > /dev/null

function jd
	set -l init (get_important_dir)
	if not test $init
		return 1
	end
	set -l picked (pick $init)
	if not test $picked || not test -f $picked
		return 1
	end
	$EDITOR $picked
end
funcsave jd > /dev/null

function jf
	set -l init (get_parent_dir)
	if not test $init
		return 1
	end
	set -l picked (pick $init)
	if not test $picked || not test -f $picked
		return 1
	end
	$EDITOR $picked
end
funcsave jf > /dev/null

function paste_ranger_file
	ranger --choosefile /tmp/flickie
	commandline -i (cat /tmp/flickie)
end
funcsave paste_ranger_file > /dev/null

function paste_ranger_dir
	ranger --choosedir /tmp/dickie
	commandline -i (cat /tmp/dickie)
end
funcsave paste_ranger_dir > /dev/null

function paste_parent_path
	set -l init (get_parent_dir)
	if not test $init
		return 1
	end
	set -l picked (pick $init)
	if not test $picked
		return 1
	end
	commandline -i $picked
end
funcsave paste_parent_path > /dev/null

function paste_important_path
	set -l init (get_important_dir)
	if not test $init
		return 1
	end
	set -l picked (pick $init)
	if not test $picked
		return 1
	end
	commandline -i $picked
end
funcsave paste_important_path > /dev/null

function paste_relative_path
	set -l picked (pick .)
	if not test $picked
		return 1
	end
	commandline -i $picked
end
funcsave paste_relative_path > /dev/null