#!/usr/bin/env fish

#------------------------------------------------------------------------------------------------------------
#          for special logic and "functionality", often app-specific or in other ways hyperspecific          
#------------------------------------------------------------------------------------------------------------

#----------------------------------------------------anki----------------------------------------------------

function anki_update
    if test (anki-due) -gt 0
        if not test "$argv"
            clorange anki increment
        end
        if test (clorange anki show) -ge 6
            echo due
        end
    else
        clorange anki reset
    end
end
funcsave anki_update >/dev/null

function anki-due
    curl localhost:8765 -X POST -d '{ "action": "findCards", "version": 6, "params": { "query": "is:due" } }' 2>/dev/null | jq .result.[] 2>/dev/null | count
end
funcsave anki-due >/dev/null

function anki-sync
    curl localhost:8765 -X POST -d '{ "action": "sync", "version": 6 }'
end
funcsave anki-sync >/dev/null

#--------------------------------------------------terminal--------------------------------------------------

function set_tab_title
    read -P 'title: ' new_title
    if not test "$new_title"
        kitten @ set-tab-title ""
        return
    end
    kitten @ set-tab-title " $new_title"
end
funcsave set_tab_title >/dev/null

#---------------------------------------------------helix---------------------------------------------------

function execute_somehow -d 'expects cwd, then full path to the buffer as args'
    if not test "$argv[2]"
        return
    end
    set -l extension (path extension $argv[2] | cut -c 2-)
    if test $argv[1] = ~/prog/forks/helix
        win --hold ./build.fish
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
            end | rofi -no-custom -dmenu 2>/dev/null ; echo $status
        )
        test $engine[-1] -eq 1 && return 1 || set -e engine[-1]
    end

    set input (rofi -dmenu 2> /dev/null | string escape --style=url ; echo $status)
    test $input[-1] -eq 1 && return 1
    not test "$input" && return 1

    if test $input[-1] -eq 0
        ensure_browser main
    else if test $input[-1] -eq 10
        ensure_browser content
    end
    set -e input[-1]

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
    end
end
funcsave engined_search >/dev/null

#-----------------------------------------------------git-----------------------------------------------------

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

#-----------------------------------------------------etc-----------------------------------------------------
