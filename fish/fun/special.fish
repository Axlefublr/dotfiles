#!/usr/bin/env fish

function edit_repo_root_or_cwd
    helix -w (git rev-parse --show-toplevel || echo $PWD) .
end
funcsave edit_repo_root_or_cwd >/dev/null

function pick_sts_boss
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
funcsave pick_sts_boss >/dev/null

function install_yt_video
    set extra (begin
        echo youtube
        echo longform
        echo asmr
    end | rofi -dmenu -no-custom 2>/dev/null)
    test $status -ne 0 && return 1
    switch $extra
        case youtube
            set -f where_links ~/.local/share/magazine/k
        case longform
            set -f where_links ~/.local/share/magazine/K
        case asmr
            set -f where_links ~/.local/share/magazine/i
    end
    if not test -s $where_links
        or test "$(cat $where_links)" = '\n'
        notify-send -t 2000 'no stored links'
        return 1
    end
    set -l how_many (clorange youtube show)
    set -l stored_links (count (cat $where_links))
    set -l links_to_install (head -n $how_many $where_links)
    tail -n "+$(math $how_many + 1)" $where_links | sponge $where_links
    if test $stored_links -lt $how_many
        notify-send -t 3000 "asked for $how_many, only has $stored_links"
    else if test $stored_links -eq $how_many
        notify-send -t 3000 "asked for $how_many, which is exact stored"
    else
        notify-send -t 3000 "$(math $stored_links - $how_many) links left"
    end
    for link in $links_to_install
        install-yt-video.fish $extra $link &
    end
    _magazine_commit $where_links install
end
funcsave install_yt_video >/dev/null

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
