#!/usr/bin/env fish

function _kb_execute_via_pueue
    set -l cmd (commandline)
    history append -- $cmd
    pueue add -- $cmd
    commandline ''
    commandline -f repaint
end
funcsave _kb_execute_via_pueue >/dev/null

function _kb_blammo_pwd
    commandline -i (pwd_compressed)
end
funcsave _kb_blammo_pwd >/dev/null

function _kb_reexec
    history search -n 1 | source
end
funcsave _kb_reexec >/dev/null

function _kb_follow_by
    set -l cmd "$(commandline)"
    if not test "$(string trim $cmd)"
        $argv
        return
    end
    history append -- $cmd
    commandline " $cmd && $argv"
    commandline -f execute
end
funcsave _kb_follow_by >/dev/null

function _kb_follow_by_lazygit
    set -l cmd "$(commandline)"
    if not test "$(string trim $cmd)"
        commandline lazygit
        commandline -f execute
        return
    end
    history append -- $cmd
    commandline " $cmd && lazygit"
    commandline -f execute
end
funcsave _kb_follow_by_lazygit >/dev/null

function _kb_and_exit
    set -l cmd "$(commandline)"
    not test "$(string trim $cmd)" && return
    history append -- $cmd
    commandline " $cmd"\n'and exit'
    commandline -f execute
end
funcsave _kb_and_exit >/dev/null

function fish_user_key_bindings
    # [[sort on]]
    bind / expand-abbr self-insert
    bind alt-d _kb_blammo_pwd
    bind alt-enter expand-abbr insert-line-under
    bind ctrl-e _kb_reexec
    bind ctrl-i edit_command_buffer
    bind ctrl-l clear-screen
    bind ctrl-o _kb_and_exit
    bind ctrl-s repaint
    bind ctrl-space 'commandline -i " "'
    bind ctrl-z fg
    bind f1 '_kb_follow_by nu ; commandline -f repaint'
    bind f2 _kb_follow_by_lazygit
    bind f3 'z (cat ~/.cache/mine/blammo | path dirname) ; commandline -f repaint'
    bind f4 '_kb_follow_by helix .'
    bind f5 '_kb_follow_by helix'
    bind f6 '_kb_follow_by yazi'
    # [[sort off]]
end
funcsave fish_user_key_bindings >/dev/null
