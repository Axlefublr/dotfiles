#!/usr/bin/env fish

alias --save fd 'fd --no-require-git' > /dev/null
alias --save rg 'rg --engine auto' > /dev/null
alias --save less 'less --use-color -R' > /dev/null
alias --save termdown 'termdown -W -f roman' > /dev/null
alias --save tree 'tree --noreport --dirsfirst --matchdirs --gitignore -Ca -I .git -I bin -I obj -I target -I .vscode' > /dev/null
alias --save bell 'printf \a' > /dev/null
alias --save note 'printf "\n$argv" >> ~/prog/noties/tasks.txt' > /dev/null
alias --save vcl 'xclip -selection clipboard -o > /tmp/bibren ; nvim -n /tmp/bibren ; cat /tmp/bibren | xclip -r -selection clipboard' > /dev/null
alias --save toco 'touch $argv && code $argv' > /dev/null
alias --save octussy-set 'octussy --color-all-commits FFD75F \
	--color-all-staged 87FF5F \
	--color-all-unstaged 00D7FF' > /dev/null
alias --save etg 'shuf -n 1 ~/prog/noties/etg-actives.txt' > /dev/null
alias --save icat 'kitten icat --align left' > /dev/null

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