#!/usr/bin/env fish

function engined_search
    set -l input (
        for line in (cat ~/.local/share/magazine/B)
            echo (string split ' ' $line)[1]!
        end | fuzzel -d 2>/dev/null
    )
    test $status -ne 0 && return 1

    string match -gr '^(?:(?<engine>.*)! )?(?<only_search>.*)' -- $input
    not test "$engine" && set engine google
    set clean_input (string escape --style=url $only_search)

    cat ~/.local/share/magazine/B | string match -gr "^$engine (?<engine_url>.*)"

    $BROWSER (string replace %% $clean_input $engine_url)
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
            case filter
                if_print $days $name 60
            case towels nose wash vacuum floor dust
                if_print $days $name 7
            case cloths brushes glasses
                if_print $days $name 10
            case nails
                if_print $days $name 14
            case wilter bottle photos audio disc liked
                if_print $days $name 15
            case tails iso keyboard fsrs
                if_print $days $name 30
            case toothbrush
                if_print $days $name 90
            case '*'
                echo "$name — $(math $days - 5)"
        end
    end | sort -g -k 3 -r | column -t -s '—' -o '—'
end
funcsave filter_mature_tasks >/dev/null

function mature_tasks_line
    filter_mature_tasks | awk '{print $1}' | string join ' '
end
funcsave mature_tasks_line >/dev/null
