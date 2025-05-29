#!/usr/bin/env fish

function htmlace
    read -z | string replace -a ' ' '&nbsp;'
    true
end
funcsave htmlace >/dev/null

function htmlize
    read -z | string replace -a '&' '&amp;' | string replace -a '<' '&lt;' | string replace -a '>' '&gt;' | sd \n '<br>' | sd '<br>$' '\n'
    true
end
funcsave htmlize >/dev/null

function msi -a left right
    read -zl the
    echo "$left$the$right"
end
funcsave msi >/dev/null

function mst
    read -zl the
    echo "<$argv>$the</$argv>"
end
funcsave mst >/dev/null

function slf
    string replace '%' (read -z) "$argv"
end
funcsave slf >/dev/null

function tritace
    read -z | sd '(?m)[ \\t]+$' ''
    true
end
funcsave tritace >/dev/null
