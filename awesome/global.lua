function DestroyLatestNotification()
	local latest_notification = nil
	for _, value in pairs(naughty.notifications[awful.screen.focused()].bottom_right) do
		latest_notification = value
		break
	end
	naughty.destroy(latest_notification)
end
