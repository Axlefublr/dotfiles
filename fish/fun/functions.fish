#!/usr/bin/env fish

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
	echo "abbr -a $argv[1] '$argv[2..]'" >> ~/prog/dotfiles/fish/abbreviations/abbreviations.fish
end
funcsave abbrad > /dev/null

function abbrap
	abbr -a :"$argv[1]" --position anywhere -- $argv[2..]
	echo "abbr -a ,$argv[1] --position anywhere -- '$argv[2..]'" >> ~/prog/dotfiles/fish/abbreviations/positional.fish
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

function winwaitname
	while not test (xdotool search --onlyvisible --name $argv[1])
	end
	if set -q argv[2]
		sleep $argv[2]
	end
end
funcsave winwaitname > /dev/null

function uboot
	yay
	if test (math (clorange updates show) % 5) -eq 0
		rustup update
	end
	cargo install-update -a
	clorange updates increment
	loago do update
	bell
	read -ln 1 response
	if test $response = "r"
		reboot
	else if test $response = "l"
		qdbus org.kde.ksmserver /KSMServer logout 0 0 0
	else if test $response = "s"
		poweroff
	end
end
funcsave uboot > /dev/null

function minigun-save
	set -l coords (xdotool getmouselocation | string match -gr '\\w:(\\d+) \\w:(\\d+)')
	printf $coords[1]' '$coords[2] > ~/.local/share/minigun/$argv[1]
end
funcsave minigun-save > /dev/null

function minigun-apply
	set -l coords (cat ~/.local/share/minigun/$argv[1] | string split ' ')
	xdotool mousemove $coords[1] $coords[2]
end
funcsave minigun-apply > /dev/null

function take
	math "$argv[1] + ($argv[2] / 20) + $argv[2]"
end
funcsave take > /dev/null