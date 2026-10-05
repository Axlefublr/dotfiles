#!/usr/bin/env fish

function log_log_layer_changes -a enabled
    set_color -o b58cc6
    warn -n 'log layer changes: '
    if $enabled
        set_color -o green
        warn enabled
    else
        set_color -o red
        warn disabled
    end
    set_color normal
end

function _on_sigint -s INT
    echo
end
while true
    log_log_layer_changes false
    kanata --cfg ~/fes/dot/kanata/kanata.kbd
    log_log_layer_changes true
    kanata --cfg ~/fes/dot/kanata/kanata.kbd --log-layer-changes
end
