#!/usr/bin/env fish

while true
    nu --no-std-lib -n ~/.local/share/magazine/o.nu
    inotifytheusual ~/.local/share/magazine/o
end
