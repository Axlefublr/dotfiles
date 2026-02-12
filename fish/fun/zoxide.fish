#!/usr/bin/env fish

# this is (modified) output of `zoxide init fish`
# it takes a millisecond or two to execute on every shell startup, so I `funcsave` the desired functionality into functions instead,
# as functions in fish are COMPLETELY FREE if lazyloaded (which is the default)

# in upstream, there's some logic that allows to alias `cd` to `z`, but I think it's a stupid ass idea to do that anyway and so I simplify things a bit
# I also never want the `zi` functionality

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end
funcsave __zoxide_pwd >/dev/null

# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (builtin count $argv)
    if test $argc -eq 0
        builtin cd $HOME
    else if test "$argv" = -
        builtin cd -
    else if test $argc -eq 1 -a -d $argv[1]
        builtin cd $argv[1]
        command zoxide add -- (__zoxide_pwd)
    else if test $argc -eq 2 -a $argv[1] = --
        builtin cd -- $argv[2]
        command zoxide add -- (__zoxide_pwd)
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and builtin cd $result
        and command zoxide add -- (__zoxide_pwd)
    end
end
funcsave __zoxide_z >/dev/null

alias --save z __zoxide_z >/dev/null
