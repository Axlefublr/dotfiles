#!/usr/bin/env fish

function runner_clipboard
    set result (get_input)
    test $status -ne 0 && return 1
    test "$result" || return 1
    echo $result | wl-copy -n
end
funcsave runner_clipboard >/dev/null

function runner_fish_function
    set -l found_funcs (rg -nt fish -- '^(function|alias --save)' ~/fes/dot/fish/fun/*)
    set -l picked_index (string match -gr -- '.*?:\d+:(?:function|alias --save) (\S+)' $found_funcs | fuzzel -d --index --match-mode exact --cache ~/fes/zufi/runner-fish-function)
    test -z "$picked_index" && return 1
    string match -gr -- '(.*?:\d+):' $found_funcs[(math $picked_index + 1)]
end
funcsave runner_fish_function >/dev/null

function runner_interactive_unicode
    set -l input (cat ~/.local/share/magazine/E | fuzzel -d --cache ~/fes/zufi/runner-interactive-unicode 2>/dev/null)
    test $status -ne 0 && return 1
    string split -f 1 -- ' ' $input | wl-copy -n -t text/plain
end
funcsave runner_interactive_unicode >/dev/null

function runner_kanata_layer
    set -l found_layers (rg -n -- '^\(deflayermap \([^)]+\)' ~/fes/dot/kanata/*)
    set -l picked_index (string match -gr -- '.*?:\d+:\(deflayermap \(([^)]+)\)' $found_layers | fuzzel -d --index --match-mode exact --cache ~/fes/zufi/runner-kanata-layer)
    test -z "$picked_index" && return 1
    string match -gr -- '(.*?:\d+):' $found_layers[(math $picked_index + 1)]
end
funcsave runner_kanata_layer >/dev/null

function runner_link
    set file ~/.local/share/magazine/c-l
    set result (cat $file | string replace -ar ' — .+$' '' | fuzzel -d --index --cache ~/fes/zufi/runner-link --match-mode exact --width 55 2>/dev/null)
    set -l statorus $status
    test "$result" || return 1
    set line (math $result + 1)
    if test $statorus -eq 10
        flour --disown $file:$line
        return
    end
    set link (awk "NR==$line { print \$NF }" $file)
    if test "$argv[1]"
        $BROWSER $link
        ensure-browser.nu
    else
        echo $link | wl-copy -n
        notify-send -t 2000 "copied link: $link"
    end
end
funcsave runner_link >/dev/null

function runner_math
    # set -l input_expr (cat ~/fes/zufi/runner-math | fuzzel -dl 2 2>/dev/null)
    # test $status -ne 0 && return 1
    # test "$input_expr" || return 1
    # echo $input_expr >~/fes/zufi/runner-math
    # set -l calculated_result (qalc -t -- $input_expr | tee -a ~/fes/zufi/runner-math)
    # notify-send -t 0 -- "$calculated_result"
    # echo $calculated_result | wl-copy -n
    foottitled.sh floating-calculator -N calc
end
funcsave runner_math >/dev/null

function runner_notification
    set -f do_it_again true
    while $do_it_again
        set do_it_again false
        set input (fuzzel -dl 0 2>/dev/null)
        set -l result $status
        if test $result -eq 10
            set do_it_again true
        else if test $result -ne 0
            return 1
        end
        notify-send -t 0 -- "$input"
        echo "$input" | wl-copy -n
    end
end
funcsave runner_notification >/dev/null

function runner_symbol_name
    set -l input (cat ~/.local/share/magazine/c-e | fuzzel -d --match-mode exact --cache ~/fes/zufi/runner-symbol-name 2>/dev/null)
    test $status -ne 0 && return 1
    string split -f 2 -- ' ' $input | wl-copy -n -t text/plain
end
funcsave runner_symbol_name >/dev/null
