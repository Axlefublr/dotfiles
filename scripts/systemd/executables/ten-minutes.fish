#!/usr/bin/env fish

pjs
set notifications (gh api notifications | jq -r '.[] | "\\(.repository.full_name): \\(.subject.title)"')
if test "$notifications"
    task -u $notifications
end