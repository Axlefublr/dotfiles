#!/usr/bin/env fish

# set -l stored_colors ~/fes/dot/colors.nuon
function input_color
    set -l picked_color (coloring-book.nu list | fzf --height 50% -e)
    if string match -qe '│' -- "$picked_color"
        echo (string split -f 2 ' │ ' -- "$picked_color")
    else
        echo "$picked_color"
    end
end

function input_name
    set -l picked_name (coloring-book.nu list | fzf --height 50% -e)
    if string match -qe '│' -- "$picked_name"
        echo (string split -f 1 ' │ ' -- "$picked_name" | string trim)
    else
        echo "$picked_name"
    end
end

function warnage
    set_color e49641
    warn $argv
    set_color normal
end

function reconfirm
    ansi_erase_line
    for the in (seq 1 1)
        ansi_cursor_move_start_up
        ansi_erase_line
    end
end

function act_on_color -a color
    while true
        not test "$color" && return
        set color (pastel format hex $color)
        pastel color $color
        set_color $color
        echo -n extended example text
        set_color reset
        echo -n '   '
        set_color (pastel textcolor $color | pastel format hex)
        set_color -b $color
        echo -n extended example text
        set_color reset
        echo
        echo
        while true
            confirm.rs '' '[w]rite' '[i]nput' '[e]dit' '[s]ex' '[c]rgb' '[d]hsl' '[f]lip' '[r]ed' '[R]ed' '[g]reen' '[G]reen' '[b]lue' '[B]lue' '' \
                '[j]ue' '[J]ue' '[l]ight' '[L]ight' 'sa[k]urate' 'sa[K]urate' | read -l response
            switch "$response"
                case w
                    set -l picked_name (input_name)
                    if test "$picked_name"
                        coloring-book.nu write -- "'$color'" $picked_name
                        reconfirm
                        warnage "color “$picked_name” written"
                        continue
                    end
                case e
                    reconfirm
                    niri msg action set-column-width 85%
                    niri msg action center-column
                    helix ~/fes/dot/colors.nuon
                    niri msg action set-column-width 70%
                    niri msg action center-column
                case s
                    set -l hex_repr (pastel format hex -- $color)
                    echo $hex_repr | wl-copy -n
                    reconfirm
                    warnage "$hex_repr copied"
                    continue
                case c
                    set -l rgb_repr (pastel format rgb -- $color)
                    echo $rgb_repr | wl-copy -n
                    reconfirm
                    warnage "$rgb_repr copied"
                    continue
                case d
                    set -l hsl_repr (pastel format hsl -- $color)
                    echo $hsl_repr | wl-copy -n
                    reconfirm
                    warnage "$hsl_repr copied"
                    continue
                case f
                    reconfirm
                    warnage "flip $color"
                    set color (pastel complement -- $color)
                case L
                    reconfirm
                    warnage "dark $color"
                    set color (pastel darken 0.01 -- $color)
                case l
                    reconfirm
                    warnage "light $color"
                    set color (pastel lighten 0.01 -- $color)
                case K
                    reconfirm
                    warnage "saturate ↓ $color"
                    set color (pastel desaturate 0.01 -- $color)
                case k
                    reconfirm
                    warnage "saturate ↑ $color"
                    set color (pastel saturate 0.01 -- $color)
                case j
                    reconfirm
                    warnage "rotate → $color"
                    set color (pastel rotate 1 -- $color)
                case J
                    reconfirm
                    warnage "rotate ← $color"
                    set color (pastel rotate -- -1 $color)
                case r
                    reconfirm
                    warnage "red ↑ $color"
                    set color (color_edit_red $color 1)
                case R
                    reconfirm
                    warnage "red ↓ $color"
                    set color (color_edit_red $color -1)
                case g
                    reconfirm
                    warnage "green ↑ $color"
                    set color (color_edit_green $color 1)
                case G
                    reconfirm
                    warnage "green ↓ $color"
                    set color (color_edit_green $color -1)
                case b
                    reconfirm
                    warnage "blue ↑ $color"
                    set color (color_edit_blue $color 1)
                case B
                    reconfirm
                    warnage "blue ↓ $color"
                    set color (color_edit_blue $color -1)
                case i
                    reconfirm
                    return
            end
            break
        end
    end
end

while true
    coloring-book.nu all
    set -l color (input_color)
    if not test "$color"
        coloring-book.nu all
        continue
    end
    act_on_color "$color"
end
