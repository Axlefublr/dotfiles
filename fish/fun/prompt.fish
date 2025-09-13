#!/usr/bin/env fish

function fish_prompt_pwd
    set -l taken_length "$argv"
    set -l allowed_length (math $COLUMNS - $taken_length)
    # set -l git_repo_full (git rev-parse --show-toplevel 2>/dev/null)
    set -l home_compressed (
        string replace -r "^$HOME" '~' "$PWD" |
        string replace -r "home/$USER" '~'
    )

    set -l pwd_length (string length "$home_compressed")
    if test (math $pwd_length + $taken_length) -ge (math -s 0 -m round $COLUMNS x 0.5)
        set -g _fish_prompt_should_mulitline true
    else
        set -g _fish_prompt_should_mulitline false
    end

    set -l segments (string split -n / "$home_compressed")
    if test $pwd_length -ge $allowed_length
        set -l longest_index 1
        set -l longest_length 0
        for index in (seq 1 (count $segments))
            set -l current_length (string length $segments[$index])
            if test $current_length -gt $longest_length
                set longest_index $index
                set longest_length $current_length
            end
        end
        # now we know what segment is the largest one
        set -l max_segment_length (math "max(1, $allowed_length - ($pwd_length - $longest_length))")
        set segments $segments[1..(math "max 1, $longest_index - 1")] \
            (string shorten -m $max_segment_length $segments[$longest_index]) \
            $segments[(math "max 1, $longest_index + 1")..]
    end

    if test "$segments[1]" != '~' -a "$segments[1]" != /
        echo -n /
    end

    string replace '~' "$(set_color -o ff8787)~$(set_color -o ffafd7)" $segments |
        string join / |
        read
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
    set -l jobsies (jobs)
    set -l jobsies_count (count $jobsies)
    set -l taken_length 0
    set_color -o ffd75f
    if test $jobsies_count -gt 0
        printf ' '
        set taken_length (math $taken_length + 2)
        if test $jobsies_count -gt 1
            set_color -o
            set -l the (printf %s\n $jobsies | cut -f 1 | string join '')
            echo -n $the
            echo -n ' '
            set taken_length (math $taken_length + (string length $the) + 1)
            set_color normal
        end
    end
    set_color ffd75f
    if not test -w .
        printf ' '
        set taken_length (math $taken_length + 2)
    end
    set_color -o ffafd7
    fish_prompt_pwd $taken_length
    set_color normal
    if $_fish_prompt_should_mulitline
        printf '\n'
    else
        printf ' '
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
    # if git rev-parse --is-inside-work-tree &>/dev/null
    #     set -l curr_branch (git branch --show-current 2> /dev/null)
    #     set_color -o af87ff
    #     if test $curr_branch
    #         echo -n ''$curr_branch' '
    #     else
    #         set -l curr_commit (git rev-parse --short HEAD 2> /dev/null)
    #         echo -n ''$curr_commit' '
    #     end
    #     set_color normal
    #     # command -q octogit && octogit-set
    #     if test $COLUMNS -lt $small_threshold
    #         printf '\n'
    #     end
    # end
    fish_prompt_status $fullstatuses
    set_color ffd75f
    printf '󱕅 '
    set_color normal
    __fish_cursor_xterm line
end
funcsave fish_prompt >/dev/null

function fish_mode_prompt
end
funcsave fish_mode_prompt >/dev/null
