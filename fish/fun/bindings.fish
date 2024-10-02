#!/usr/bin/env fish

function binds
    argparse -i v/visual d/default i/insert s/sub -- $argv
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
    if test "$_flag_sub"
        bind -M sub $argv
    end
end
funcsave binds >/dev/null

function fish_user_key_bindings
    #------------------------------------------------disabling------------------------------------------------
    binds -vids \es true

    #------------------------------------------------helix mode------------------------------------------------
    binds -d -m sub w begin-selection forward-word forward-single-char
    binds -d -m sub b begin-selection backward-word
    binds -d -m sub e begin-selection forward-single-char forward-word backward-char
    binds -d -m sub W begin-selection forward-bigword forward-single-char
    binds -d -m sub B begin-selection backward-bigword
    binds -d -m sub E begin-selection forward-single-char forward-bigword backward-char

    binds -s w end-selection begin-selection forward-word forward-single-char
    binds -s b end-selection begin-selection backward-word
    binds -s e end-selection begin-selection forward-single-char forward-word backward-char
    binds -s W end-selection begin-selection forward-bigword forward-single-char
    binds -s B end-selection begin-selection backward-bigword
    binds -s E end-selection begin-selection forward-single-char forward-bigword backward-char

    binds -v w forward-word forward-single-char
    binds -v b backward-word
    binds -v e forward-single-char forward-word backward-char
    binds -v W forward-bigword forward-single-char
    binds -v B backward-bigword
    binds -v E forward-single-char forward-bigword backward-char

    binds -s -m default h end-selection backward-char
    binds -s -m default l end-selection forward-char

    bind D delete-char backward-char
    bind d delete-char forward-single-char backward-char
    binds -vs -m default d kill-selection end-selection

    binds -ds -m visual x begin-selection
    binds -v -m default x end-selection
    binds -vs \; begin-selection

    binds -vs , swap-selection-start-stop

    binds -d -m visual v beginning-of-line begin-selection end-of-line
    binds -d -m visual V end-of-line begin-selection beginning-of-line
    binds -s -m visual v beginning-of-line swap-selection-start-stop end-of-line
    binds -s -m visual V end-of-line swap-selection-start-stop beginning-of-line
    binds -v v forward-char end-of-line
    binds -v V backward-char beginning-of-line

    binds -vds -m visual zl begin-selection end-of-line
    binds -vds -m visual zh begin-selection beginning-of-line
    binds -vds gh beginning-of-line
    binds -vds gl end-of-line
    binds -vds gi beginning-of-buffer
    binds -vds go end-of-buffer

    binds -vs -m insert c kill-selection end-selection
    bind -m insert c delete-char

    binds -vs -m insert i 'commandline -C "$(commandline -B)" ; commandline -f end-selection'
    binds -vs -m insert a 'commandline -C "$(commandline -E)" ; commandline -f end-selection'

    binds -ds -m visual % beginning-of-buffer begin-selection end-of-buffer

    bind S 'commandline | copy'
    binds -vs S fish_clipboard_copy
    binds -vds K exit

    binds -vds q edit_command_buffer

    #--------------------------------------------------core--------------------------------------------------
    binds -vids \em yazi-cd
    binds -vids \eh 'over lazygit'
    binds -vids \el 'zi && commandline -f repaint'

    #-------------------------------------------------other-------------------------------------------------
    binds -vids \ej complete
    binds -vids \ek complete-and-search
    binds -vids \cn complete
    binds -vids \cp complete-and-search
    binds -vids \eo expand-abbr
    binds -i / expand-abbr self-insert

    binds -i \e\r expand-abbr insert-line-under
    binds -i -k f4 'commandline ""' # is ctrl+alt+u

    binds -vids -k f5 forward-word # is shift+alt+;
    binds -vids \e\; accept-autosuggestion

    binds -vids \ed clear-screen repaint
    binds -vids \eu 'for cmd in sudo doas please; if command -q $cmd; fish_commandline_prepend $cmd; break; end; end'
end
funcsave fish_user_key_bindings >/dev/null
