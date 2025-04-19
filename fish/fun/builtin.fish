#!/usr/bin/env fish

function fish_greeting
end
funcsave fish_greeting >/dev/null

function fish_title
end
funcsave fish_title >/dev/null

function fish_command_not_found
    echo "sorry, but the `$argv[1]` command doesn't exist"
end
funcsave fish_command_not_found >/dev/null

function __fish_list_current_token -d "List contents of token under the cursor if it is a directory, otherwise list the contents of the current directory"
    set -l val "$(commandline -t | string replace -r '^~' "$HOME")"
    set -l cmd
    if test -d $val
        set cmd eza -a $val
    else
        set -l dir (dirname -- $val)
        if test $dir != . -a -d $dir
            set cmd eza -a $dir
        else
            set cmd eza -a
        end
    end
    __fish_echo $cmd
end
funcsave __fish_list_current_token >/dev/null
