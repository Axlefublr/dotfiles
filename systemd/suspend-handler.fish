#!/usr/bin/env fish

if test $argv[1] = post
    touch /tmp/mine/just-suspended
    chown axlefublr:axlefublr /tmp/mine/just-suspended
end
