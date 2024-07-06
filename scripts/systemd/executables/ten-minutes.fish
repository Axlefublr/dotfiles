#!/usr/bin/env fish

widget_update mature_tasks_line Loago
set notifications (gh api notifications | jq -r '.[] | "\\(.repository.full_name): \\(.subject.title)"')
if test "$notifications"
    task -u $notifications
end