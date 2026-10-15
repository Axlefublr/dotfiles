#!/usr/bin/env fish

set -l query (tac ~/.local/share/magazine/a-g | fzf)
test -n "$query" || return 1

set -l repo (begin
    echo none
    for line in (cat ~/.local/share/magazine/c-l)
        # TODO: include the titles after the thingy separated with a tab
        # TODO: these are currently sorted alphabetically by title, shouldn't be that way
        string match -gr -- 'proj .*? — https://github.com/(?<owner>[^/]+)/(?<repo>[^/]+)' $line &>/dev/null
        test -n "$owner" && test -n "$repo" && echo "$owner/$repo"
    end
end | fzf)
test -n "$repo" || return 1

if test "$repo" != none
    set -f complete_query "repo:$repo $query"
else
    set -f complete_query "$query"
end

confirm.rs '' 'p[e]ar' '[i]ssue' '[r]epo' '[c]ode' | read -l type
set -l type (switch $type
    case 'e'
        echo pullrequests
    case 'i'
        echo issues
    case 'r'
        echo repositories
    case 'c'
        echo code
end)

if test -n "$type"
    set -l clean_query (string escape --style=url -- $complete_query)
    $BROWSER "https://github.com/search?q=$clean_query&type=$type"
    ensure-browser.nu
end

# I may want to retain the *query* in history but not the actual attempt to search for it *right now*
# if I wanted to forget the query as well, I'd close the window altogether
# reason why it's out of order, is performance: if I'm already sent off to my browser, I'm not actively looking at logic happening and taking those sweet sweet milliseconds
indeed.rs -u ~/.local/share/magazine/a-g -- $query
cat ~/.local/share/magazine/a-g | tail -n 200 | sponge ~/.local/share/magazine/a-g
