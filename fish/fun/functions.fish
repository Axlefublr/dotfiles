#!/usr/bin/env fish

function prli
	printf '%s\n' $argv
end
funcsave prli > /dev/null

function timer
	termdown $argv[1] && Ting.exe $argv[2..]
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
	set -l picked (history | sed -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf --tiebreak=index)
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
	grep --color=always -Ern $argv &| tee /tmp/pagie &| less
end
funcsave argrep > /dev/null

function agrep
	grep --color=always -E $argv &| tee /tmp/pagie &| less
end
funcsave agrep > /dev/null

function work
	while true
		timer 20m 'Work session ended, time to rest!' no || break
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

echo (set_color yellow)'functions written'