screen.connect_signal("property::geometry", Set_wallpaper)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(client)
	-- New windows are extra, not main
	if not awesome.startup then awful.client.setslave(client) end
	local current_layout = awful.layout.getname(awful.layout.get(client.screen))
	if current_layout == "max" then
		client.border_width = 0
	else
		client.border_width = beautiful.border_width
	end
end)

client.connect_signal("property::maximized", function(client)
	if client.maximized then
		client.border_width = 0
	else
		client.border_width = beautiful.border_width
	end
end)

awful.tag.attached_connect_signal(screen.primary, "property::layout", function (tag)
	for _, client in ipairs(tag:clients()) do
		if tag.layout.name == "max" or client.maximized then
			client.border_width = 0
		else
			client.border_width = beautiful.border_width
		end
	end
end)

client.connect_signal("focus", function(client)
	local tag = client.first_tag
	if #tag:clients() == 1 then
		client.border_width = 0
	else
		client.border_width = beautiful.border_width
		client.border_color = beautiful.border_focus
	end
end)
client.connect_signal("unfocus", function(client)
	local tag = client.first_tag
	if #tag:clients() == 1 then
		client.border_width = 0
	else
		client.border_width = beautiful.border_width
		client.border_color = beautiful.border_normal
	end
end)