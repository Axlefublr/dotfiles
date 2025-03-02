#!/usr/bin/env fish

function _replace_selection_with_clipboard
    set -l buffer (commandline)
    set -l start (math (commandline -B) + 1)
    set -l finish (commandline -E)
    set -l resulting (string replace (string sub -s $start -e $finish $buffer) (ypoc) $buffer)
    commandline "$resulting"
    commandline -f end-selection repaint
end
funcsave _replace_selection_with_clipboard >/dev/null

function _replace_character_with_clipboard
    commandline -f delete-char
    commandline -i (ypoc)
end
funcsave _replace_character_with_clipboard >/dev/null

function _help_the_commandline
    set -f commandline (commandline -o)
    $commandline --help &>~/.cache/mine/current-help.txt
    helix -c ~/r/dot/helix/man.toml ~/.cache/mine/current-help.txt
end
funcsave _help_the_commandline >/dev/null

function _man_the_commandline
    set -f commandline (commandline -o)[1]
    man $commandline 2>/dev/null >~/.cache/mine/current-man.txt
    helix -c ~/r/dot/helix/man.toml ~/.cache/mine/current-man.txt
end
funcsave _man_the_commandline >/dev/null

function _match_helix_cwd
    set -l current (math (clorange _match_helix_cwd increment) % 3 + 1)
    if test "$current" -eq 1
        set -U matched_cwd ffd75f
        z (cat /tmp/helix-cwd-suspend)
    else if test "$current" -eq 2
        set -U matched_cwd ff9f1a
        z (cat /tmp/helix-buffer-head-suspend)
    else if test "$current" -eq 3
        set -U matched_cwd af87ff
        z (cat ~/.cache/mine/yazi-cwd-suspend)
    else
        set -U matched_cwd ?
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

    binds -s -m visual x true
    binds -d -m visual x begin-selection
    binds -v -m default x end-selection
    binds -vs \; begin-selection

    binds -vs , swap-selection-start-stop
    binds -vds -m insert a insert-line-under repaint-mode
    binds -vds -m insert A insert-line-over repaint-mode

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
    binds -vs -m insert p 'commandline -C "$(commandline -E)" ; commandline -f end-selection'

    binds -d -m insert p forward-single-char repaint-mode
    binds -vds -m insert P end-of-line repaint-mode
    binds -vds o forward-char yank
    binds -vds O yank

    binds -ds -m visual % beginning-of-buffer begin-selection end-of-buffer

    binds -vs -m replace_one r repaint-mode

    binds -vds f forward-jump
    binds -vds t backward-jump
    binds -vds F forward-jump-till
    binds -vds T backward-jump-till
    binds -vds R repeat-jump

    binds -d : _replace_character_with_clipboard
    binds -sv -m default : _replace_selection_with_clipboard

    bind s 'commandline | copy'
    binds -vs s fish_clipboard_copy
    binds -vds K exit

    binds -vds q edit_command_buffer

    #--------------------------------------------------core--------------------------------------------------
    binds -vids \el 'zi && commandline -f repaint'

    #-------------------------------------------------other-------------------------------------------------
    binds -vids \ej complete
    binds -vids \cn complete
    binds -vids \ek complete-and-search
    binds -vids \cp complete-and-search
    binds -vids \eo expand-abbr
    binds -i / expand-abbr self-insert

    binds -i \e\r expand-abbr insert-line-under
    binds -i -k f4 'commandline ""' # is ctrl+alt+u

    binds -vs -m insert \n end-selection execute
    binds -vs -m insert \r end-selection execute
    binds -vids -k f5 forward-word # is shift+alt+;
    binds -vids \e\; accept-autosuggestion

    binds -vids \e. _man_the_commandline
    binds -vids \e, _help_the_commandline

    binds -vids \cz fg
    binds -vids \cy _match_helix_cwd

    binds -vids \cr _wrap_in_pueue

    binds -vids \e/ _fzf_history
    binds -vids \ed 'echo nope ; commandline -f repaint'
end
funcsave fish_user_key_bindings >/dev/null
