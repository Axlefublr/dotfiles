#!/usr/bin/env fish

function bind_visual
    bind -M visual $argv
end
funcsave bind_visual >/dev/null

function bind_all
    bind -M default $argv
    bind -M insert $argv
    bind -M visual $argv
end
funcsave bind_all >/dev/null

function bind_both
    bind -M default $argv
    bind -M visual $argv
end
funcsave bind_both >/dev/null

function fish_user_key_bindings
    #------------------------------------------------helix mode------------------------------------------------
    bind w forward-word
    bind b backward-word

    bind D delete-char backward-char
    bind d delete-char forward-single-char backward-char
    bind_visual -m default d kill-selection end-selection

    bind -m visual x begin-selection
    bind_visual -m default x end-selection

    bind -m visual v beginning-of-line begin-selection end-of-line
    bind -m visual V end-of-line begin-selection beginning-of-line
    bind_visual v down-line
    bind_visual V up-line

    bind -m visual % beginning-of-buffer begin-selection end-of-buffer

    bind Y 'commandline | copy'

    bind_both e edit_command_buffer

    bind_both K exit

    #--------------------------------------------------core--------------------------------------------------
    bind_all \el l # believe it or not, this is yazi
    bind_all \ep 'over lazygit &>/dev/null'

    #-------------------------------------------------other-------------------------------------------------
    bind_all \eo expand-abbr
    bind -M insert / expand-abbr self-insert

    bind -M insert \e\r expand-abbr insert-line-under
    bind -M insert -k f4 'commandline ""' # is ctrl+alt+u

    bind_all -k f5 forward-word # is shift+alt+;
    bind_all \e\; accept-autosuggestion

    bind_all \ed clear-screen repaint
    bind_all \eu 'for cmd in sudo doas please; if command -q $cmd; fish_commandline_prepend $cmd; break; end; end'
end
funcsave fish_user_key_bindings >/dev/null
