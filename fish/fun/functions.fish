#!/usr/bin/env fish

function prli
	printf '%s\n' $argv
end
funcsave prli > /dev/null

function rga
	rg --color always $argv &| tee /tmp/pagie &| less
end
funcsave rga > /dev/null

function work
	while true
		termdown 25m -T 'Work!' || break
		termdown 5m -T 'Rest!' || break
	end
	clear -x
end
funcsave work > /dev/null

function tg
	set -l tempFile /tmp/tgptie
	nvim $tempFile
	set -l tempText (cat $tempFile)
	if test -z "$tempText"
		return 1
	end
	tgpt "$tempText"
end
funcsave tg > /dev/null

function _showie
	echo "$(cat /tmp/dickie)
$(cat /tmp/flickie)

$(cat /tmp/pagie)" &| less
end
funcsave _showie > /dev/null

function gi
	command -q uclanr || return 1
	set -l temp /tmp/(uclanr -j - 2)
	$EDITOR $temp
	printf (cat $temp)
end
funcsave gi > /dev/null