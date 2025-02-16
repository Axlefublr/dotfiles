#!/usr/bin/env fish

for file in $argv
    not test -f $file && continue
    set -l result_file "$(begin
        set -l to_sort
        set -l grabbing false
        for line in (cat $file)
            if string match -qe '[[sort'' on]]' "$line"
                echo "$line"
                set grabbing true
            else if string match -qe '[[sort'' off]]' "$line"
                printf '%s\n' $to_sort | sort.py
                set to_sort
                echo "$line"
                set grabbing false
            else if $grabbing
                set to_sort $to_sort $line
            else
                echo "$line"
            end
        end

        if $grabbing
            printf '%s\n' $to_sort | sort.py
        end
    end)"
    if test "$(cat $file)" != $result_file
        echo $result_file >$file
    end
end
