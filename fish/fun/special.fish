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

function github-read-notifs
    # -H 'X-GitHub-Api-Version: 2022-11-28' \
    gh api \
        --method PUT \
        -H 'Accept: application/vnd.github+json' \
        /notifications \
        -F 'read=true'
end
funcsave github-read-notifs >/dev/null

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
            and not string match -qr '^_?fifc' $function_name
            rm $file
            echo 'cleared: '$function_name
        end
    end
end
funcsave fn-clear >/dev/null

function special_anki_edit_action
    ypoc | string lower | sponge | copy
end
funcsave special_anki_edit_action >/dev/null

function random-fav-emoji
    while not set -q emoji || contains $emoji ~/bs/fav-emoji-history
        set -f emoji (shuf -n 1 ~/.local/share/magazine/e | string split ' ')[1]
    end
    echo $emoji
    indeed -nu ~/bs/fav-emoji-history $emoji
    tail -n 30 ~/bs/fav-emoji-history | sponge ~/bs/fav-emoji-history
end
funcsave random-fav-emoji >/dev/null

function randomize-file-names
    for file in $argv
        mv $file (uclanr 3 -j '-')(path extension $file)
    end
end
funcsave randomize-file-names >/dev/null

function calculate-eof-position -a file
    set -l last_line (wc -l $file | string split ' ')[1]
    echo -n :$last_line:
    set -l last_column (zat -s $last_line -e $last_line $file | wc -c | string split ' ')[1]
    echo -n $last_column
end
funcsave calculate-eof-position >/dev/null

function pick-and-copy-color
    set -l picked_color (xcolor)
    notify-send -t 3000 "$picked_color"
    echo $picked_color | copy
end
funcsave pick-and-copy-color >/dev/null
