#!/usr/bin/env fish

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

function _execute_via_pueue
    set -l cmd (commandline)
    history append -- $cmd
    pueue add -- $cmd
    commandline ''
    commandline -f repaint
end
funcsave _execute_via_pueue >/dev/null

function _harp_get
    while true
        read -n 1 -P 'harp get: ' -l key || break
        not test "$key" && break
        set -l harp (harp get harp_dirs "$key" | path_expand)
        test "$harp" && cd "$harp"
        break
    end
    commandline -f repaint
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
    bind alt-d _blammo_pwd
    bind alt-enter expand-abbr insert-line-under
    bind ctrl-1 _travel_buffer_head
    bind ctrl-3 _travel_yazi_cwd
    bind ctrl-5 _travel_helix_cwd
    bind ctrl-e _reexec
    bind ctrl-l 'commandline -f clear-screen'
    bind ctrl-o _execute_via_pueue
    bind ctrl-s 'commandline -f repaint'
    bind ctrl-space 'commandline -i " "'
    bind ctrl-z d
    bind f1 'commandline nu ; commandline -f execute'
    bind f2 'commandline lazygit ; commandline -f execute'
    bind f3 yazi_cd
    bind f5 'test "$(commandline)" = " " && helix . || helix'
    bind f6 'swayimg -g & disown ; exit'
    bind super-3 _harp_set
    bind super-s _harp_get
    # [[sort off]]
end
funcsave fish_user_key_bindings >/dev/null
