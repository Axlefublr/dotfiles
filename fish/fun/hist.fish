#!/usr/bin/env fish

function r
	set -l picked (history | sed -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf --tiebreak=index)
	if test $picked
		commandline $picked
	end
end
funcsave r > /dev/null

function hist_replace
	set -l picked (history | sed -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf --tiebreak=index --query=(commandline))
	if test $picked
		commandline $picked
	end
end
funcsave hist_replace > /dev/null

function hist_insert
	commandline -i (history | sed -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf --tiebreak=index)
end
funcsave hist_insert > /dev/null
