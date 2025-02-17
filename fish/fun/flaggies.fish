#!/usr/bin/env fish

# [[sort on]]
alias --save dust 'dust -r' >/dev/null
alias --save eza 'eza --icons=auto --group-directories-first -x --time-style "+%y.%m.%d %H:%M" --smart-group' >/dev/null
alias --save fd 'fd --no-require-git' >/dev/null
alias --save icat 'kitten icat --align left' >/dev/null
alias --save jpeg2png 'jpeg2png -i 100 -w 1.0 -s' >/dev/null
alias --save less 'less --use-color -R' >/dev/null
alias --save octogit-set "octogit --color-all-commits ffd75f --color-all-staged 87ff5f --color-all-unstaged 00d7ff" >/dev/null
alias --save pipes 'pipes -p 3 -c 1 -c 2 -c 3 -c 4 -c 5 -R' >/dev/null
alias --save pv 'pv -g' >/dev/null
alias --save rg 'rg --engine auto' >/dev/null
alias --save rsync 'rsync --mkpath -P' >/dev/null
alias --save termdown 'termdown -W -f roman' >/dev/null
alias --save tree 'tree --noreport --dirsfirst --matchdirs --gitignore -Ca -I .git -I bin -I obj -I target -I .vscode' >/dev/null
alias --save tuisky 'tuisky -c ~/r/dot/tuisky.toml' >/dev/null
alias --save unimatrix 'unimatrix -s 95 -abf' >/dev/null
