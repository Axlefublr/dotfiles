#!/usr/bin/env fish

function engined_search
    set -l input (
        for line in (cat ~/.local/share/magazine/B)
            echo -(string split ' ' $line)[1]-
        end | rofi -dmenu 2>/dev/null
    )
    test $status -ne 0 && return 1

    string match -gr '^(?:-(?<engine>.*)- )?(?<only_search>.*)' -- $input
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

function uboot
    for package in (cat ~/.local/share/magazine/C)
        cat ~/prog/info/pswds/sudo | sudo -S pacman -Rns --noconfirm $package
    end
    truncate -s 0 ~/.local/share/magazine/C
    if test (math (clorange updates increment) % 7) -eq 0
        rustup update
        cargo install-update -a
    end
    cat ~/prog/info/pswds/sudo | sudo -Sv
    yes | sudo pacman -Syyu
    pacclean
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
    paccache -qruk0
    paccache -qrk0 -c /var/cache/pacman/pkg $installed_target
end
funcsave pacclean >/dev/null
