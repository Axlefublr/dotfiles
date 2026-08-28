#!/usr/bin/env fish

function _on_sigint -s INT
    echo
end
while true
    kanata --cfg ~/fes/dot/kanata/kanata.kbd
end
