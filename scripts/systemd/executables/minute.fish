#!/usr/bin/env fish

pjs
set notifications (gh api notifications | jq -r '.[] | "\\(.repository.full_name): \\(.subject.title)"')
if test "$notifications"
    printf %s\n $notifications >~/.local/share/magazine/4
else
    truncate -s 0 ~/.local/share/magazine/4
end
_magazine_commit ~/.local/share/magazine/4 'gh notifs'
