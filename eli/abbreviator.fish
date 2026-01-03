#!/usr/bin/env fish

for line in (cat ~/fes/dot/fish/abbr.txt)
    set -l line "$(string trim -- "$line")"
    test $line || continue
    test (string sub -l 1 -- $line) = '#' && continue
    set -l chunks (string split -m 1 ' ← ' -- $line)
    set -l subcommand
    if test $status -eq 0
        set -l hash (echo -n $line | sha256sum | cut -d ' ' -f 1)
        set subcommand " -c "$chunks[1]" $hash -r"
        set line "$chunks[2..]"
    end
    set -l chunks (string split -m 1 ' → ' -- $line)
    set -l cursor
    if string match -qe █ -- "$chunks[2..]"
        set cursor ' --set-cursor=█'
    end
    echo "abbr -a$cursor$subcommand $chunks[1] -- '$chunks[2..]'"
end >~/fes/dot/fish/abbreviations.fish
