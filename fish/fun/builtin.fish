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

function list_current_token -d "List contents of token under the cursor (including dotfiles) if it is a directory, otherwise list the contents of the current directory"
    set -l val (commandline -t | string replace -r '^~' "$HOME")
    echo
    if test -d $val
        ezagit -a $val
    else
        set -l dir (dirname -- $val)
        if test $dir != . -a -d $dir
            ezagit -a $dir
        else
            ezagit -a
        end
    end

    string repeat -N \n --count=(math (count (fish_prompt)) - 1)

    commandline -f repaint
end
funcsave list_current_token >/dev/null
