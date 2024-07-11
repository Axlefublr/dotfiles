screen.connect_signal('property::geometry', Set_wallpaper)

-- client.connect_signal("mouse::enter", function(client)
-- client:emit_signal("request::activate", "mouse_enter", { raise = true })
-- end)

client.connect_signal('property::urgent', function(client)
	if client.class == 'Spotify' then client.urgent = false end
	client.border_color = beautiful.pink
end)

-- client.connect_signal('property::name', function(client) end)

-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(client)
	-- New windows are extra, not main
	if not awesome.startup then awful.client.setslave(client) end
	if client.class == 'Anki' and string.match(client.name, '^Browse') then MoveWindowToTag(16) end
	Clients_wu(screen.primary.selected_tag)
end)

client.connect_signal('unmanage', function(_)
	Clients_wu(screen.primary.selected_tag)
	Floating_state_wu(false)
end)

client.connect_signal('property::minimized', function(client)
	Clients_wu(screen.primary.selected_tag)
end)

client.connect_signal('property::maximized', function(client)
	Clients_wu(screen.primary.selected_tag)
	Maximized_state_wu(client)
end)

client.connect_signal('property::floating', function(client) Floating_state_wu(client) end)

client.connect_signal('property::ontop', function(client) Ontop_state_wu(client) end)

client.connect_signal('property::sticky', function(client) Sticky_state_wu(client) end)

awful.tag.attached_connect_signal(screen.primary, 'property::layout', function(tag)
	Malumn_wu(tag)
	Clients_wu(tag)
	Tile_wu(tag)
end)

awful.tag.attached_connect_signal(screen.primary, 'property::master_count', function(tag) Malumn_wu(tag) end)

awful.tag.attached_connect_signal(screen.primary, 'property::column_count', function(tag) Malumn_wu(tag) end)

awful.tag.attached_connect_signal(screen.primary, 'property::selected', function(tag)
	Malumn_wu(tag)
	Clients_wu(tag)
	Tile_wu(tag)
end)

client.connect_signal('focus', function(client)
	Ontop_state_wu(client)
	Maximized_state_wu(client)
	Sticky_state_wu(client)
	Floating_state_wu(client)

	client.border_color = beautiful.border_focus
end)

client.connect_signal('unfocus', function(client) client.border_color = beautiful.border_normal end)
