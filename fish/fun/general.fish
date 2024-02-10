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
		if string match -rq '/$' -- "$arg"
			mkdir -p "$arg"
		else
			set -l dir (string match -rg '(.*)/.+?$' -- "$arg")
			and mkdir -p "$dir"

			touch "$arg"
		end

		echo (realpath "$arg")
	end
end
funcsave new > /dev/null

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

function asmra
	set -l prevdir (pwd)
	cd ~/prog/info/socials
	printf '\n'$argv[1]
	git add asmr.txt
	git commit -m 'asmr: '$argv[1]
	cd $prevdir
end
funcsave asmra > /dev/null

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

function smdn
	set -l name $argv[1]

	set -l executable /home/axlefublr/prog/dotfiles/scripts/systemd/executables/$name.fish
	printf '#!/usr/bin/env fish' > $executable
	chmod +x $executable
	code $executable

	set -l service ~/prog/dotfiles/scripts/systemd/services/$name.service
	printf "[Service]
ExecStartPre=/home/axlefublr/prog/dotfiles/scripts/processwait.fish
ExecStart=$executable" > $service

	set -l timer ~/prog/dotfiles/scripts/systemd/timers/$name.timer
	printf '[Timer]
OnCalendar=*-*-8 05:00:00
Persistent=true

[Install]
WantedBy=timers.target' > $timer
	code $timer

	printf "

systemctl --user enable $name.timer
systemctl --user start $name.timer" >> ~/prog/dotfiles/scripts/systemd/definition.fish
end
funcsave smdn > /dev/null

function smdr
	set -l name $argv[1]
	rm -fr ~/prog/dotfiles/scripts/systemd/{services,timers,executables}/$name.*
	sd "

systemctl --user enable $name.timer
systemctl --user start $name.timer" '' ~/prog/dotfiles/scripts/systemd/definition.fish
end
funcsave smdr > /dev/null

function uboot
	paru
	if test (math (clorange updates show) % 5) -eq 0
		rustup update
	end
	if test (math (clorange updates show) % 3) -eq 0
		cargo mommy install-update -a
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
	set -l total 0
	for arg in $argv[2..]
		set total (math $total + $arg)
	end
	math "$argv[1] + ($total / 20) + $total"
end
funcsave take > /dev/null

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

function loopuntil
	set -l counter 0
	while true
		set output (eval $argv[1])
		if test $status -eq 0
			break
		end
		set counter (math $counter + 1)
		if set -q argv[2]
			sleep $argv[2]
		end
		if set -q argv[4]
			if test $counter -ge $argv[4]
				return 1
			end
		end
	end
	if set -q argv[3]
		sleep $argv[3]
	end
	for line in $output
		echo $line
	end
end
funcsave loopuntil > /dev/null