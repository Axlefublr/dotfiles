#!/usr/bin/env fish

#----------------------------------------------default behavior----------------------------------------------
alias --save unimatrix 'unimatrix -s 95 -abf' >/dev/null
alias --save fd 'fd --no-require-git' >/dev/null
alias --save rg 'rg --engine auto' >/dev/null
alias --save less 'less --use-color -R' >/dev/null
alias --save termdown 'termdown -W -f roman' >/dev/null
alias --save tree 'tree --noreport --dirsfirst --matchdirs --gitignore -Ca -I .git -I bin -I obj -I target -I .vscode' >/dev/null
alias --save ttyper 'ttyper -l uclanr -w 25' >/dev/null
alias --save icat 'kitten icat --align left' >/dev/null
alias --save tgpt 'tgpt -q' >/dev/null
alias --save yt-dlp 'yt-dlp $argv ; bell' >/dev/null
alias --save scrot 'scrot -i -l color=#ffafd7,mode=edge,width=2' >/dev/null
alias --save gromit 'gromit-mpx -o 1 -k "none" -u "none"' >/dev/null
alias --save dust 'dust -r' >/dev/null
alias --save screenkey 'screenkey --no-systray --position top --font-size small --key-mode translated --bak-mode full --mods-mod normal --font "JetBrainsMonoNL Nerd Font" --font-color "#d4be98" --bg-color "#1f1e1e" --opacity 1.0 --compr-cnt 3 -g 400x800+1520-325' >/dev/null
alias --save octogit-set "octogit --color-all-commits ffd75f \
	--color-all-staged 87ff5f \
	--color-all-unstaged 00d7ff" >/dev/null
alias --save rofi_multi_select 'rofi -dmenu -multi-select -ballot-selected-str " " -ballot-unselected-str "  "' >/dev/null # you can't put the default ballot thingies in your config, this unfortunately has to be an alias (last I checked; could've changed)
alias --save pipes 'pipes -p 3 -c 1 -c 2 -c 3 -c 4 -c 5 -R' >/dev/null
alias --save eza 'eza --icons=auto --group-directories-first -x --time-style "+%y.%m.%d %H:%M" --smart-group' >/dev/null
alias --save jpeg2png 'jpeg2png -i 100 -w 1.0 -s' >/dev/null

#----------------------------------------------------direct----------------------------------------------------
alias --save bell 'printf \a' >/dev/null
alias --save woman man >/dev/null # lol and even lmao
alias --save suspend 'systemctl suspend' >/dev/null

#----------------------------------------------------other----------------------------------------------------
alias --save awart 'awesome-client "awesome.restart()"' >/dev/null
alias --save ezagit 'eza --git --git-repos' >/dev/null

function rdp
    set_color '#ffd75f'
    printf '󱕅 '
    set_color normal
end
funcsave rdp >/dev/null
