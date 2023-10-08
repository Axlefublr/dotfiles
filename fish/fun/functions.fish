#!/usr/bin/env fish

function mkcd
	mkdir -p $argv && z $argv
end
funcsave mkcd > /dev/null

function prli
	printf '%s\n' $argv
end
funcsave prli > /dev/null

function tg
	$EDITOR /tmp/gi
	set -l tempText (cat /tmp/gi)
	if test -z "$tempText"
		return 1
	end
	tgpt "$tempText"
end
funcsave tg > /dev/null

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

function rename
	mv $argv[1] _$argv[1]
	mv _$argv[1] $argv[2]
end
funcsave rename > /dev/null

function abbrad
	abbr -a $argv
	echo "abbr -a $argv[1] '$argv[2..]'" >> ~/prog/dotfiles/fish/abbreviations.fish
end
funcsave abbrad > /dev/null

function abbrap
	abbr -a :"$argv[1]" --position anywhere -- $argv[2..]
	echo "abbr -a ,$argv[1] --position anywhere -- '$argv[2..]'" >> ~/prog/dotfiles/fish/positional.fish
end
funcsave abbrap > /dev/null

function ats
	set -l shark (alien_temple shark)
	prli $shark
	echo $shark[1] | xclip -r -selection clipboard
end
funcsave ats > /dev/null

function atc
	alien_temple consent | tee /dev/tty | xclip -r -selection clipboard
end
funcsave atc > /dev/null

function plm
	set -l daily 4800
	set -l commission 404
	set -l days (cat ~/prog/info/pswds/ftp/days)
	math $days '*' $daily / 100 '*' 98 - $commission
end
funcsave plm > /dev/null

function plo
	printf 1 > ~/prog/info/pswds/ftp/days
end
funcsave plo > /dev/null

function plof
	printf 0 > ~/prog/info/pswds/ftp/days
end
funcsave plof > /dev/null