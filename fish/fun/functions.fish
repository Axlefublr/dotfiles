#!/usr/bin/env fish

function prli
	printf '%s\n' $argv
end
funcsave prli > /dev/null

function timer
	termdown $argv[1] && Ting.exe $argv[2..]
end
funcsave timer > /dev/null

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