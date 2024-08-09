#!/usr/bin/env fish

awesome-client 'Hunger_wu()'
set notifications (gh api notifications | jq -r '.[] | "\\(.repository.full_name): \\(.subject.title)"')
if test "$notifications"
    indeed -u ~/.local/share/magazine/4 $notifications
    update_magazine 4
end