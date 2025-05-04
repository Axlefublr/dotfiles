#!/usr/bin/env fish

function _help_the_commandline
    set -f commandline (commandline -o)
    $commandline --help 2>/dev/null &| ov
end
funcsave _help_the_commandline >/dev/null

function _man_the_commandline
    set -f commandline (commandline -o)[1]
    man $commandline 2>/dev/null
end
funcsave _man_the_commandline >/dev/null

function _match_helix_cwd
    read -P 'hElix yAzi buFFer hOme gIt: ' -n1 choice
    if test "$choice" = e
        z (cat /tmp/helix-cwd-suspend)
    else if test "$choice" = a
        z (cat ~/.cache/mine/yazi-cwd-suspend)
    else if test "$choice" = f
        z (cat /tmp/helix-buffer-head-suspend)
    else if test "$choice" = o
        z ~
    else if test "$choice" = i
        gq
    end
    commandline -f repaint
end
funcsave _match_helix_cwd >/dev/null

function _wrap_in_pueue
    set -l cmd "$(commandline)"
    commandline "pueue add -- '$cmd'"
    commandline -C 10
end
funcsave _wrap_in_pueue >/dev/null

function _delete_commandline_or_exit
    if test -n "$(commandline)"
        commandline ''
    else
        exit
    end
end
funcsave _delete_commandline_or_exit >/dev/null

function _fzf_defaults
    # $1: Prepend to FZF_DEFAULT_OPTS_FILE and FZF_DEFAULT_OPTS
    # $2: Append to FZF_DEFAULT_OPTS_FILE and FZF_DEFAULT_OPTS
    test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
    echo "--height $FZF_TMUX_HEIGHT --bind=ctrl-z:ignore" $argv[1]
    test -r "$FZF_DEFAULT_OPTS_FILE"; and string collect -N -- <$FZF_DEFAULT_OPTS_FILE
    echo $FZF_DEFAULT_OPTS $argv[2]
end
funcsave _fzf_defaults >/dev/null

function _fzfcmd
    test -n "$FZF_TMUX"; or set FZF_TMUX 0
    test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
    if test -n "$FZF_TMUX_OPTS"
        echo "fzf-tmux $FZF_TMUX_OPTS -- "
    else if test "$FZF_TMUX" = 1
        echo "fzf-tmux -d$FZF_TMUX_HEIGHT -- "
    else
        echo fzf
    end
end
funcsave _fzfcmd >/dev/null

function _fzf_history -d "Show command history"
    test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
    begin
        set -l FISH_MAJOR (string split '.' -- $version)[1]
        set -l FISH_MINOR (string split '.' -- $version)[2]

        # merge history from other sessions before searching
        test -z "$fish_private_mode"; and builtin history merge

        # history's -z flag is needed for multi-line support.
        # history's -z flag was added in fish 2.4.0, so don't use it for versions
        # before 2.4.0.
        if test "$FISH_MAJOR" -gt 2 -o \( "$FISH_MAJOR" -eq 2 -a "$FISH_MINOR" -ge 4 \)
            set -lx FZF_DEFAULT_OPTS (_fzf_defaults "" "-n2..,.. --scheme=history --bind=ctrl-r:toggle-sort --wrap-sign '"\t"↳ ' --highlight-line $FZF_CTRL_R_OPTS +m")
            set -lx FZF_DEFAULT_OPTS_FILE ''
            if type -q perl
                builtin history -z --reverse | command perl -0 -pe 's/^/$.\t/g; s/\n/\n\t/gm' | eval (_fzfcmd) --tac --read0 --print0 -q '(commandline)' | string replace -r '^\d*\t' '' | read -lz result
                and commandline -- $result
            else
                set -l line 0
                for i in (builtin history -z --reverse | string split0)
                    set line (math $line + 1)
                    string escape -n -- $line\t$i
                end | string join0 | string replace -a '\n' '\n\t' | string unescape -n | eval (_fzfcmd) --tac --read0 --print0 -q '(commandline)' | string replace -r '^\d*\t' '' | read -lz result
                and commandline -- $result
            end
        else
            builtin history | eval (_fzfcmd) -q '(commandline)' | read -l result
            and commandline -- $result
        end
    end
    commandline -f repaint
end
funcsave _fzf_history >/dev/null

function fish_user_key_bindings
    # [[sort on]]
    bind / expand-abbr self-insert
    bind alt-. _man_the_commandline
    bind alt-comma _help_the_commandline
    bind alt-enter expand-abbr insert-line-under
    bind ctrl-\' _wrap_in_pueue
    bind ctrl-d _delete_commandline_or_exit
    bind ctrl-f 'zi && commandline -f repaint'
    bind ctrl-g _match_helix_cwd
    bind ctrl-l '__fish_cursor_xterm line ; commandline -f repaint'
    bind ctrl-z fg
    # [[sort off]]
end
funcsave fish_user_key_bindings >/dev/null
