#!/usr/bin/env fish

function execute_somehow -d 'expects cwd, then full path to the buffer as args'
    if not test "$argv[2]"
        return
    end
    set -l extension (path extension $argv[2] | cut -c 2-)
    set -l base (path basename $argv[2])
    if test $base = xremap.yml
        xrestart.fish
    else if test $argv[1] = ~/prog/forks/helix
        win --hold ./build.fish
    else if test $extension = rs -o $base = Cargo.toml
        over --hold cargo run
    else if test $extension = py
        python $argv[2]
    else if test $extension = fish
        fish $argv[2]
    end
end
funcsave execute_somehow >/dev/null

function diag_somehow -d 'expects cwd, then full path to the buffer as args'
    if not test "$argv[2]"
        return
    end
    set -l base (path basename $argv[2])
    set -l extension (path extension $argv[2] | cut -c 2-)
    if test $extension = rs -o $base = 'Cargo.toml'
        over --hold cargo clippy
    end
end
funcsave diag_somehow >/dev/null

function engined_search
    set -l engine $argv[1]
    if not test "$argv[1]"
        set engine (
            begin
                echo google
                echo github
                echo yandex
                echo python
                echo emoji
                echo icons8
                echo phind
                echo slay the spire
                echo kitty
                echo fish
                echo krita
                echo iask
                echo rust
                echo anki
                echo mdn
            end | rofi -no-custom -dmenu 2>/dev/null
        )
        test $status -ne 0 && return 1
    end

    set input (rofi -dmenu 2>/dev/null)
    test $status -ne 0 && return 1
    set input (string escape --style=url $input)

    switch $engine # I ignore output so that I don't see "Opening in existing browser session." in my runner ouput every time I search for something
        case yandex
            $BROWSER "https://yandex.com/search?text=$input" >/dev/null
        case phind
            $BROWSER "https://www.phind.com/search?q=$input" >/dev/null
        case github
            $BROWSER "https://github.com/search?q=$input" >/dev/null
        case python
            $BROWSER "https://docs.python.org/3/search.html?q=$input" >/dev/null
        case 'slay the spire'
            $BROWSER "https://slay-the-spire.fandom.com/wiki/Special:Search?query=$input&scope=internal&navigationSearch=true" >/dev/null
        case emoji
            $BROWSER "https://emojipedia.org/search?q=$input" >/dev/null
        case icons8
            $BROWSER "https://icons8.ru/icons/set/$input" >/dev/null
        case google
            $BROWSER "https://www.google.com/search?q=$input&sourceid=chrome&ie=UTF-8" >/dev/null
        case kitty
            $BROWSER "https://sw.kovidgoyal.net/kitty/search/?q=$input&check_keywords=yes&area=default" >/dev/null
        case fish
            $BROWSER "https://fishshell.com/docs/current/search.html?q=$input" >/dev/null
        case krita
            $BROWSER "https://docs.krita.org/en/search.html?q=$input&check_keywords=yes&area=default" >/dev/null
        case iask
            $BROWSER "https://iask.ai/?mode=question&q=$input" >/dev/null
        case rust
            $BROWSER "https://doc.rust-lang.org/std/?search=$input" >/dev/null
        case anki
            $BROWSER "https://docs.ankiweb.net/?search=$input" >/dev/null
        case mdn
            $BROWSER "https://developer.mozilla.org/en-US/search?q=$input" >/dev/null
    end
    ensure_browser
end
funcsave engined_search >/dev/null

function git-search-file
    if not test "$argv[1]"
        echo 'the first argument should be the filepath where you want to search for a string' >&2
    end
    if not test "$argv[2]"
        echo 'the second argument and beyond are expected argument(s) to `rg`' >&2
        return 1
    end
    set commits (git log --format=format:"%h" -- $argv[1])
    for commit in $commits
        truncate -s 0 /dev/shm/git_search
        git show $commit:$argv[1] 2>/dev/null | rg --color=always $argv[2..] >>/dev/shm/git_search
        and git show --color=always --oneline $commit -- $argv[1] >>/dev/shm/git_search
        if test -s /dev/shm/git_search
            cat /dev/shm/git_search | diff-so-fancy | less
            read -P 'press any key to continue, `q` to quit: ' -ln 1 continue
            if test "$continue" = q
                break
            end
        end
    end
end
funcsave git-search-file >/dev/null

function git-search
    if not test "$argv[1]"
        echo 'missing arguments for `rg`' >&2
        return 1
    end
    set commits (git log --format=format:"%h")
    for commit in $commits
        truncate -s 0 /dev/shm/git_search
        set files (git show --format=format:'' --name-only $commit)
        set -l matched_files
        for file in $files
            git show $commit:$file 2>/dev/null | rg --color=always $argv >>/dev/shm/git_search
            and set matched_files $matched_files $file
            and echo (set_color '#e491b2')$file(set_color normal) >>/dev/shm/git_search
        end
        if test "$matched_files"
            git show --color=always --oneline $commit -- $matched_files >>/dev/shm/git_search
        end
        if test -s /dev/shm/git_search
            cat /dev/shm/git_search | diff-so-fancy | less
            read -P 'press any key to continue, `q` to quit: ' -ln 1 continue
            if test "$continue" = q
                break
            end
        end
    end
end
funcsave git-search >/dev/null

function uboot
    sudo -v
    for package in (cat ~/.local/share/magazine/C)
        paru -Rns --noconfirm $package
    end
    truncate -s 0 ~/.local/share/magazine/C
    clorange docs increment
    set -l doc_dirs (eza -aD ~/docs)
    set -l count_doc_dirs (count $doc_dirs)
    set -l current_doc_dir (math "$(clorange doc_dirs increment) % $count_doc_dirs + 1")
    kitten @ launch --type os-window --os-window-title link-download --cwd ~/docs/$doc_dirs[$current_doc_dir] httrack --update
    sudo -v
    if test (math (clorange updates show) % 5) -eq 0
        rustup update
    end
    sudo -v
    if test (math (clorange updates show) % 3) -eq 0
        cargo install-update -a
    end
    sudo -v
    paru
    pacclean
    clorange updates increment
    loago do update
    notify-send 'finished updating, what to do now?'
    read -p rdp -ln 1 response
    if test $response = r
        reboot
    else if test $response = l
        logout
    else if test $response = s
        poweroff
    end
end
funcsave uboot >/dev/null

function pacclean --description 'clean pacman and paru cache' # based on https://gist.github.com/ericmurphyxyz/37baa4c9da9d3b057a522f20a9ad6eba (cool youtuber btw)
    set aur_cache_dir "$HOME/.cache/paru/clone"
    function aur_cache_dirs_fmt
        fd . $HOME/.cache/paru/clone -d 1 -t d | awk '{ print "-c" $1 }'
    end
    set uninstalled_target (aur_cache_dirs_fmt)
    echo $uninstalled_target[1]
    paccache -ruvk0 $uninstalled_target
    set installed_target (aur_cache_dirs_fmt) # we do this twice because uninstalled package directories got removed
    paccache -qruk1
    paccache -qrk2 -c /var/cache/pacman/pkg $installed_target
end
funcsave pacclean >/dev/null

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
