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
