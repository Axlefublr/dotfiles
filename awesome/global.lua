---@param side 'latest'|'oldest'
function DestroySidedNotification(side)
	local notification_list = naughty.notifications[awful.screen.focused()].bottom_right
	local side_notification = notification_list[side == 'oldest' and 1 or #notification_list]
	if not side_notification then return end
	naughty.destroy(side_notification)
end
