#!/usr/bin/env fish

trash-put "~/.config/fish/functions/*" 2> /dev/null

function prli
	printf '%s\n' $argv
end
funcsave prli > /dev/null

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

function print_parent_dir
	set -l input (pwd)
	set segments (string split "/" $input)
	set output ''
	echo '/'
	for segment in $segments[2..]
		set output "$output/$segment"
		echo $output
	end
	echo '.'
end
funcsave print_parent_dir > /dev/null

function pick_parent_dir
	print_parent_dir | fzf --cycle --tac
end
funcsave pick_parent_dir > /dev/null

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

function cut
	ffmpeg.exe -i $argv[1] -ss $argv[3] -to $argv[4] -c:a copy $argv[2]
end
funcsave cut > /dev/null

function cutfrom
	ffmpeg.exe -i $argv[1] -ss $argv[3] -c:a copy $argv[2]
end
funcsave cutfrom > /dev/null

function cutto
	ffmpeg.exe -i $argv[1] -ss 00:00 -to $argv[3] -c:a copy $argv[2]
end
funcsave cutto > /dev/null

function cutout
	ffmpeg.exe -i $argv[1] -to $argv[3] -c:a copy input1.mp4
	ffmpeg.exe -i $argv[1] -ss $argv[4] -c:a copy input2.mp4
	combine input1.mp4 input2.mp4 $argv[2]
	rm input1.mp4 input2.mp4
end
funcsave cutout > /dev/null

function compress
	ffmpeg.exe -i $argv[1] -c:v libx264 -crf 28 -preset veryslow -c:a aac -b:a 64k -movflags +faststart $argv[2]
end
funcsave compress > /dev/null

function combine
	ffmpeg.exe -i $argv[1] -c copy -bsf:v h264_mp4toannexb -f mpegts input1.ts
	ffmpeg.exe -i $argv[2] -c copy -bsf:v h264_mp4toannexb -f mpegts input2.ts
	echo "file 'input1.ts'
	file 'input2.ts'" > inputs.txt
	ffmpeg.exe -f concat -safe 0 -i inputs.txt -c copy $argv[3]
	rm inputs.txt input1.ts input2.ts
end
funcsave combine > /dev/null

function timer
	termdown $argv[1] && Ting.exe $argv[2]
end
funcsave timer > /dev/null

function gsa
	set -l prevDir (pwd)
	set -l directories $git_directories

	for dir in $directories

		cd $dir
		set_color yellow
		echo $dir
		set_color normal
		and git status -s

	end

	cd $prevDir
end
funcsave gsa > /dev/null

function gpa
	set -l prevDir (pwd)
	set -l directories $git_directories

	for dir in $directories

		cd $dir
		set_color yellow
		echo $dir
		set_color normal
		git push

	end

	cd $prevDir
end
funcsave gpa > /dev/null

function r
	set -l picked (history | set -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf --tiebreak=index)
	if test $picked
		commandline $picked
	end
end
funcsave r > /dev/null

function _history_replace
	set -l picked (history | sed -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf --tiebreak=index --query=(commandline))
	if test $picked
		commandline $picked
	end
end
funcsave _history_replace > /dev/null

function _history_insert
	commandline -i (history | sed -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf --tiebreak=index)
end
funcsave _history_insert > /dev/null

function postvideo
	set -l prevDir (pwd)
	cd '/mnt/c/Pictures/Screenvideos'
	trash-put "*"
	cd ..
	trash-put "*.png"
	cd $prevDir
end
funcsave postvideo > /dev/null

# made by https://github.com/Micha-ohne-el
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

function argrep
	grep --color=always -Ern $argv &> /tmp/pagie ; less /tmp/pagie
end
funcsave argrep > /dev/null

function agrep
	grep --color=always -E $argv &> /tmp/pagie ; less /tmp/pagie
end
funcsave agrep > /dev/null

function work
	while true
		timer 20m 'Work session ended, time to rest!' || break
		timer 5m 'I hope you rested well, time to work!' || break
	end
end
funcsave work > /dev/null

function tg
	set -l tempFile /tmp/tgptie
	$EDITOR -c 'startinsert' $tempFile
	set -l tempText (cat $tempFile)
	truncate -s 0 $tempFile
	if test -z "$tempText"
		return 1
	end
	tgpt "$tempText"
end
funcsave tg > /dev/null

function fish_prompt
	set -l statussy $pipestatus
	set_color $color_orange
	if test $USER != 'axlefublr'
		echo -n ' '$USER
	end
	if set -q SSH_TTY
		set_color $color_yellow
		echo -n '@'
		set_color $color_orange
		echo -n $hostname
	end
	set_color $color_pink
	printf ' '
	set -l git_repo_full (git rev-parse --show-toplevel 2> /dev/null)
	if test $git_repo_full
		set -l git_repo (basename $git_repo_full)
		set -l not_git_repo (string replace $git_repo '' $git_repo_full)
		printf (string replace "$not_git_repo" '' $PWD)
	else
		set -l home (string escape --style=regex $HOME)
		set -l cwd (string replace -r "^$home" '~' $PWD)
		set -l base (basename $cwd)
		printf $base
	end
	set -l curr_branch (git branch --show-current 2> /dev/null)
	if test curr_branch
		set_color $color_purple
		echo -n ' '$curr_branch
	end
	if set -q fish_private_mode
		set_color $color_white
		printf ' 󰗹 '
	end
	if test $SHLVL -gt 1
		set_color $color_yellow
		printf '  '$SHLVL
	end
	set -l stati (count $statussy)
	if test $stati -gt 1
		printf ' '
		for i in (seq $stati)
			if test $i -gt 1
				printf ' '
			end
			if test $statussy[$i] -ne 0
				set_color $color_red
			else
				set_color $color_green
			end
			printf $statussy[$i]
		end
	else
		if test $statussy -ne 0
			set_color $color_red
			printf ' ✘%s' $statussy
		end
	end
	set_color $color_yellow
	printf '\n╰─> '
	set_color normal
end
funcsave fish_prompt > /dev/null

function fish_greeting
end
funcsave fish_greeting > /dev/null

function fish_mode_prompt
	set_color $color_yellow
	switch $fish_bind_mode
		case insert
			echo '╭──'
		case '*'
			echo '╭─ '
	end
end
funcsave fish_mode_prompt > /dev/null

echo (set_color yellow)'functions written'