#!/usr/bin/env fish

function autocommit
    if not git status --porcelain
        return
    end
    set -l new_files
    set -l deleted_files
    set -l modified_files
    set -l renamed_from
    set -l renamed_to
    git add .
    for change in (git status --porcelain)
        set -l bits (string split -n ' ' $change)
        set type $bits[1]
        set path "$(echo $bits[2..])"
        if test $type = A
            set new_files $new_files (string trim -c '"' $path)
        else if test $type = D
            set deleted_files $deleted_files (string trim -c '"' $path)
        else if test $type = M
            set modified_files $modified_files (string trim -c '"' $path)
        else if test $type = R
            set two_paths (string split ' -> ' -- $path)
            set renamed_from $renamed_from (string trim -c '"' $two_paths[1])
            set renamed_to $renamed_to (string trim -c '"' $two_paths[2])
        end
    end
    git restore --staged .
    for deletion in $deleted_files
        git add $deletion
        and git commit -m "remove $deletion"
    end
    for addition in $new_files
        git add $addition
        and git commit -m "add $addition"
    end
    for modification in $modified_files
        git add $modification
        and git commit -m "change $modification"
    end
    for index in (seq (count $renamed_from))
        git add $renamed_from[$index] $renamed_to[$index]
        and git commit -m "move $renamed_from[$index] -> $renamed_to[$index]"
    end
end
funcsave autocommit >/dev/null

function alarm
    if status is-interactive
        _alarm "$argv"
    else
        footclient -T timer fish -c "_alarm $(string escape $argv)"
    end
end
funcsave alarm >/dev/null

function _alarm
    set -l input $argv[1]
    set -l first (string sub -l 1 $input)
    if test $first != 0 && test $first != 1 && test $first != 2
        set input '0'$input
    end
    set -l input (string pad -r -c 0 -w 6 $input)
    echo "set time: $input"
    echo "current:  $(date +%H%M%S)"
    if test $input -lt (date +%H%M%S)
        echo 'input lower than current, reversing'
        while test $input -lt (date +%H%M%S)
            sleep 0.1
        end
        echo 'finished reversing'
    end
    while test $input -gt (date +%H%M%S)
        sleep 0.1
    end
    if status is-interactive
        bell
    else
        notify-send -t 0 "alarm set for $argv[1] is ringing!"
    end
end
funcsave _alarm >/dev/null

function down
    if status is-interactive
        _down $argv
    else
        footclient -T timer fish -c "_down $(string escape $argv)" 2>/dev/null
    end
end
funcsave down >/dev/null

function _down
    termdown $argv
    if not status is-interactive
        and test "$argv" # termdown with no arguments counts up, which can only exit if I specifically close it myself
        notify-send -t 0 "timer for $argv is up!"
    end
end
funcsave _down >/dev/null

function internet_search
    set -l input (
        for line in (cat ~/.local/share/magazine/B)
            echo (string split ' ' $line)[1]!
        end | fuzzel -d --cache ~/.cache/mine/engined-search 2>/dev/null
    )
    test $status -ne 0 && return 1

    string match -gr '^(?:(?<engine>.*)! )?(?<only_search>.*)' -- $input
    not test "$engine" && set engine google
    set clean_input (string escape --style=url $only_search)

    cat ~/.local/share/magazine/B | string match -gr "^$engine (?<engine_url>.*)"

    $BROWSER (string replace %% $clean_input $engine_url)
    ensure_browser
end
funcsave internet_search >/dev/null

function filter_mature_tasks
    function if_print
        test "$argv[1]" -ge $argv[3] && echo "$argv[2] — $(math $argv[1] - $argv[3])" || printf ''
    end
    set oldest (loago list -e razor -e rilter -e eat -e wick -e coils | awk '$3 > 4')
    for task in $oldest
        set -l match (string match -gr '^(\\S+)\\s+— (\\d+)$' $task)
        set -l name $match[1]
        set -l days $match[2]
        switch $name
            case towels nose vacuum floor dust fate
                if_print $days $name 7
            case brushes glasses
                if_print $days $name 10
            case nails
                if_print $days $name 14
            case wilter bottle photos audio disc liked
                if_print $days $name 15
            case tails keyboard
                if_print $days $name 30
            case filter
                if_print $days $name 45
            case fsrs iso
                if_print $days $name 60
            case toothbrush
                if_print $days $name 90
            case '*'
                echo "$name — $(math $days - 5)"
        end
    end | sort -g -k 3 -r | column -t -s '—' -o '—'
end
funcsave filter_mature_tasks >/dev/null

function git_search
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
funcsave git_search >/dev/null

function git_search_file
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
funcsave git_search_file >/dev/null

function mature_tasks_line
    filter_mature_tasks | awk '{print $1}' | string join ' '
end
funcsave mature_tasks_line >/dev/null

function pacclean --description 'clean pacman and paru cache' # based on https://gist.github.com/ericmurphyxyz/37baa4c9da9d3b057a522f20a9ad6eba (cool youtuber btw)
    set aur_cache_dir "$HOME/.cache/paru/clone"
    function aur_cache_dirs_fmt
        fd . $HOME/.cache/paru/clone -d 1 -t d | awk '{ print "-c" $1 }'
    end
    set uninstalled_target (aur_cache_dirs_fmt)
    echo $uninstalled_target[1]
    paccache -ruvk0 $uninstalled_target
    set installed_target (aur_cache_dirs_fmt) # we do this twice because uninstalled package directories got removed
    paccache -qruk0
    paccache -qrk0 -c /var/cache/pacman/pkg $installed_target
end
funcsave pacclean >/dev/null

function timer
    if status is-interactive
        _timer "$argv"
    else
        footclient -T timer fish -c "_timer $(string escape $argv)" 2>/dev/null
    end
end
funcsave timer >/dev/null

function _timer
    while true
        termdown $argv || break
        read -p rdp -ln 1 response
        if not test $response
            break
        end
        if test $response = ' '
            clx
            continue
        else if test $response = e
            exit
        else
            break
        end
    end
    clx
end
funcsave _timer >/dev/null

function yeared_parse
    for line in (cat ~/.local/share/magazine/v)
        set -l match (string match -gr '(\\d+).(\\d+.\\d+) — (.*)' $line)
        set -l year $match[1]
        set -l date $match[2]
        set -l description $match[3]
        if not test $date = (date +%m.%d)
            continue
        end
        set year (math (date +%y) - $year)
        task "$year years ago: $description"
    end
end
funcsave yeared_parse >/dev/null
