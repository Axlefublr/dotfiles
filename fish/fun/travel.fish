#!/usr/bin/env fish

function tippity_tappity
	set -l picked (fd -u -tf -td '' (commandline -t | string replace -r '^$' '.' | string replace -r '^~' $HOME) | fzf -e --cycle --tac | string replace $HOME '~')
	commandline -t $picked
	commandline -f repaint
end
funcsave tippity_tappity > /dev/null