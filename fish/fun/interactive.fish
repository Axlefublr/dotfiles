#!/usr/bin/env fish

function a
    set -l subsection harp_shell_$argv[1]
    if not test "$argv[2..]"
        harp-shell.nu $subsection
        return
    end
    harp get $subsection $argv[2] 2>/dev/null >/tmp/mine/shell-harp-script
    if not test "$(cat /tmp/mine/shell-harp-script)"
        echo "$argv[1] register `$argv[2]` empty" >&2
        return
    end
    set -l argf $argv[3..]
    source /tmp/mine/shell-harp-script
end
funcsave a >/dev/null

function A
    test "$argv" || return 1
    test "$argv[2]" || return 1
    set -l directory /tmp/mine/shell-harp
    set -l path $directory/$argv[2].fish
    mkdir -p $directory
    harp get harp_shell_$argv[1] $argv[2] 2>/dev/null >$path
    helix -w $directory $path
    harp replace harp_shell_$argv[1] $argv[2] "$(cat $path)"
end
funcsave A >/dev/null

function d
    if not test "$argv"
        harp-shell.nu harp_shell_$PWD
        return
    end
    harp get harp_shell_$PWD $argv[1] 2>/dev/null >/tmp/mine/shell-harp-script
    if not test "$(cat /tmp/mine/shell-harp-script)"
        echo "register `$argv[1]` empty" >&2
        return
    end
    set -l argf $argv[2..]
    source /tmp/mine/shell-harp-script
end
funcsave d >/dev/null

function D
    test "$argv" || return 1
    set -l directory /tmp/mine/shell-harp
    set -l path $directory/$argv[1].fish
    mkdir -p $directory
    harp get harp_shell_$PWD $argv[1] 2>/dev/null >$path
    helix -w $directory $path
    harp replace harp_shell_$PWD $argv[1] "$(cat $path)"
end
funcsave D >/dev/null

function finder
    set -l result "$(fzf '--bind=f12:become:echo :{}')"
    test $result || return
    if test (string sub -l 1 $result) = ':'
        yazi (string sub -s 2 $result)
        return
    end
    if string match -qr '/$' -- $result
        # we don't wanna `cd` in the calling shell
        # and this entire function is not a script for performance of this line
        PWD=$result finder
    else
        helix $result
    end
end
funcsave finder >/dev/null

function git_search
    if not test "$argv[1]"
        echo 'missing arguments for `rg`' >&2
        return 1
    end
    set commits (git log --format=format:"%h")
    for commit in $commits
        truncate -s 0 /tmp/mine/git-search
        set files (git show --format=format:'' --name-only $commit)
        set -l matched_files
        for file in $files
            git show $commit:$file 2>/dev/null | rg --color=always $argv >>/tmp/mine/git-search
            and set matched_files $matched_files $file
            and echo (set_color '#e491b2')$file(set_color normal) >>/tmp/mine/git-search
        end
        if test "$matched_files"
            git show --color=always --oneline $commit -- $matched_files >>/tmp/mine/git-search
        end
        if test -s /tmp/mine/git-search
            cat /tmp/mine/git-search | diff-so-fancy | less
            read -P 'press any key to continue, `q` to quit: ' -ln 1 continue
            if test "$continue" = q
                break
            end
        end
    end
end
funcsave git_search >/dev/null

function git_search_file
    if not test "$argv[1]"
        echo 'the first argument should be the filepath where you want to search for a string' >&2
    end
    if not test "$argv[2]"
        echo 'the second argument and beyond are expected argument(s) to `rg`' >&2
        return 1
    end
    set commits (git log --format=format:"%h" -- $argv[1])
    for commit in $commits
        truncate -s 0 /tmp/mine/git-search
        git show $commit:$argv[1] 2>/dev/null | rg --color=always $argv[2..] >>/tmp/mine/git-search
        and git show --color=always --oneline $commit -- $argv[1] >>/tmp/mine/git-search
        if test -s /tmp/mine/git-search
            cat /tmp/mine/git-search | diff-so-fancy | less
            read -P 'press any key to continue, `q` to quit: ' -ln 1 continue
            if test "$continue" = q
                break
            end
        end
    end
end
funcsave git_search_file >/dev/null
