#!/usr/bin/env fish

# set -l stored_colors ~/fes/dot/colors.nuon
function input_color
    set -l picked_color (coloring-book.nu list | fzf --height 50%)
    if string match -qe '│' -- "$picked_color"
        echo (string split -f 2 ' │ ' -- "$picked_color")
    else
        echo "$picked_color"
    end
end

function input_name
    set -l picked_name (coloring-book.nu list | fzf --height 50%)
    if string match -qe '│' -- "$picked_name"
        echo (string split -f 1 ' │ ' -- "$picked_name" | string trim)
    else
        echo "$picked_name"
    end
end

function warnage
    set_color e49641
    warn (string pad -rc ' ' -w $COLUMNS "$argv") # because we are probably overwriting the confirm.rs above
    set_color normal
end

function recolors
    ansi_move_cursor_up (coloring-book.nu all count)
    feline
    ansi_move_cursor_up 2
end

alias feline 'string pad -rc " " -w $COLUMNS ""'
alias reconfirm 'ansi_move_cursor_up 2'

function act_on_color -a color
    not test "$color" && return
    pastel color $color
    while true
        confirm.rs '' '[w]rite' '[i]nput' 'he[s]' '[r]gb' 'hs[l]' | read -l response
        switch "$response"
            case w
                set -l picked_name (input_name)
                if test "$picked_name"
                    coloring-book.nu write -- "'$color'" $picked_name
                    reconfirm
                    warnage "color “$picked_name” written"
                    continue
                end
            case s
                set -l hex_repr (pastel format hex -- $color)
                echo $hex_repr | wl-copy -n
                reconfirm
                warnage "$hex_repr copied"
                continue
            case r
                set -l rgb_repr (pastel format rgb -- $color)
                echo $rgb_repr | wl-copy -n
                reconfirm
                warnage "$rgb_repr copied"
                continue
            case l
                set -l hsl_repr (pastel format hsl -- $color)
                echo $hsl_repr | wl-copy -n
                reconfirm
                warnage "$hsl_repr copied"
                continue
            case i
                reconfirm
                return
        end
        break
    end
    act_on_color $color
end

set -g first_print true
set -g blank true
while true
    coloring-book.nu all
    set -l color (input_color)
    if not test "$color"
        if $blank
            clear
        else
            recolors
        end
        continue
    else if $first_print
        clear
        set -g first_print false
    else
        recolors
    end
    set -g blank false
    act_on_color "$color"
end
