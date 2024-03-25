#!/usr/bin/env fish

alias --save fd 'fd --no-require-git' >/dev/null
alias --save rg 'rg --engine auto' >/dev/null
alias --save less 'less --use-color -R' >/dev/null
alias --save termdown 'termdown -W -f roman' >/dev/null
alias --save tree 'tree --noreport --dirsfirst --matchdirs --gitignore -Ca -I .git -I bin -I obj -I target -I .vscode' >/dev/null
alias --save bell 'printf \a' >/dev/null
alias --save toco 'touch $argv && code $argv' >/dev/null
alias --save octogit-set "octogit --color-all-commits $color_yellow \
	--color-all-staged $color_green \
	--color-all-unstaged $color_cyan" >/dev/null
alias --save etg 'shuf -n 1 ~/prog/noties/etg-actives.txt' >/dev/null
alias --save icat 'kitten icat --align left' >/dev/null
alias --save woman man >/dev/null # lol and even lmao
alias --save tgpt 'tgpt -q --provider phind' >/dev/null
alias --save yt-dlp 'yt-dlp $argv ; bell' >/dev/null
alias --save scrot 'scrot -i -l color=#ffafd7,mode=edge,width=2' >/dev/null
alias --save dmenu "dmenu -fn 'JetBrainsMonoNL NF:size=16' -nb '#292828' -nf '#d4be98' -sb '#ffd75f' -sf '#0f0f0f' -l 10" >/dev/null
alias --save suspend 'systemctl suspend' >/dev/null
alias --save screenkey 'screenkey --no-systray --position top --font-size small --key-mode translated --bak-mode full --mods-mod normal --font "JetBrainsMonoNL Nerd Font" --font-color "#d4be98" --bg-color "#1a1919" --opacity 0.7 --compr-cnt 3 --mouse -g 500x1080+1420-73' >/dev/null
alias --save rofi-multi-select 'rofi -dmenu -multi-select -ballot-selected-str " " -ballot-unselected-str "  "' >/dev/null
alias --save awart 'awesome-client "awesome.restart()"' >/dev/null
alias --save gromit 'gromit-mpx -o 1 -k "none" -u "none"' >/dev/null
alias --save dust 'dust -r' >/dev/null
alias --save neomax 'alacritty -T neomax -e nvim' >/dev/null
alias --save neoline 'alacritty -T neoline -e nvim' >/dev/null
alias --save eza 'eza --icons=auto --group-directories-first -x --time-style "+%y.%m.%d %H:%M" --smart-group' >/dev/null
alias --save ez 'eza --git --git-repos' >/dev/null

function rlc
    realpath $argv | xclip -r -selection clipboard
end
funcsave rlc >/dev/null

function mkcd
    mkdir -p $argv && z $argv && clear -x
end
funcsave mkcd >/dev/null

function ghrclc
    gh repo clone $argv
    z (path basename $argv[1])
    clear -x
end
funcsave ghrclc >/dev/null

function xrestart
    killall xremap
    xremap --mouse ~/prog/dotfiles/xremap.yml &>/tmp/log/xremap.txt & disown
end
funcsave xrestart >/dev/null

function xwaaa
    xset r rate 170 35 &>/tmp/log/xset.txt
    setxkbmap -layout us,ru -option "compose:sclk" &>/tmp/log/setxkbmap.txt
end
funcsave xwaaa >/dev/null

function xrestartwaaa
    xrestart
    notify-send -t 2000 'restarted xremap'
    sleep 3
    xwaaa
    notify-send -t 2000 'applied xset'
end
funcsave xrestartwaaa >/dev/null

function grostart
    killall gromit-mpx
    gromit &>/tmp/log/gromit.txt & disown
end
funcsave grostart >/dev/null

function picomstart
    killall picom
    picom &>/tmp/log/picom.txt & disown
end
funcsave picomstart >/dev/null

function ollamastart
    killall ollama
    ollama serve &>/tmp/log/ollama.txt & disown
end
funcsave ollamastart >/dev/null

function rename
    mv $argv[1] _$argv[1]
    mv _$argv[1] $argv[2]
end
funcsave rename >/dev/null

function imgs
    xclip -selection clipboard -o >$argv[1].png
end
funcsave imgs >/dev/null

function install_yt_video
    if set -q argv[1]
        set extra $argv[1]
    else
        set extra youtube/
    end
    alacritty -T link-download -e yt-dlp -o '/home/axlefublr/Videos/content/'$extra'%(channel)s — %(title)s.%(ext)s' (xclip -selection clipboard -o)
end
funcsave install_yt_video >/dev/null
