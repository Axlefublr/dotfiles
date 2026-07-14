#!/usr/bin/env fish

# set -l stored_colors ~/fes/dot/colors.nuon
function input_color
    set -l picked_color (coloring-book.nu list | fzf)
    if string match -qe '│' -- "$picked_color"
        echo (string split -f 2 ' │ ' -- "$picked_color")
    else
        echo "$picked_color"
    end
end

function input_name
    set -l picked_name (coloring-book.nu list | fzf)
    if string match -qe '│' -- "$picked_name"
        echo (string split -f 1 ' │ ' -- "$picked_name" | string trim)
    else
        echo "$picked_name"
    end
end

function act_on_color -a color
    not test "$color" && return
    pastel color $color
    confirm.rs '' '[w]rite' '[i]nput' | read -l response
    switch "$response"
        case w
            set -l picked_name (input_name)
            if test "$picked_name"
                coloring-book.nu write -- "'$color'" $picked_name
                set_color e49641
                warn "color “$picked_name” written"
                set_color normal
            end
        case i
            return
    end
    act_on_color $color
end

while true
    set -l color (input_color)
    not test "$color" && continue
    act_on_color "$color"
end
