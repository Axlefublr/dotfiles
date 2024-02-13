function Adjust_borders(client)
	local tag = screen.primary.selected_tag
	if not tag then
		return
	end
	local clients = tag:clients()
	local non_weirds = 0
	for _, other_client in ipairs(clients) do
		if other_client ~= client and not (other_client.maximized or other_client.floating) then
			non_weirds = non_weirds + 1
		end
	end
	if client.maximized
		or tag.layout.name == "max"
		or non_weirds == 0 then
		client.border_width = 0
	else
		client.border_width = beautiful.border_width
	end
end

function Adjust_all_borders(tag)
	local tag = tag or screen.primary.selected_tag
	if not tag then
		return
	end
	for _, client in ipairs(tag:clients()) do
		Adjust_borders(client)
	end
end

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
	Adjust_all_borders()
end)

client.connect_signal("property::maximized", function(client)
	Adjust_all_borders()
end)

client.connect_signal("property::floating", function(client)
	Adjust_all_borders()
end)

awful.tag.attached_connect_signal(screen.primary, "property::layout", function (tag)
	Adjust_all_borders(tag)
end)

client.connect_signal("focus", function(client)
	Title_widget:set_text((client.class or "") .. ": " .. (client.name or ""))

	Adjust_borders(client)
	client.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(client)
	client.border_color = beautiful.border_normal
end)