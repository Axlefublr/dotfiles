#!/usr/bin/env fish

alias --save fd 'fd --no-require-git' >/dev/null
alias --save rg 'rg --engine auto' >/dev/null
alias --save less 'less --use-color -R' >/dev/null
alias --save termdown 'termdown -W -f roman' >/dev/null
alias --save tree 'tree --noreport --dirsfirst --matchdirs --gitignore -Ca -I .git -I bin -I obj -I target -I .vscode' >/dev/null
alias --save bell 'printf \a' >/dev/null
alias --save toco 'touch $argv && code $argv' >/dev/null
alias --save octogit-set "octogit --color-all-commits ffd75f \
	--color-all-staged 87ff5f \
	--color-all-unstaged 00d7ff" >/dev/null
alias --save etg 'shuf -n 1 ~/prog/noties/etg-actives.txt' >/dev/null
alias --save icat 'kitten icat --align left' >/dev/null
alias --save woman man >/dev/null # lol and even lmao
alias --save tgpt 'tgpt -q' >/dev/null
alias --save yt-dlp 'yt-dlp $argv ; bell' >/dev/null
alias --save scrot 'scrot -i -l color=#ffafd7,mode=edge,width=2' >/dev/null
alias --save suspend 'systemctl suspend' >/dev/null
alias --save screenkey 'screenkey --no-systray --position top --font-size small --key-mode translated --bak-mode full --mods-mod normal --font "JetBrainsMonoNL Nerd Font" --font-color "#d4be98" --bg-color "#1a1919" --opacity 0.7 --compr-cnt 3 --mouse -g 500x1080+1420-15' >/dev/null
alias --save rofi_multi_select 'rofi -dmenu -multi-select -ballot-selected-str " " -ballot-unselected-str "  "' >/dev/null
alias --save awart 'awesome-client "awesome.restart()"' >/dev/null
alias --save gromit 'gromit-mpx -o 1 -k "none" -u "none"' >/dev/null
alias --save dust 'dust -r' >/dev/null
alias --save neomax 'kitty -T neomax nvim' >/dev/null
alias --save neoline 'kitty -T neoline nvim' >/dev/null
alias --save eza 'eza --icons=auto --group-directories-first -x --time-style "+%y.%m.%d %H:%M" --smart-group' >/dev/null
alias --save ez 'eza --git --git-repos' >/dev/null
alias --save pipes 'pipes -p 3 -c 1 -c 2 -c 3 -c 4 -c 5 -R' >/dev/null

function clx
    if test "$TERM" != xterm-kitty
        clear -x
    else
        printf '\e[H\e[22J'
    end
end
funcsave clx >/dev/null

function pacstall
    for each in $argv
        set items $items "sudo pacman -S --noconfirm $each"
    end
    indeed -u ~/prog/dotfiles/scripts/setup/install.sh $items
    notify-send -t 3000 "$(tail -n (count $argv) ~/prog/dotfiles/scripts/setup/install.sh)"
end
funcsave pacstall >/dev/null

function aurall
    for each in $argv
        set items $items "paru --noconfirm -aS $each"
    end
    indeed -u ~/prog/dotfiles/scripts/setup/aur.sh $items
    notify-send -t 3000 "$(tail -n (count $argv) ~/prog/dotfiles/scripts/setup/aur.sh)"
end
funcsave aurall >/dev/null

function eat
    loago do eat
    notify-send -t 2000 'ate!'
    awesome-client 'Hunger_wu()'
end
funcsave eat >/dev/null

function task
    indeed ~/.local/share/magazine/3 $argv
    update_magazine 3
end
funcsave task >/dev/null

function rdp
    set_color '#ffd75f'
    printf '󱕅 '
    set_color normal
end
funcsave rdp >/dev/null

function rlc
    realpath $argv | xclip -r -selection clipboard
end
funcsave rlc >/dev/null

function mkcd
    mkdir -p $argv && z $argv && clx
end
funcsave mkcd >/dev/null

function ghrclc
    gh repo clone $argv -- --depth 1
    z (path basename $argv[1])
    clx
end
funcsave ghrclc >/dev/null

function ghrfc
    gh repo fork $argv --clone --default-branch-only -- --depth 1
    z (path basename $argv[1])
    clx
end
funcsave ghrfc >/dev/null

function xrestart
    killall xremap
    xremap --mouse ~/prog/dotfiles/xremap.yml &>/tmp/log/xremap.txt & disown
end
funcsave xrestart >/dev/null

function xwaaa
    xset r rate 170 35 &>/tmp/log/xset.txt
    setxkbmap -layout us,ru -option 'compose:sclk' &>/tmp/log/setxkbmap.txt
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
    gromit.fish &>/tmp/log/gromit.txt & disown
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

function q
    $argv --help | nvim -c +Man!
end
funcsave q >/dev/null

function ocr
    tesseract $argv - 2>/dev/null
end
funcsave ocr >/dev/null
