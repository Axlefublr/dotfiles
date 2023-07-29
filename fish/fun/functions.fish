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
		echo "You just worked! Rest now?"
		read -n 1
		clear
		termdown 5m -T 'Rest!' || break
		echo "You just rested! Work now?"
		read -n 1
		clear
	end
	clear
end
funcsave work > /dev/null

function tg
	$EDITOR /tmp/gi
	set -l tempText (cat /tmp/gi)
	if test -z "$tempText"
		return 1
	end
	tgpt "$tempText"
end
funcsave tg > /dev/null