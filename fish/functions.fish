#!/usr/bin/env fish
function dlist
	for arg in $argv
		find $arg \( -name .git -o -name .npm -o -name .vscode -o -name obj \) -prune -o -type d -print
	end
end
funcsave dlist > /dev/null

function flist
	for arg in $argv
		find $arg \( -name .git -o -name .npm -o -name .vscode -o -name obj \) -prune -o -type f -print
	end
end
funcsave flist > /dev/null

function dpick
	dlist $argv | fzf -m --cycle | sed 's/^/\'/; s/$/\'/'
end
funcsave dpick > /dev/null

function fpick
	flist $argv | fzf -m --cycle | sed 's/^/\'/; s/$/\'/'
end
funcsave fpick > /dev/null

function smush
	tr '\n' ' ' | sed 's/[[:space:]]*$//'
end
funcsave smush > /dev/null

function cut
	ffmpeg.exe -i $argv[1] -ss $argv[3] -to $argv[4] -c:a copy $argv[2]
end
funcsave cut > /dev/null

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

function cutout
	ffmpeg.exe -i $argv[1] -to $argv[3] -c:a copy input1.mp4
	ffmpeg.exe -i $argv[1] -ss $argv[4] -c:a copy input2.mp4
	combine input1.mp4 input2.mp4 $argv[2]
	rm input1.mp4 input2.mp4
end
funcsave cutout > /dev/null

function timer
	termdown $argv && Ting.exe
end
funcsave timer > /dev/null

function gpa
	 set -l prevDir (pwd)
	 set -l directories $git_directories

	 for dir in $directories

		  cd $dir
		  set_color yellow
		  echo $dir
		  set_color normal
		  and git status -s
		  and git push 2> /dev/null

	 end

	 cd $prevDir
end
funcsave gpa > /dev/null

function prli
	printf '%s\n' $argv
end
funcsave prli > /dev/null

function _get_important_dir
	commandline -i (dpick $search_directories | smush)
end
funcsave _get_important_dir > /dev/null

function _cd_important_dir
	set -l picked (prli $plain_directories | fzf --cycle)
	if test $picked
		commandline "cd '$picked'"
		commandline -f execute
	end
end
funcsave _cd_important_dir > /dev/null

function _get_important_file
	commandline -i (fpick $search_directories | smush)
end
funcsave _get_important_file > /dev/null

function _open_important_file
	set -l picked (flist $search_directories | fzf --cycle)
	if test $picked
		commandline "nvim '$picked'"
		commandline -f execute
	end
end
funcsave _open_important_file > /dev/null

function _get_current_dir
	commandline -i (dpick . | smush)
end
funcsave _get_current_dir > /dev/null

function _cd_current_dir
	set -l picked (dlist . | fzf --cycle)
	if test $picked
		commandline "cd '$picked'"
		commandline -f execute
	end
end
funcsave _cd_current_dir > /dev/null

function _get_current_file
	commandline -i (fpick . | smush)
end
funcsave _get_current_file > /dev/null

function _open_current_file
	set -l picked (flist . | fzf --cycle)
	if test $picked
		commandline "nvim '$picked'"
		commandline -f execute
	end
end
funcsave _open_current_file > /dev/null

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

function fish_greeting
end
funcsave fish_greeting > /dev/null

function postvideo
	set -l prevDir (pwd)
	cd '/mnt/c/Pictures/Screenvideos'
	trash-put *
	cd ..
	trash-put *.png
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
	grep --color=always -Ern $argv &| less
end
funcsave argrep > /dev/null

function agrep
	grep --color=always -E $argv &| less
end
funcsave agrep > /dev/null

echo 'functions written'