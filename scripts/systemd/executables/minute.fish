#!/usr/bin/env fish

awesome-client 'Hunger_wu()'
widget_update disk_usage /dev/nvme0n1p2 Disk_usage
# widget_update disk_usage /dev/sda2 Usb_usage
pjs
set notifications (gh api notifications | jq -r '.[] | "\\(.repository.full_name): \\(.subject.title)"')
if test "$notifications"
    task -m 4 $notifications
end
