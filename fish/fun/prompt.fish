#!/usr/bin/env fish

function fish_prompt_pwd
    set -l git_repo_full (git rev-parse --show-toplevel 2> /dev/null)
    set -l home (string escape --style=regex $HOME)
    if test "$git_repo_full"
        set -l above_repo (path dirname $git_repo_full)
        set -l repo_segment (path basename $git_repo_full)
        set -l rest_pwd (string replace $git_repo_full '' $PWD)
        echo -n "$(string replace -r "^$home" '~' $above_repo/)"
        set_color -o ffd75f
        echo -n $repo_segment
        set_color -o ffafd7
        echo -n $rest_pwd
    else
        set -l cwd (string replace -r "^$home" '~' $PWD)
        echo -n $cwd
    end
end
funcsave fish_prompt_pwd >/dev/null

function fish_prompt_status
    set -l countstatus (count $argv)
    if test $countstatus -gt 1
        set -l are_all_success true
        for i in (seq $countstatus)
            if test $argv[$i] -ne 0
                set are_all_success false
                break
            end
        end
        if test $are_all_success = false
            for i in (seq $countstatus)
                if test $i -gt 1
                    printf ' '
                end
                if test $argv[$i] -ne 0
                    set_color -o ff2930
                    printf '󱎘'
                else
                    set_color -o 87ff5f
                    printf ''
                end
                printf $argv[$i]
            end
            printf ' '
        end
    else
        if test $argv -ne 0
            set_color -o ff2930
            printf '󱎘%s ' $argv
        end
    end
end
funcsave fish_prompt_status >/dev/null

function fish_prompt
    set -l fullstatuses $pipestatus
    set_color ffd75f
    if set -q fish_private_mode
        printf '󰗹 '
    end
    if test (count (jobs)) -gt 0
        printf ' '
    end
    if not test -w .
        printf ' '
    end
    set_color ff9f1a
    if test $USER != axlefublr
        echo -n ' '$USER
    end
    if set -q SSH_TTY
        set_color -o ffd75f
        echo -n '@'
        set_color normal
        set_color ff9f1a
        echo -n $hostname
    end
    set_color -o ffafd7
    fish_prompt_pwd
    set_color normal
    if test $COLUMNS -ge $small_threshold
        printf ' '
    else
        printf '\n'
    end
    if git rev-parse --is-inside-work-tree &>/dev/null
        set -l curr_branch (git branch --show-current 2> /dev/null)
        set_color -o af87ff
        if test $curr_branch
            echo -n ''$curr_branch' '
        else
            set -l curr_commit (git rev-parse --short HEAD 2> /dev/null)
            echo -n ''$curr_commit' '
        end
        set_color normal
        command -q octogit && octogit-set
        if test $COLUMNS -lt $small_threshold
            printf '\n'
        end
    end
    fish_prompt_status $fullstatuses
    set_color ffd75f
    printf '󱕅 '
    set_color normal
end
funcsave fish_prompt >/dev/null

function fish_mode_prompt
end
funcsave fish_mode_prompt >/dev/null
