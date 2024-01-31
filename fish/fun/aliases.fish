#!/usr/bin/env fish

alias --save fd 'fd --no-require-git' > /dev/null
alias --save rg 'rg --engine auto' > /dev/null
alias --save less 'less --use-color -R' > /dev/null
alias --save termdown 'termdown -W -f roman' > /dev/null
alias --save tree 'tree --noreport --dirsfirst --matchdirs --gitignore -Ca -I .git -I bin -I obj -I target -I .vscode' > /dev/null
alias --save bell 'printf \a' > /dev/null
alias --save note 'printf "\n$argv" >> ~/prog/noties/tasks.txt' > /dev/null
alias --save vcl 'xclip -selection clipboard -o > /tmp/bibren ; nvim -n /tmp/bibren ; cat /tmp/bibren | xclip -r -selection clipboard' > /dev/null
alias --save vcll 'truncate -s 0 /tmp/bibren ; nvim -n /tmp/bibren ; cat /tmp/bibren | xclip -r -selection clipboard' > /dev/null
alias --save toco 'touch $argv && code $argv' > /dev/null
alias --save octogit-set "octogit --color-all-commits $color_yellow \
	--color-all-staged $color_green \
	--color-all-unstaged $color_cyan" > /dev/null
alias --save etg 'shuf -n 1 ~/prog/noties/etg-actives.txt' > /dev/null
alias --save icat 'kitten icat --align left' > /dev/null
alias --save logout 'qdbus org.kde.ksmserver /KSMServer logout 0 0 0' > /dev/null
alias --save woman 'man' > /dev/null # lol and even lmao

function mkcd
	mkdir -p $argv && z $argv
end
funcsave mkcd > /dev/null

function ghrclc
	gh repo clone $argv &&
	cd (path basename $argv)
end
funcsave ghrclc > /dev/null

function vf
	commandline "nvim "(fzf)
	commandline -f execute
end
funcsave vf > /dev/null

function codef
	commandline "code "(fzf)
	commandline -f execute
end
funcsave codef > /dev/null

function xrestart
	killall xremap
	xremap --mouse --watch ~/prog/dotfiles/xremap/config.yml &> /tmp/log/xremap.txt & disown
end
funcsave xrestart > /dev/null

function grostart
	killall gromit-mpx
	gromit-mpx -k "none" -u "none" &> /tmp/log/gromit-mpx.txt & disown
end
funcsave grostart > /dev/null

function ollamastart
	killall ollama
	ollama serve &> /tmp/log/ollama.txt & disown
end
funcsave ollamastart > /dev/null

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

function asmra
	set -l prevdir (pwd)
	cd ~/prog/info/socials
	printf '\n'$argv[1]
	git add asmr.txt
	git commit -m 'asmr: '$argv[1]
	cd $prevdir
end
funcsave asmra > /dev/null