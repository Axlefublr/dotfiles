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
    if test -n "$(commandline)"
        commandline -f expand-abbr
        commandline -i ' '
    else
        while true
            read -n 1 -P 'harp get: ' -l key || break
            not test "$key" && break
            set -l harp (harp get harp_dirs "$key" | path_expand)
            test "$harp" && cd "$harp"
            break
        end
        commandline -f repaint
    end
end
funcsave _harp_get >/dev/null

function _harp_set
    while true
        read -n 1 -P 'harp set: ' -l key || break
        not test "$key" && break
        set -l harp (harp replace harp_dirs "$key" (pwd_pretty))
        break
    end
    commandline -f repaint
end
funcsave _harp_set >/dev/null

function _blammo_pwd
    commandline -i (pwd_pretty)
end
funcsave _blammo_pwd >/dev/null

function _reexec
    history search -n 1 | source
end
funcsave _reexec >/dev/null

function fish_user_key_bindings
    # [[sort on]]
    bind / expand-abbr self-insert
    bind alt-. _man_the_commandline
    bind alt-comma _help_the_commandline
    bind alt-d _blammo_pwd
    bind alt-enter expand-abbr insert-line-under
    bind alt-space _harp_set
    bind ctrl-1 _travel_buffer_head
    bind ctrl-3 _travel_yazi_cwd
    bind ctrl-5 _travel_helix_cwd
    bind ctrl-\' _wrap_in_pueue
    bind ctrl-\; 'commandline "ov -Ae -- $(commandline)"'
    bind ctrl-d _delete_commandline_or_exit
    bind ctrl-e _reexec
    bind ctrl-i 'zi ; commandline -f repaint'
    bind ctrl-l 'commandline -f clear-screen'
    bind ctrl-q 'z .. ; commandline -f repaint'
    bind ctrl-s 'commandline -f repaint'
    bind ctrl-space 'commandline -i " "'
    bind ctrl-z d
    bind f1 'commandline nu ; commandline -f execute'
    bind f2 'commandline lazygit ; commandline -f execute'
    bind f3 'test "$(commandline)" = " " && helix . || helix'
    bind f5 yazi_cd
    bind f6 'swayimg -g & disown ; exit'
    bind space _harp_get
    # [[sort off]]
end
funcsave fish_user_key_bindings >/dev/null
