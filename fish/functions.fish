#!usr/bin/fish
function dlist
	for arg in $argv
		find $arg \( -name .git -o -name .npm -o -name .vscode -o -name obj \) -prune -o -type d -print
	end
end
funcsave dlist

function flist
	for arg in $argv
		find $arg \( -name .git -o -name .npm -o -name .vscode -o -name obj \) -prune -o -type f -print
	end
end
funcsave flist

function dpick
	dlist $argv | fzf -m --tac --cycle | sed 's/^/\'/; s/$/\'/'
end
funcsave dpick

function fpick
	flist $argv | fzf -m --tac --cycle | sed 's/^/\'/; s/$/\'/'
end
funcsave fpick

function smush
	tr '\n' ' ' | sed 's/[[:space:]]*$//'
end
funcsave smush

function cut
	ffmpeg.exe -i $argv[1] -ss $argv[3] -to $argv[4] -c:a copy $argv[2]
end
funcsave cut

function compress
	ffmpeg.exe -i $argv[1] -c:v libx264 -crf 28 -preset veryslow -c:a aac -b:a 64k -movflags +faststart $argv[2]
end
funcsave compress

function combine
	ffmpeg.exe -i $argv[1] -c copy -bsf:v h264_mp4toannexb -f mpegts input1.ts
	ffmpeg.exe -i $argv[2] -c copy -bsf:v h264_mp4toannexb -f mpegts input2.ts
	echo "file 'input1.ts'
	file 'input2.ts'" > inputs.txt
	ffmpeg.exe -f concat -safe 0 -i inputs.txt -c copy $argv[3]
	rm inputs.txt input1.ts input2.ts
end
funcsave combine

function cutout
	ffmpeg.exe -i $argv[1] -to $argv[3] -c:a copy input1.mp4
	ffmpeg.exe -i $argv[1] -ss $argv[4] -c:a copy input2.mp4
	combine input1.mp4 input2.mp4 $argv[2]
	rm input1.mp4 input2.mp4
end
funcsave cutout

function timer
	termdown $argv && Ting.exe
end
funcsave timer

function gpa
	set -l prevDir (pwd)
	cd /mnt/c/Programming/dotfiles
	pwd
	git status
	git push
	cd ../info
	printf \n\n
	pwd
	git status
	git push
	cd ../main
	printf \n\n
	pwd
	git status
	git push
	cd ../music
	printf \n\n
	pwd
	git status
	git push
	cd /mnt/c/Users/axlefublr/Documents/Autohotkey/Lib
	printf \n\n
	pwd
	git status
	git push
	cd /mnt/c/Pictures/Tree
	printf \n\n
	pwd
	git status
	git push
	cd ../Tools
	printf \n\n
	pwd
	git status
	git push
	cd $prevDir
end
funcsave gpa

function _get_important_dir
	commandline -i (dpick /mnt/c/Programming /mnt/c/Users/axlefublr/Documents/AutoHotkey/Lib /mnt/c/Pictures /mnt/c/Audio | smush)
end
funcsave _get_important_dir

function _get_important_file
	commandline -i (fpick /mnt/c/Programming /mnt/c/Users/axlefublr/Documents/AutoHotkey/Lib /mnt/c/Pictures /mnt/c/Audio | smush)
end
funcsave _get_important_file

function _get_current_dir
	commandline -i (dpick . | smush)
end
funcsave _get_current_dir

function _get_current_file
	commandline -i (fpick . | smush)
end
funcsave _get_current_file

function _history_replace
	commandline (history | sed -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf --tiebreak=index --query=(commandline))
end
funcsave _history_replace

function _history_insert
	commandline -i (history | sed -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf --tiebreak=index)
end
funcsave _history_insert

function _copy_command_buffer
	commandline | fish_clipboard_copy
end
funcsave _copy_command_buffer

function fish_greeting
end
funcsave fish_greeting