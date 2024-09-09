screen.connect_signal('property::geometry', Set_wallpaper)

--------------------------------------------------top level--------------------------------------------------

client.connect_signal('manage', function(client)
	-- new windows are extra, not main
	if not awesome.startup then awful.client.setslave(client) end
	Clients_wu(screen.primary.selected_tag)
end)

client.connect_signal('unmanage', function(_)
	Clients_wu(screen.primary.selected_tag)
	Floating_state_wu(false)
end)

----------------------------------------------client properties----------------------------------------------

client.connect_signal('property::urgent', function(client)
	if client.class == 'Spotify' then client.urgent = false end
end)

-- client.connect_signal('property::name', function(_) end)

client.connect_signal('property::minimized', function(_) Clients_wu(screen.primary.selected_tag) end)

client.connect_signal('property::maximized', function(client) Maximized_state_wu(client) end)
client.connect_signal('property::floating', function(client) Floating_state_wu(client) end)
client.connect_signal('property::ontop', function(client) Ontop_state_wu(client) end)
client.connect_signal('property::sticky', function(client) Sticky_state_wu(client) end)

--------------------------------------------------tag local--------------------------------------------------

awful.tag.attached_connect_signal(screen.primary, 'property::layout', function(tag)
	Malumn_wu(tag)
	Clients_wu(tag)
	Tile_wu(tag)
end)

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
end)

-- client.connect_signal('unfocus', function(_) end)

awful.tag.attached_connect_signal(screen.primary, 'property::master_count', function(tag) Malumn_wu(tag) end)
awful.tag.attached_connect_signal(screen.primary, 'property::column_count', function(tag) Malumn_wu(tag) end)
