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
	$EDITOR /tmp/gi
	set -l tempText (cat /tmp/gi)
	if test -z "$tempText"
		return 1
	end
	tgpt "$tempText"
end
funcsave tg > /dev/null