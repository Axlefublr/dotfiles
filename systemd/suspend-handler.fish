#!/usr/bin/env fish

if test $argv[1] = post
    touch /tmp/cami-just-suspended
    chown axlefublr:axlefublr /tmp/cami-just-suspended
end
