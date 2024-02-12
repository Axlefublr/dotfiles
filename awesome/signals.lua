screen.connect_signal("property::geometry", Set_wallpaper)

client.connect_signal("mouse::enter", function(client)
	client:emit_signal("request::activate", "mouse_enter", { raise = true })
end)

client.connect_signal("property::urgent", function(client)
	if client.class == "Spotify" then
		client.urgent = false
	end
end)

client.connect_signal("property::name", function(client)
	if string.match(client.name, '^xzoom') then
		client.ontop = true
		client.floating = true
		client.border_width = 0

		local screen_geometry = client.screen.geometry
		client:geometry({
			x = screen_geometry.x,
			y = screen_geometry.height - 500,
			width = 500,
			height = 500
		})
	elseif client.class == "Anki" and string.match(client.name, "^Browse") then
		Move_window_to_tag(16)
	end
end)

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
	local current_tag = screen.primary.selected_tag

	if not current_tag then
		return
	end
	local clients_on_tag = current_tag:clients()
	if #clients_on_tag == 1 and clients_on_tag[1] == client then
		client.border_width = 0
	else
		client.border_width = beautiful.border_width
		client.border_color = beautiful.border_focus
	end
end)

client.connect_signal("unfocus", function(client)
	client.border_width = beautiful.border_width
	client.border_color = beautiful.border_normal
end)