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

function htmlize
    read -zl | string replace -a '&' '&amp;' | string replace -a '<' '&lt;' | string replace -a '>' '&gt;'
end
funcsave htmlize >/dev/null

function htmlace
    read -z | string replace -a ' ' '&nbsp;'
end
funcsave htmlace >/dev/null
