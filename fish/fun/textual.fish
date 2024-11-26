#!/usr/bin/env fish

function mst -a tag
    read -zl the
    echo "<$tag>$the</$tag>"
end
funcsave mst >/dev/null

function msi -a left right
    read -zl the
    echo "$left$the$right"
end
funcsave msi >/dev/null
