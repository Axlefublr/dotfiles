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

function _travel_helix_cwd
    z (cat ~/.cache/mine/helix-cwd-suspend | path_expand)
    commandline -f repaint
end
funcsave _travel_helix_cwd >/dev/null

function _travel_yazi_cwd
    z (cat ~/.cache/mine/yazi-cwd-suspend)
    commandline -f repaint
end
funcsave _travel_yazi_cwd >/dev/null

function _travel_buffer_head
    z (cat ~/.cache/mine/helix-buffer-head-suspend | path_expand)
    commandline -f repaint
end
funcsave _travel_buffer_head >/dev/null

function _wrap_in_pueue
    set -l cmd "$(commandline | string escape)"
    commandline "pueue add -- $cmd"
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

function _harp_get
    read -n 1 -P 'harp get: ' -l key || return
    not test "$key" && return
    set -l harp (harp get harp_dirs "$key" | path_expand)
    if test "$harp"
        cd "$harp"
        set -f harp_success $status
    else
        set -f harp_success 1
    end
    if test $harp_success -ne 0
        zi
    end
    commandline -f repaint
end
funcsave _harp_get >/dev/null

function _harp_set
    read -n 1 -P 'harp set: ' -l key || return
    not test "$key" && return
    set -l harp (harp replace harp_dirs "$key" (pwd_pretty))
    commandline -f repaint
end
funcsave _harp_set >/dev/null

function _blammo_pwd
    commandline -i (pwd_pretty)
end
funcsave _blammo_pwd >/dev/null

function fish_user_key_bindings
    # [[sort on]]
    bind / expand-abbr self-insert
    bind alt-. _man_the_commandline
    bind alt-comma _help_the_commandline
    bind alt-d _blammo_pwd
    bind alt-enter expand-abbr insert-line-under
    bind alt-m _harp_get
    bind ctrl-1 _travel_buffer_head
    bind ctrl-3 _travel_yazi_cwd
    bind ctrl-5 _travel_helix_cwd
    bind ctrl-\' _wrap_in_pueue
    bind ctrl-\; 'commandline "ov -Ae -- $(commandline)"'
    bind ctrl-alt-m _harp_set
    bind ctrl-d _delete_commandline_or_exit
    bind ctrl-i 'zi ; commandline -f repaint'
    bind ctrl-l '__fish_cursor_xterm line ; commandline -f repaint'
    bind ctrl-q 'gq ; commandline -f repaint'
    bind ctrl-z s
    bind f1 lazygit
    bind f2 footclient
    bind f3 yazi_cd
    bind f5 helix
    bind f6 'helix .'
    bind f8 'echo ; nu'
    # [[sort off]]
end
funcsave fish_user_key_bindings >/dev/null
