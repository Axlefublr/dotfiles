local function clients_tag(client)
	local client_on_selected = client:isvisible()
	if client_on_selected then
		return screen.primary.selected_tag
	else
		local fallback = client.first_tag or screen.primary.selected_tag or screen.primary.tags[1]
		return fallback
	end
end

local function is_only_unstated_client(client, clients)
	local only = true
	for _, other_client in ipairs(clients) do
		local stated = other_client.maximized or other_client.floating
		if other_client ~= client and not stated then only = false end
	end
	return only
end

function Adjust_borders(client, tag)
	local tag = tag or clients_tag(client)
	if
		 client.maximized
		 or tag.layout.name == 'max'
		 or is_only_unstated_client(client, tag:clients())
	then
		client.border_width = 0
	else
		client.border_width = beautiful.border_width
	end
end

function Adjust_all_borders(tag, client)
	local tag = tag or clients_tag(client)
	for _, client in ipairs(tag:clients()) do
		Adjust_borders(client, tag)
	end
end

local function on_maybe_name(client)
	if client.name and string.match(client.name, '^xzoom') then
		client.ontop = true
		client.floating = true
		client.sticky = true
		client.border_width = 0

		local screen_geometry = client.screen.geometry
		client:geometry({
			x = screen_geometry.x,
			y = screen_geometry.height - 500,
			width = 500,
			height = 500,
		})
	end
end

screen.connect_signal('property::geometry', Set_wallpaper)

-- client.connect_signal("mouse::enter", function(client)
-- client:emit_signal("request::activate", "mouse_enter", { raise = true })
-- end)

client.connect_signal('property::urgent', function(client)
	if client.class == 'Spotify' then client.urgent = false end
	client.border_color = beautiful.pink
end)

client.connect_signal('property::name', function(client)
	Widget_enable_title(client)
	on_maybe_name(client)
end)

-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(client)
	-- New windows are extra, not main
	if not awesome.startup then awful.client.setslave(client) end
	on_maybe_name(client)
	if client.class == 'Anki' and string.match(client.name, '^Browse') then
		Move_window_to_tag(16)
	end
	Adjust_all_borders(nil, client)
	Widget_update_clients(screen.primary.selected_tag)
end)

client.connect_signal('unmanage', function(client)
	Adjust_all_borders(nil, client)
	Widget_update_clients(screen.primary.selected_tag)
end)

client.connect_signal('property::maximized', function(client)
	Widget_update_clients(screen.primary.selected_tag)
	Widget_update_maximized(client)
	Adjust_all_borders(nil, client) -- all because with two clients, the other, not maximized client, will effectively get maximized
end)

client.connect_signal('property::floating', function(client)
	Widget_update_floating(client)
	Adjust_all_borders(nil, client) -- all because with two clients, the other, not floating client, will effectively get maximized. if the borders on the floating client are not focused, that means that the other client is focused, so we don't need the borders
end)

client.connect_signal('property::ontop', function(client) Widget_update_ontop(client) end)

client.connect_signal('property::sticky', function(client) Widget_update_sticky(client) end)

awful.tag.attached_connect_signal(screen.primary, 'property::layout', function(tag)
	Adjust_all_borders(tag) -- because of the 'max' layout
	Widget_update_malumn(tag)
	Widget_update_clients(tag)
	Widget_update_tile(tag)
end)

awful.tag.attached_connect_signal(
	screen.primary,
	'property::master_count',
	function(tag) Widget_update_malumn(tag) end
)

awful.tag.attached_connect_signal(
	screen.primary,
	'property::column_count',
	function(tag) Widget_update_malumn(tag) end
)

awful.tag.attached_connect_signal(screen.primary, 'property::selected', function(tag)
	Widget_update_malumn(tag)
	Widget_update_clients(tag)
	Widget_update_tile(tag)
end)

client.connect_signal('focus', function(client)
	Widget_enable_title(client)
	Widget_update_ontop(client)
	Widget_update_maximized(client)
	Widget_update_sticky(client)
	Widget_update_floating(client)

	-- this shouldn't be needed, but kept as a safety measure for when I'm bad at logic in the other signals updating all borders
	Adjust_borders(client)
	client.border_color = beautiful.border_focus
end)

client.connect_signal('unfocus', function(client) client.border_color = beautiful.border_normal end)
