#!/usr/bin/env fish

function wm_collect_ids
    set -l wheres
    for arg in $argv
        set -a wheres "| where $arg"
    end
    na -c "
        let found = niri msg -j windows
        | from json
        $wheres
        | get id
        | to text
        | print
    "
end
funcsave wm_collect_ids >/dev/null

function wm_focus_if_exists
    set -l wheres
    for arg in $argv
        set -a wheres "| where $arg"
    end
    na -c "
        let found = niri msg -j windows
        | from json
        $wheres
        if (\$found | is-not-empty) {
            niri msg action focus-window --id (\$found | get id | first)
        } else {
            exit 1
        }
    "
end
funcsave wm_focus_if_exists >/dev/null

function wm_wait_if_or_until_exists
    set -l wheres
    for arg in $argv
        set -a wheres "| where $arg"
    end
    na -c "
        niri msg -j event-stream
        | from json --objects
        | each {
            match \$in {
                { WindowsChanged: { windows: \$the } }       => { \$the $wheres }
                { WindowOpenedOrChanged: { window: \$the } } => { [\$the] $wheres }
            }
        }
        | compact -e
        | first
        | get id
        | first
        | print
        | exit
    "
end
funcsave wm_wait_if_or_until_exists >/dev/null

function wm_wait_until_exists -d 'waits for specifically a new window, ignores existing ones'
    set -l wheres
    for arg in $argv
        set -a wheres "| where $arg"
    end
    na -c "
        niri msg -j event-stream
        | from json --objects
        | each {
            match \$in {
                { WindowOpenedOrChanged: { window: \$the } } => { [\$the] $wheres }
            }
        }
        | compact -e
        | first
        | get id
        | first
        | print
        | exit
    "
end
funcsave wm_wait_until_exists >/dev/null
