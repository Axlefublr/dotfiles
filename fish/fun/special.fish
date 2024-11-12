#!/usr/bin/env fish

function pick-sts-boss
    set input (
        begin
            echo NoAwakenedOne
            echo NoDonuDeca
            echo NoTimeEater
            echo YesAwakenedOne
            echo YesDonuDeca
            echo YesTimeEater
        end | rofi -dmenu 2> /dev/null ; echo $status
    )
    if test $input[-1] -ne 0
        return 1
    end
    set -e input[-1]
    cp -f ~/prog/binaries/DefinitelyNot/$input.jar ~/.local/share/Steam/steamapps/common/SlayTheSpire/mods/DefinitelyNot.jar
end
funcsave pick-sts-boss >/dev/null

function multiple_dot
    echo z (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
funcsave multiple_dot >/dev/null

function github_read_notifs
    # -H 'X-GitHub-Api-Version: 2022-11-28' \
    gh api \
        --method PUT \
        -H 'Accept: application/vnd.github+json' \
        /notifications \
        -F 'read=true'
end
funcsave github_read_notifs >/dev/null

function alphabet
    printf 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789[];\',./{}:"<>?'
end
funcsave alphabet >/dev/null

function lazyfloat -a harp
    set -l cwd (harp get harp_dirs $harp --path)
    scratchpad --wintitle=max --cwd=$cwd lazygit
end
funcsave lazyfloat >/dev/null

function index_clipboard -a index
    notify-send -t 2000 "$(copyq read $index | pee 'xclip -sel clip -r' 'head -c 100')"
end
funcsave index_clipboard >/dev/null

function anki_update
    if test (anki-due) -gt 0
        if not test "$argv"
            clorange anki increment >/dev/null
        end
        if test (clorange anki show) -ge 6
            echo due
        end
    else
        clorange anki reset >/dev/null
    end
end
funcsave anki_update >/dev/null

function anki-due
    ankuery is:due is:learn
end
funcsave anki-due >/dev/null

function anki-once
    ankuery 'deck:Once is:new'
end
funcsave anki-once >/dev/null

function anki-should
    anki_should (anki-once)
end
funcsave anki-should >/dev/null

function anki_should -a onces
    math "round(log2($onces) x 2) - 2"
end
funcsave anki_should >/dev/null

function anki-should-test
    for num in (seq 10 10 200)
        echo -n $num' '
        set -l shoulds (anki_should $num)
        echo -n "$shoulds "
        math "round $num / $shoulds"
    end
end
funcsave anki-should-test >/dev/null

function anki-ram
    ankuery "$(cat ~/.local/share/magazine/G)"
end
funcsave anki-ram >/dev/null

function anki-sync
    curl localhost:8765 -X POST -d '{ "action": "sync", "version": 6 }'
end
funcsave anki-sync >/dev/null

function anki-add-card
    neoline_hold ~/bs/anki_card.html
    set -l fields (cat ~/bs/anki_card.html)
    test (count $fields) -le 2 && return 1
    begin
        test (count $fields) -eq 3 && set fields $fields '' '' ''
        test (count $fields) -eq 4 && set fields $fields '' ''
        test (count $fields) -eq 5 && set fields $fields ''
        indeed -n ~/.local/share/magazine/A "$(string join ';' $fields)"
        _magazine_commit ~/.local/share/magazine/A card
    end
    head -n 2 ~/bs/anki_card.html | sponge ~/bs/anki_card.html
end
funcsave anki-add-card >/dev/null

function anki-import
    curl localhost:8765 -X POST -d '{ "action": "guiImportFile", "version": 6, "params": { "path": "/home/axlefublr/.local/share/magazine/A.txt" } }'
end
funcsave anki-import >/dev/null

function anki-deck -a deck
    curl localhost:8765 -X POST -d '{
        "action": "guiDeckOverview",
        "version": 6,
        "params": {
            "name": "'$deck'"
        }
    }'
end
funcsave anki-deck >/dev/null

function set_tab_title
    read -P 'title: ' new_title
    if not test "$new_title"
        kitten @ set-tab-title ""
        return
    end
    kitten @ set-tab-title " $new_title"
end
funcsave set_tab_title >/dev/null

function smdn
    set -l name $argv[1]

    set -l executable /home/axlefublr/prog/dotfiles/scripts/systemd/executables/$name.fish
    printf '#!/usr/bin/env fish' >$executable
    chmod +x $executable
    code $executable

    set -l service ~/prog/dotfiles/scripts/systemd/services/$name.service
    printf "[Service]
    ExecStartPre=/home/axlefublr/prog/dotfiles/scripts/processwait.fish
    ExecStart=$executable" >$service

    set -l timer ~/prog/dotfiles/scripts/systemd/timers/$name.timer
    printf '[Timer]
    OnCalendar=*-*-8 05:00:00
    Persistent=true

    [Install]
    WantedBy=timers.target' >$timer
    code $timer

    printf "

    systemctl --user enable --now $name.timer" >>~/prog/dotfiles/scripts/systemd/definition.fish
end
funcsave smdn >/dev/null

function smdr
    set -l name $argv[1]
    rm -fr ~/prog/dotfiles/scripts/systemd/{services,timers,executables}/$name.*
    sd "

    systemctl --user enable --now $name.timer" '' ~/prog/dotfiles/scripts/systemd/definition.fish
end
funcsave smdr >/dev/null

function fn-clear
    set list (cat ~/prog/dotfiles/fish/fun/**.fish | string match -gr '^(?:funcsave|alias --save) (\S+)')
    for file in ~/.config/fish/functions/*.fish
        set function_name (basename $file '.fish')
        if not contains $function_name $list
            rm $file
            echo 'cleared: '$function_name
        end
    end
end
funcsave fn-clear >/dev/null

function special_anki_edit_action
    set -l clip "$(ypoc)"
    string match -gr '^<c>(?<tag>.*?)</c>\\s*(?<else>.*)' $clip
    echo "$else" | copy
end
funcsave special_anki_edit_action >/dev/null
