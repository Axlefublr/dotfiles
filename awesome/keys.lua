local activate_tag = function(tag)
	local screen = screen.primary
	local tag = type(tag) == 'number' and screen.tags[tag] or tag
	if tag then tag:view_only() end
end

local toggle_window_on_tag = function(index)
	if client.focus then
		local tag = client.focus.screen.tags[index]
		if tag then client.focus:toggle_tag(tag) end
	end
end

---@alias BrowserInstance
---| 'main'
---| 'content'

---@param index BrowserInstance|integer
function FixBrowserInstance(index)
	if type(index) == 'string' then index = index == 'content' and 7 or 2 end
	local prev_tag = screen.primary.selected_tag
	activate_tag(index or 2)
	activate_tag(prev_tag)
end

function MoveVideoPopout(client, x, y, width, height)
	local client = client or client.focus
	local x = x or 0
	local y = y or 0
	local width = width or 1
	local height = height or 1
	client.floating = true
	client.ontop = true
	client.sticky = true
	client.x = x
	client.y = y
	client.width = width
	client.height = height
end

function MoveWindowToTag(index)
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
	local tag = tag or awful.tag.selected(screen.primary)
	for _, client in ipairs(tag:clients()) do
		if client.minimized then client.minimized = false end
	end
end

function WriteClientInfo()
	local text = ''
	for _, client in ipairs(client.get()) do
		if client.instance then
			text = text .. ':' .. client.instance .. ': '
		else
			text = text .. '??? '
		end
		if client.class then
			text = text .. ',' .. client.class .. ', '
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
	local file = io.open('/home/axlefublr/.local/share/magazine/o', 'w')
	if file then
		file:write(text)
		file:close()
	end
end

-- Buttons
root.buttons(gears.table.join(awful.button({}, 3, function() Menu_w:toggle() end)))

ClientButtons = gears.table.join(
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
	awful.key(
		{},
		'#174',
		function() -- #174 is the key code for “media stop” on my keyboard, which is what a button on my mouse is remapped to
			awful.spawn.easy_async_with_shell('pidof boomer && kill boomer || boomer', function() end)
		end
	),
	awful.key({}, '#208', function()
		awful.spawn.easy_async_with_shell('toggle_media', function() end)
	end),

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
	awful.key({ modkey, 'Control' }, 'u', function() MoveWindowToTag(1) end),
	awful.key({ modkey, 'Control' }, 'i', function() MoveWindowToTag(2) end),
	awful.key({ modkey, 'Control' }, 'o', function() MoveWindowToTag(3) end),
	awful.key({ modkey, 'Control' }, 'p', function() MoveWindowToTag(4) end),
	awful.key({ modkey, 'Control' }, 'm', function() MoveWindowToTag(5) end),
	awful.key({ modkey, 'Control' }, ',', function() MoveWindowToTag(6) end),
	awful.key({ modkey, 'Control' }, '.', function() MoveWindowToTag(7) end),
	awful.key({ modkey, 'Control' }, '/', function() MoveWindowToTag(8) end),
	awful.key({ modkey, 'Control', 'Mod1' }, 'u', function() MoveWindowToTag(9) end),
	awful.key({ modkey, 'Control', 'Mod1' }, 'i', function() MoveWindowToTag(10) end),
	awful.key({ modkey, 'Control', 'Mod1' }, 'o', function() MoveWindowToTag(11) end),
	awful.key({ modkey, 'Control', 'Mod1' }, 'p', function() MoveWindowToTag(12) end),
	awful.key({ modkey, 'Control', 'Mod1' }, 'm', function() MoveWindowToTag(13) end),
	awful.key({ modkey, 'Control', 'Mod1' }, ',', function() MoveWindowToTag(14) end),
	awful.key({ modkey, 'Control', 'Mod1' }, '.', function() MoveWindowToTag(15) end),
	awful.key({ modkey, 'Control', 'Mod1' }, '/', function() MoveWindowToTag(16) end),
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

ClientKeys = gears.table.join(awful.key({ modkey, 'Shift' }, 'w', function(client)
	local current_tag = screen.primary.selected_tag
	if current_tag then
		for _, other_client in ipairs(current_tag:clients()) do
			if other_client ~= client then other_client:kill() end
		end
	end
end))
