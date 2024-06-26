function Move_window_to_tag(index)
	if client.focus then
		local tag = client.focus.screen.tags[index]
		if tag then client.focus:move_to_tag(tag) end
	end
end

function Ignore_all_urgencies()
	for _, client in ipairs(client.get()) do
		if client.urgent then client.urgent = false end
	end
end

function Unminimize_all_on_tag(tag)
	local tag = tag or awful.tag.selected(awful.screen.focused())
	for _, client in ipairs(tag:clients()) do
		if client.minimized then
			client.minimized = false
		end
	end
end

local activate_tag = function(index)
	local screen = awful.screen.focused()
	local tag = screen.tags[index]
	if tag then tag:view_only() end
end

local toggle_window_on_tag = function(index)
	if client.focus then
		local tag = client.focus.screen.tags[index]
		if tag then client.focus:toggle_tag(tag) end
	end
end

function Write_client_info()
	local text = ''
	for _, client in ipairs(client.get()) do
		if client.instance then
			text = text .. ':' .. client.instance .. ': '
		else
			text = text .. '??? '
		end
		if client.class then
			text = text .. '!' .. client.class .. '! '
		else
			text = text .. '??? '
		end
		if client.name then
			text = text .. ';' .. client.name .. '; '
		else
			text = text .. '???'
		end
		text = text .. '\n'
	end
	local file = io.open('/home/axlefublr/.local/share/magazine/i', 'w')
	if file then
		file:write(text)
		file:close()
	end
end

-- Buttons
root.buttons(gears.table.join(awful.button({}, 3, function() Menu_w:toggle() end)))

Client_buttons = gears.table.join(
	awful.button({}, 1, function(client)
		if client.class == 'Display' then
			awful.mouse.client.move(client)
		else
			client:emit_signal('request::activate', 'mouse_click', { raise = false })
		end
	end),
	awful.button({}, 3, function(client)
		if client.class == 'Display' then client:kill() end
	end),
	awful.button({ modkey }, 1, function(client)
		client:emit_signal('request::activate', 'mouse_click', { raise = true })
		awful.mouse.client.move(client)
	end),
	awful.button({ modkey }, 2, function(client) client:kill() end),
	awful.button({ modkey }, 3, function(client)
		client:emit_signal('request::activate', 'mouse_click', { raise = true })
		awful.mouse.client.resize(client)
	end)
)

