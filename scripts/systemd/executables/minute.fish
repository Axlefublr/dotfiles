#!/usr/bin/env fish

awesome-client 'Hunger_wu()'
widget_update disk_usage Disk_usage
pjs
set notifications (gh api notifications | jq -r '.[] | "\\(.repository.full_name): \\(.subject.title)"')
if test "$notifications"
    task -m 4 $notifications
end
