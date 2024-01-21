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
alias --save octussy-set 'octussy --color-all-commits FFD75F \
	--color-all-staged 87FF5F \
	--color-all-unstaged 00D7FF' > /dev/null
alias --save etg 'shuf -n 1 ~/prog/noties/etg-actives.txt' > /dev/null
alias --save icat 'kitten icat --align left' > /dev/null
alias --save logout 'qdbus org.kde.ksmserver /KSMServer logout 0 0 0' > /dev/null

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

function sysd-new
	set -l name $argv[1]

	set -l executable ~/prog/dotfiles/scripts/systemd/executables/$name.fish
	printf '#!/usr/bin/env fish' > $executable
	chmod +x $executable
	code $executable

	set -l service ~/prog/dotfiles/scripts/systemd/services/$name.service
	printf "[Service]
ExecStart=$executable" > $service

	set -l timer ~/prog/dotfiles/scripts/systemd/timers/$name.timer
	printf '[Timer]
OnCalendar=*-*-18 05:00:00
Persistent=true

[Install]
WantedBy=timers.target' > $timer
	code $timer

	printf "

systemctl --user enable $name.timer
systemctl --user start $name.timer" >> ~/prog/dotfiles/scripts/systemd/definition.fish
end
funcsave sysd-new > /dev/null


function sysd-rm
	set -l name $argv[1]
	rm -fr ~/prog/dotfiles/scripts/systemd/{services,timers,executables}/$name.*
	sd "

systemctl --user enable $name.timer
systemctl --user start $name.timer" '' ~/prog/dotfiles/scripts/systemd/definition.fish
end
funcsave sysd-rm > /dev/null