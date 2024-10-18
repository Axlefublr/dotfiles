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
    if set -q argv[1]
        set extra $argv[1]
    else
        set extra youtube
    end
    set file (mktemp /dev/shm/install_yt_video.XXXXXX)
    set clipboard (xclip -selection clipboard -o)
    kitty -T link-download yt-dlp \
        -o "~/vid/content/$extra/%(channel)s — %(title)s — ;%(id)s;.%(ext)s" \
        --print-to-file "%(channel)s — %(title)s" $file \
        $clipboard
    notify-send -t 3000 "downloaded: $(cat $file)"
    rm -fr $file
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
