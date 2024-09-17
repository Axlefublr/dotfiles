---@param side 'latest'|'oldest'
function env.destroy_sided_notification(side)
	local notification_list = naughty.notifications[screen.primary].bottom_right
	local side_notification = notification_list[side == 'oldest' and 1 or #notification_list]
	if not side_notification then return end
	naughty.destroy(side_notification)
end
