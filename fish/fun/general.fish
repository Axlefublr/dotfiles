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

function uboot
	paru
	if test (math (clorange updates show) % 5) -eq 0
		rustup update
	end
	if test (math (clorange updates show) % 3) -eq 0
		cargo install-update -a
	end
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

function take
	math "$argv[1] + ($argv[2] / 20) + $argv[2]"
end
funcsave take > /dev/null

function ate
	printf '\n'(date '+%y.%m.%d %H:%M') >> ~/.local/share/hungry
end
funcsave ate > /dev/null

function bak
	set -l full_path $argv[1]
	set -l file_name (basename $full_path)
	set -l extension (path extension $full_path)
	mkdir -p $full_path.bak
	clorange $file_name increment
	set -l current (clorange $file_name show)
	cp -f $full_path $full_path.bak/$current$extension
	set -l cutoff (math $current - 50)
	if test $cutoff -ge 1
		rm -fr $full_path.bak/$cutoff$extension
	end
end
funcsave bak > /dev/null