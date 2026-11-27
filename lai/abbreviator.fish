#!/usr/bin/env fish

truncate -s 0 ~/fes/dot/fish/fun/autalias.fish
for line in (cat ~/fes/dot/fish/abbr.txt)
    set -l line "$(string trim -- "$line")"
    set -l should_alias (test (string sub -e 1 -- "$line") = 💯 && echo true || echo false)
    set -l line "$(string trim -lc 💯💡 "$line" | string trim)"
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
    if $should_alias
        echo "alias --save $chunks[1] -- $(string escape -- $target) >/dev/null" >>~/fes/dot/fish/fun/autalias.fish
    end
end >~/fes/dot/fish/abbreviations.fish
fish ~/fes/dot/fish/fun/autalias.fish
