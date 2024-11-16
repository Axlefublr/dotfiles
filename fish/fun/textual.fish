#!/usr/bin/env fish

function mst -a tag
    read -zl the
    echo "<$tag>$the</$tag>"
end
funcsave mst >/dev/null
