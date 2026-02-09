#!/usr/bin/env fish

for line in (cat ~/fes/dot/fish/abbr.txt)
    set -l line "$(string trim -- "$line")"
    test $line || continue
    test (string sub -l 1 -- $line) = '#' && continue
    set -l subcommand
    set -l chunks (string split -m 1 ' ← ' -- $line)
    if test $status -eq 0
        for sub in (string split -n ' ' -- $chunks[1])
            set subcommand "$subcommand -c $sub"
        end
        set -l hash (echo -n $line | sha256sum | cut -d ' ' -f 1)
        set subcommand "$subcommand $hash -r"
        set line "$chunks[2..]"
    end
    set -l chunks (string split -m 1 ' → ' -- $line)
    set -l cursor
    if string match -qe █ -- "$chunks[2..]"
        set cursor ' --set-cursor=█'
    end
    set -l target "$chunks[2..]"
    set -l target "$(string replace -a ¬ \n -- $target)"
    echo "abbr -a$cursor$subcommand $chunks[1] -- $(string escape -- $target)"
end >~/fes/dot/fish/abbreviations.fish