Global_keys = gears.table.join(
	awful.key({ modkey }, 'l', function() awful.client.focus.byidx(1) end),
	awful.key({ modkey }, 'h', function() awful.client.focus.byidx(-1) end),
	awful.key({ modkey, 'Control' }, 'l', function() awful.client.swap.byidx(1) end),
	awful.key({ modkey, 'Control' }, 'h', function() awful.client.swap.byidx(-1) end),
	awful.key({ modkey, 'Mod1' }, 'l', function()
		awful.client.swap.byidx(1)
		awful.client.focus.byidx(-1)
	end),
	awful.key({ modkey, 'Mod1' }, 'h', function()
		awful.client.swap.byidx(-1)
		awful.client.focus.byidx(1)
	end),

	awful.key({ modkey }, 'n', function()
		naughty.toggle()
		Dnd_wu()
	end),

	awful.key({ modkey, 'Mod1' }, 'k', function() awful.tag.incmwfact(0.02) end),
	awful.key({ modkey, 'Mod1' }, 'j', function() awful.tag.incmwfact(-0.02) end),
	awful.key({ modkey }, ']', function() awful.tag.incnmaster(1, nil, true) end),
	awful.key({ modkey }, '[', function() awful.tag.incnmaster(-1, nil, true) end),
	awful.key({ modkey, 'Mod1' }, ']', function() awful.tag.incncol(1, nil, true) end),
	awful.key({ modkey, 'Mod1' }, '[', function() awful.tag.incncol(-1, nil, true) end),
	awful.key({ modkey }, 'j', function() awful.spawn('fish -c runner') end),

	-- Activate tags
	awful.key({ modkey }, 'u', function() activate_tag(1) end),
	awful.key({ modkey }, 'i', function() activate_tag(2) end),
	awful.key({ modkey }, 'o', function() activate_tag(3) end),
	awful.key({ modkey }, 'p', function() activate_tag(4) end),
	awful.key({ modkey }, 'm', function() activate_tag(5) end),
	awful.key({ modkey }, ',', function() activate_tag(6) end),
	awful.key({ modkey }, '.', function() activate_tag(7) end),
	awful.key({ modkey }, '/', function() activate_tag(8) end),
	awful.key({ modkey, 'Mod1' }, 'u', function() activate_tag(9) end),
	awful.key({ modkey, 'Mod1' }, 'i', function() activate_tag(10) end),
	awful.key({ modkey, 'Mod1' }, 'o', function() activate_tag(11) end),
	awful.key({ modkey, 'Mod1' }, 'p', function() activate_tag(12) end),
	awful.key({ modkey, 'Mod1' }, 'm', function() activate_tag(13) end),
	awful.key({ modkey, 'Mod1' }, ',', function() activate_tag(14) end),
	awful.key({ modkey, 'Mod1' }, '.', function() activate_tag(15) end),
	awful.key({ modkey, 'Mod1' }, '/', function() activate_tag(16) end),

	-- Move window to tag
	awful.key({ modkey, 'Control' }, 'u', function() Move_window_to_tag(1) end),
	awful.key({ modkey, 'Control' }, 'i', function() Move_window_to_tag(2) end),
	awful.key({ modkey, 'Control' }, 'o', function() Move_window_to_tag(3) end),
	awful.key({ modkey, 'Control' }, 'p', function() Move_window_to_tag(4) end),
	awful.key({ modkey, 'Control' }, 'm', function() Move_window_to_tag(5) end),
	awful.key({ modkey, 'Control' }, ',', function() Move_window_to_tag(6) end),
	awful.key({ modkey, 'Control' }, '.', function() Move_window_to_tag(7) end),
	awful.key({ modkey, 'Control' }, '/', function() Move_window_to_tag(8) end),
	awful.key({ modkey, 'Control', 'Mod1' }, 'u', function() Move_window_to_tag(9) end),
	awful.key({ modkey, 'Control', 'Mod1' }, 'i', function() Move_window_to_tag(10) end),
	awful.key({ modkey, 'Control', 'Mod1' }, 'o', function() Move_window_to_tag(11) end),
	awful.key({ modkey, 'Control', 'Mod1' }, 'p', function() Move_window_to_tag(12) end),
	awful.key({ modkey, 'Control', 'Mod1' }, 'm', function() Move_window_to_tag(13) end),
	awful.key({ modkey, 'Control', 'Mod1' }, ',', function() Move_window_to_tag(14) end),
	awful.key({ modkey, 'Control', 'Mod1' }, '.', function() Move_window_to_tag(15) end),
	awful.key({ modkey, 'Control', 'Mod1' }, '/', function() Move_window_to_tag(16) end),
	awful.key({ modkey, 'Shift' }, 'u', function() toggle_window_on_tag(1) end),
	awful.key({ modkey, 'Shift' }, 'i', function() toggle_window_on_tag(2) end),
	awful.key({ modkey, 'Shift' }, 'o', function() toggle_window_on_tag(3) end),
	awful.key({ modkey, 'Shift' }, 'p', function() toggle_window_on_tag(4) end),
	awful.key({ modkey, 'Shift' }, 'm', function() toggle_window_on_tag(5) end),
	awful.key({ modkey, 'Shift' }, ',', function() toggle_window_on_tag(6) end),
	awful.key({ modkey, 'Shift' }, '.', function() toggle_window_on_tag(7) end),
	awful.key({ modkey, 'Shift' }, '/', function() toggle_window_on_tag(8) end),
	awful.key({ modkey, 'Shift', 'Mod1' }, 'u', function() toggle_window_on_tag(9) end),
	awful.key({ modkey, 'Shift', 'Mod1' }, 'i', function() toggle_window_on_tag(10) end),
	awful.key({ modkey, 'Shift', 'Mod1' }, 'o', function() toggle_window_on_tag(11) end),
	awful.key({ modkey, 'Shift', 'Mod1' }, 'p', function() toggle_window_on_tag(12) end),
	awful.key({ modkey, 'Shift', 'Mod1' }, 'm', function() toggle_window_on_tag(13) end),
	awful.key({ modkey, 'Shift', 'Mod1' }, ',', function() toggle_window_on_tag(14) end),
	awful.key({ modkey, 'Shift', 'Mod1' }, '.', function() toggle_window_on_tag(15) end),
	awful.key({ modkey, 'Shift', 'Mod1' }, '/', function() toggle_window_on_tag(16) end)
)

root.keys(Global_keys)

Client_keys = gears.table.join(
	awful.key({ modkey, 'Shift' }, 'w', function(client)
		local current_tag = screen.primary.selected_tag
		if current_tag then
			for _, other_client in ipairs(current_tag:clients()) do
				if other_client ~= client then other_client:kill() end
			end
		end
	end)
)
