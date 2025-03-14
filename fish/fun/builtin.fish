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

function edit_commandline
    set temp '/dev/shm/fish_edit_commandline.fish'
    truncate -s 0 $temp
    commandline >$temp
    helix $temp
    set -l editor_status $status
    if test $editor_status -eq 0
        if test -s $temp # this shouldn't be needed, but strangely is
            commandline -r -- (command cat $temp)
        else
            commandline ''
        end
    end
    commandline -f repaint

    # set cursor_location /dev/shm/fish_edit_commandline_cursor
    # truncate -s 0 $cursor_location || touch $cursor_location

    # set -l offset (commandline --cursor)
    # set -l lines (commandline)\n
    # set -l line 1
    # while test $offset -ge (string length -- $lines[1])
    #     set offset (math $offset - (string length -- $lines[1]))
    #     set line (math $line + 1)
    #     set -e lines[1]
    # end
    # set column (math $offset + 1)

    # nvim -c "call cursor($line, $column)" $temp 2>/dev/null

    # set -l editor_status $status

    # if test $editor_status -eq 0
    #     if test -s $temp # this shouldn't be needed, but strangely is
    #         commandline -r -- (command cat $temp)
    #     else
    #         commandline ''
    #     end
    #     set -l position (cat $cursor_location | string split ' ')
    #     set -l line $position[1]
    #     set -l column $position[2]
    #     commandline -C 0
    #     for _line in (seq $line)[2..]
    #         commandline -f down-line
    #     end
    #     commandline -f beginning-of-line
    #     for _column in (seq $column)[2..]
    #         commandline -f forward-single-char
    #     end
    # end
    # commandline -f repaint
end
funcsave edit_commandline >/dev/null
