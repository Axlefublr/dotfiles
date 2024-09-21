#!/usr/bin/env fish

function binds
    argparse v/visual d/default i/insert -- $argv
    or return 1
    if test "$_flag_visual"
        bind -M visual $argv
    end
    if test "$_flag_default"
        bind -M default $argv
    end
    if test "$_flag_insert"
        bind -M insert $argv
    end
end
funcsave binds >/dev/null

function fish_user_key_bindings
    #------------------------------------------------disabling------------------------------------------------
    binds -vid \es true

    #------------------------------------------------helix mode------------------------------------------------
    bind w forward-word
    bind b backward-word

    bind D delete-char backward-char
    bind d delete-char forward-single-char backward-char
    binds -v -m default d kill-selection end-selection

    bind -m visual x begin-selection
    binds -v -m default x end-selection

    bind -m visual v beginning-of-line begin-selection end-of-line
    bind -m visual V end-of-line begin-selection beginning-of-line
    binds -v v down-line
    binds -v V up-line

    binds -vd -m visual zl begin-selection end-of-line
    binds -vd -m visual zh begin-selection beginning-of-line
    binds -vd gh beginning-of-line
    binds -vd gl end-of-line
    binds -vd gi beginning-of-buffer
    binds -vd go end-of-buffer

    bind -m visual % beginning-of-buffer begin-selection end-of-buffer

    bind S 'commandline | copy'

    binds -vd e edit_command_buffer

    binds -vd K exit

    #--------------------------------------------------core--------------------------------------------------
    binds -vid \em yazi-cd
    binds -vid \ep 'over lazygit'
    binds -vid \eh 'zi && commandline -f repaint'

    #-------------------------------------------------other-------------------------------------------------
    binds -vid \ej complete
    binds -vid \ek complete-and-search
    binds -vid \cn complete
    binds -vid \cp complete-and-search
    binds -vid \eo expand-abbr
    binds -i / expand-abbr self-insert

    binds -i \e\r expand-abbr insert-line-under
    binds -i -k f4 'commandline ""' # is ctrl+alt+u

    binds -vid -k f5 forward-word # is shift+alt+;
    binds -vid \e\; accept-autosuggestion

    binds -vid \ed clear-screen repaint
    binds -vid \eu 'for cmd in sudo doas please; if command -q $cmd; fish_commandline_prepend $cmd; break; end; end'
end
funcsave fish_user_key_bindings >/dev/null
