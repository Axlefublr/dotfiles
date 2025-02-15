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
        end | fuzzel -d 2>/dev/null
    )
    if test $status -ne 0
        return 1
    end
    cp -f ~/r/binaries/DefinitelyNot/$input.jar ~/.local/share/Steam/steamapps/common/SlayTheSpire/mods/DefinitelyNot.jar
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

    set -l executable /home/axlefublr/r/dot/scripts/systemd/executables/$name.fish
    printf '#!/usr/bin/env fish' >$executable
    chmod +x $executable
    code $executable

    set -l service ~/r/dot/scripts/systemd/services/$name.service
    printf "[Service]
    ExecStartPre=/home/axlefublr/r/dot/scripts/processwait.fish
    ExecStart=$executable" >$service

    set -l timer ~/r/dot/scripts/systemd/timers/$name.timer
    printf '[Timer]
    OnCalendar=*-*-8 05:00:00
    Persistent=true

    [Install]
    WantedBy=timers.target' >$timer
    code $timer

    printf "

    systemctl --user enable --now $name.timer" >>~/r/dot/scripts/systemd/definition.fish
end
funcsave smdn >/dev/null

function smdr
    set -l name $argv[1]
    rm -fr ~/r/dot/scripts/systemd/{services,timers,executables}/$name.*
    sd "

    systemctl --user enable --now $name.timer" '' ~/r/dot/scripts/systemd/definition.fish
end
funcsave smdr >/dev/null

function fn-clear
    set list (cat ~/r/dot/fish/fun/**.fish | string match -gr '^(?:funcsave|alias --save) (\S+)')
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

function toggle-screen-record
    if matches 'Title: "screen-record";App ID: "kitty"' &>/dev/null
        kitten @ --to unix:/home/axlefublr/.cache/mine/screen-recording-kitty-socket signal-child SIGINT
        copyl ~/i/s/compressed.mp4
    else
        kitty -T screen-record --listen-on unix:/home/axlefublr/.cache/mine/screen-recording-kitty-socket screen-record.fish
    end
end
funcsave toggle-screen-record >/dev/null
