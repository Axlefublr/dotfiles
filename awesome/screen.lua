require('tags')

function Set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == 'function' then wallpaper = wallpaper(s) end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

Set_wallpaper(screen.primary)

local between = 14
local larger = between * 1.4

local function text_widget(font, initial)
	return wibox.widget({
		text = initial or '',
		widget = wibox.widget.textbox,
		font = font or beautiful.code_font,
	})
end

Menu_w = awful.menu({
	items = {
		{ 'restart',  awesome.restart },
		{ 'quit',     function() awesome.quit() end },
		{ 'terminal', terminal },
	},
})

Clock_w = wibox.widget.textclock('%A %y.%m.%d %H:%M:%S', 1)
Clock_w.font = beautiful.code_font
Clock_mw = wibox.container.margin(Clock_w)
Clock_mw.left = between
Clock_mw.right = between

Loago_w = text_widget('Comfortaa 13')
Loago_mw = wibox.container.margin(Loago_w)
function Loago_wu()
	awful.spawn.easy_async_with_shell(
		'get_oldest_task',
		function(stdout) Loago_w:set_text(stdout) end
	)
end

Anki_w = text_widget()
Anki_bw = wibox.container.background(Anki_w)
Anki_bw.fg = beautiful.red
Anki_mw = wibox.container.margin(Anki_bw)
Anki_mw.right = between
Anki_mw.visible = false
function Anki_wu()
	local file = io.open('/dev/shm/Anki_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 and text ~= '0' then
			Anki_mw.visible = true
			Anki_w:set_text(text)
		else
			Anki_mw.visible = false
		end
	end
end

Clients_w = text_widget(beautiful.jetbrains_font .. ' 14')
Clients_bw = wibox.container.background(Clients_w)
Clients_mw = wibox.container.margin(Clients_bw)
Clients_mw.right = between
function Clients_wu(tag)
	local clients = tag:clients()

	if #clients == 0 then
		Clients_mw.visible = false
		return
	end

	local text = ''
	for _, client in ipairs(clients) do
		if client.class then
			local truncation = client.class:sub(1, 1)
			text = text .. truncation
		else
			text = text .. '?'
		end
	end

	if text == '' then
		Clients_mw.visible = false
		return
	else
		Clients_mw.visible = true
		Clients_w:set_text(text)
	end
end

Mic_muteness_w = text_widget(nil, ' ')
Mic_muteness_bw = wibox.container.background(Mic_muteness_w)
Mic_muteness_mw = wibox.container.margin(Mic_muteness_bw)
Mic_muteness_mw.right = -6
function Mic_muteness_wu()
	awful.spawn.easy_async_with_shell('get_mic_mute', function(stdout)
		local muteness = Trim_newlines(stdout)
		if muteness == 'yes' then
			Mic_muteness_bw.fg = beautiful.red
		elseif muteness == 'no' then
			Mic_muteness_bw.fg = beautiful.white
		end
	end)
end

Mic_volume_w = text_widget()
Mic_volume_mw = wibox.container.margin(Mic_volume_w)
Mic_volume_mw.right = larger - 2
Mic_volume_mw.visible = false
function Mic_volume_wu()
	local file = io.open('/dev/shm/Mic_volume_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Mic_volume_mw.visible = true
			Mic_volume_w:set_text(text)
		else
			Mic_volume_mw.visible = false
		end
	end
end

Muteness_w = text_widget(nil, ' ')
Muteness_bw = wibox.container.background(Muteness_w)
Muteness_mw = wibox.container.margin(Muteness_bw)
function Muteness_wu()
	awful.spawn.easy_async_with_shell('get_mute', function(stdout)
		local muteness = Trim_newlines(stdout)
		if muteness == 'yes' then
			Muteness_bw.fg = beautiful.red
		elseif muteness == 'no' then
			Muteness_bw.fg = beautiful.white
		end
	end)
end

Volume_w = text_widget()
Volume_mw = wibox.container.margin(Volume_w)
Volume_mw.right = between
Volume_mw.visible = false
function Volume_wu()
	local file = io.open('/dev/shm/Volume_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Volume_mw.visible = true
			Volume_w:set_text(text)
		else
			Volume_mw.visible = false
		end
	end
end

Bluetooth_w = text_widget(nil, '')
Bluetooth_bw = wibox.container.background(Bluetooth_w)
Bluetooth_mw = wibox.container.margin(Bluetooth_bw)
Bluetooth_mw.right = between - 1
Bluetooth_mw.visible = false
function Bluetooth_wu()
	local file = io.open('/dev/shm/Bluetooth_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Bluetooth_mw.visible = true
			if text == 'connected' then
				Bluetooth_bw.fg = beautiful.cyan
			else
				Bluetooth_bw.fg = beautiful.white
			end
		else
			Bluetooth_mw.visible = false
		end
	end
end

Wifi_w = text_widget(nil, '󰖩 ')
Wifi_bw = wibox.container.background(Wifi_w)
Wifi_mw = wibox.container.margin(Wifi_bw)
Wifi_mw.right = between - 8
Wifi_mw.visible = false
function Wifi_wu()
	local file = io.open('/dev/shm/Wifi_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Wifi_mw.visible = true
			if text == 'none' then
				Wifi_bw.fg = beautiful.red
			elseif text == 'limited' then
				Wifi_bw.fg = beautiful.yellow
			elseif text == 'full' then
				Wifi_bw.fg = beautiful.white
			end
		else
			Wifi_mw.visible = false
		end
	end
end

Compositor_w = text_widget(nil, '󱕅 ')
Compositor_bw = wibox.container.background(Compositor_w)
Compositor_mw = wibox.container.margin(Compositor_bw)
Compositor_mw.right = between - 13
Compositor_mw.visible = false
function Compositor_wu()
	local file = io.open('/dev/shm/Compositor_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Compositor_mw.visible = true
		else
			Compositor_mw.visible = false
		end
	end
end

Dnd_w = text_widget(nil, ' ')
Dnd_mw = wibox.container.margin(Dnd_w)
Dnd_mw.right = between - 6
function Dnd_wu()
	if naughty.is_suspended() then
		Dnd_mw.visible = true
	else
		Dnd_mw.visible = false
	end
end

Meat_w = text_widget(nil, ' ')
Meat_mw = wibox.container.margin(Meat_w)

Hunger_w = text_widget()
Hunger_mw = wibox.container.margin(Hunger_w)
Hunger_mw.right = larger
function Hunger_wu()
	awful.spawn.easy_async_with_shell('get_hunger', function(stdout)
		local time = Trim_newlines(stdout)
		if #time > 0 then
			Hunger_mw.visible = true
			Hunger_w:set_text(time)
		else
			Hunger_mw.visible = false
		end
	end)
end

Water_w = text_widget(nil, '󰖌 ')
Water_bw = wibox.container.background(Water_w)
Water_mw = wibox.container.margin(Water_bw)
Water_mw.right = between - 16
Water_mw.visible = false
function Water_we() Water_mw.visible = true end

function Water_wd() Water_mw.visible = false end

Media_player_w = text_widget(nil, '󰝚 ')
Media_player_mw = wibox.container.margin(Media_player_w)
Media_player_mw.right = -2
Media_player_mw.visible = false
function Media_player_wu()
	local file = io.open('/dev/shm/Media_player_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Media_player_mw.visible = true
			Media_player_w:set_text(text .. ' ')
		else
			Media_player_mw.visible = false
		end
	end
end

Media_time_w = text_widget()
Media_time_mw = wibox.container.margin(Media_time_w)
Media_time_mw.right = larger
Media_time_mw.visible = false
function Media_time_wu()
	local file = io.open('/dev/shm/Media_time_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Media_time_mw.visible = true
			Media_time_w:set_text(text)
		else
			Media_time_mw.visible = false
		end
	end
end

Media_state_w = text_widget(beautiful.jetbrains_font .. ' 15')
Media_state_mw = wibox.container.margin(Media_state_w)
Media_state_mw.right = 6
Media_state_mw.visible = false
function Media_state_wu()
	local file = io.open('/dev/shm/Media_state_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Media_state_mw.visible = true
			Media_state_w:set_text(text)
		else
			Media_player_mw.visible = false
		end
	end
end

Media_volume_w = text_widget()
Media_volume_mw = wibox.container.margin(Media_volume_w)
Media_volume_mw.right = larger
Media_volume_mw.visible = false
function Media_volume_wu()
	local file = io.open('/dev/shm/Media_volume_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Media_volume_mw.visible = true
			Media_volume_w:set_text(text)
		else
			Media_volume_mw.visible = false
		end
	end
end

Malumn_w = text_widget()
Malumn_mw = wibox.container.margin(Malumn_w)
Malumn_mw.right = between
function Malumn_wu(tag) Malumn_w:set_text(tag.master_count .. '/' .. tag.column_count) end

function Malumn_wd() Malumn_w:set_text('?/?') end

Brain_w = text_widget(beautiful.jetbrains_font .. ' 14', ' ')
Brain_mw = wibox.container.margin(Brain_w)
Brain_mw.right = -6
Brain_mw.visible = false

Ram_w = text_widget()
Ram_mw = wibox.container.margin(Ram_w)
Ram_mw.right = larger
Ram_mw.visible = false
function Ram_wu()
	local file = io.open('/dev/shm/Ram_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Ram_mw.visible = true
			Brain_mw.visible = true
			Ram_w:set_text(text)
		else
			Ram_mw.visible = false
			Brain_mw.visible = false
		end
	end
end

Fire_w = text_widget(beautiful.jetbrains_font .. ' 15', '󰈸 ')
Fire_mw = wibox.container.margin(Fire_w)
Fire_mw.right = -10
Fire_mw.visible = false

Processor_w = text_widget()
Processor_mw = wibox.container.margin(Processor_w)
Processor_mw.right = larger
Processor_mw.visible = false
function Processor_wu()
	local file = io.open('/dev/shm/Processor_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Processor_mw.visible = true
			Fire_mw.visible = true
			Processor_w:set_text(text)
		else
			Processor_mw.visible = false
			Fire_mw.visible = false
		end
	end
end

Note_w = text_widget('Comfortaa' .. beautiful.font_size)
Note_mw = wibox.container.margin(Note_w)
Note_mw.right = between
Note_mw.left = between
Note_mw.visible = false
function Note_wu()
	awful.spawn.easy_async_with_shell('cat ~/.local/share/notie | string trim', function(note)
		if #note == 0 then
			Note_mw.visible = false
		else
			Note_mw.visible = true
			Note_w:set_text(note)
		end
	end)
end

Ontop_state_w = text_widget(nil, ' ')
Ontop_state_bw = wibox.container.background(Ontop_state_w)
Ontop_state_bw.fg = beautiful.red
Ontop_state_mw = wibox.container.margin(Ontop_state_bw)
Ontop_state_mw.right = 6
Ontop_state_mw.visible = false
function Ontop_state_wu(client)
	if client.ontop then
		Ontop_state_mw.visible = true
	else
		Ontop_state_mw.visible = false
	end
end

Maximized_state_w = text_widget(nil, ' ')
Maximized_state_bw = wibox.container.background(Maximized_state_w)
Maximized_state_bw.fg = beautiful.yellow
Maximized_state_mw = wibox.container.margin(Maximized_state_bw)
Maximized_state_mw.right = 4
Maximized_state_mw.visible = false
function Maximized_state_wu(client)
	if client.maximized then
		Maximized_state_mw.visible = true
	else
		Maximized_state_mw.visible = false
	end
end

Sticky_state_w = text_widget(nil, '󰹧 ')
Sticky_state_bw = wibox.container.background(Sticky_state_w)
Sticky_state_bw.fg = beautiful.green
Sticky_state_mw = wibox.container.margin(Sticky_state_bw)
Sticky_state_mw.right = 3
Sticky_state_mw.visible = false
function Sticky_state_wu(client)
	if client.sticky then
		Sticky_state_mw.visible = true
	else
		Sticky_state_mw.visible = false
	end
end

Floating_state_w = text_widget(nil, ' ')
Floating_state_bw = wibox.container.background(Floating_state_w)
Floating_state_bw.fg = beautiful.cyan
Floating_state_mw = wibox.container.margin(Floating_state_bw)
Floating_state_mw.right = 6
Floating_state_mw.visible = false
function Floating_state_wu(client)
	if client.floating then
		Floating_state_mw.visible = true
	else
		Floating_state_mw.visible = false
	end
end

Window_state_lw = wibox.widget({
	Ontop_state_mw,
	Maximized_state_mw,
	Sticky_state_mw,
	Floating_state_mw,
	layout = wibox.layout.fixed.horizontal,
})

Tile_w = text_widget(beautiful.jetbrains_font .. ' 14')
Tile_mw = wibox.container.margin(Tile_w)
Tile_mw.right = between
function Tile_wu(tag)
	local layout_name = tag.layout.name
	if layout_name == 'tile' then
		layout_name = 'right'
	elseif layout_name == 'tileleft' then
		layout_name = 'left'
	elseif layout_name == 'tilebottom' then
		layout_name = 'bottom'
	elseif layout_name == 'tiletop' then
		layout_name = 'top'
	elseif layout_name == 'cornernw' then
		layout_name = 'left-top'
	elseif layout_name == 'cornerne' then
		layout_name = 'right-top'
	elseif layout_name == 'cornersw' then
		layout_name = 'left-bottom'
	elseif layout_name == 'cornerse' then
		layout_name = 'right-bottom'
	elseif layout_name == 'fairv' then
		layout_name = 'vert'
	elseif layout_name == 'fairh' then
		layout_name = 'hori'
	end
	Tile_w:set_text(layout_name)
end

Layout_w = text_widget(beautiful.jetbrains_font .. ' 14')
Layout_bw = wibox.container.background(Layout_w)
Layout_mw = wibox.container.margin(Layout_bw)
Layout_mw.right = between
Layout_mw.visible = false
function Layout_wu()
	local file = io.open('/dev/shm/Layout_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Layout_mw.visible = true
			if text == string.upper(text) then
				Layout_bw.fg = beautiful.yellow
			else
				Layout_bw.fg = beautiful.white
			end
			Layout_w:set_text(text)
		else
			Layout_mw.visible = false
		end
	end
end

screen.primary.layout_box_widget = awful.widget.layoutbox(screen.primary)
screen.primary.layout_box_widget:buttons(
	gears.table.join(
		awful.button({}, 1, function() awful.layout.inc(1) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc(1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)
	)
)

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(tag) tag:view_only() end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({}, 5, function(tag) awful.tag.viewnext(tag.screen) end),
	awful.button({}, 4, function(tag) awful.tag.viewprev(tag.screen) end)
)

Taglist_w = awful.widget.taglist({
	screen = screen.primary,
	filter = awful.widget.taglist.filter.noempty,
	buttons = taglist_buttons,
})
Taglist_mw = wibox.container.margin(Taglist_w)
Taglist_mw.right = between - 6

local wibar_height = 35
local wibar_bg = beautiful.background
Wibar_w = awful.wibar({
	position = 'top',
	screen = screen.primary,
	height = wibar_height,
	bg = wibar_bg,
})

Wibar_w:setup({
	layout = wibox.layout.align.horizontal,
	expand = 'inside',
	-- Left widgets
	{
		layout = wibox.layout.fixed.horizontal,
		-- screen.primary.layout_box_widget,
		Clock_mw,
		Taglist_mw,
		Loago_mw,
	},
	Note_mw,
	-- Right widgets
	{
		layout = wibox.layout.fixed.horizontal,
		-- awful.widget.tasklist(),
		-- wibox.widget.systray(),
		Brain_mw,
		Ram_mw,
		Fire_mw,
		Processor_mw,
		Media_player_mw,
		Media_time_mw,
		Media_state_mw,
		Media_volume_mw,
		Meat_mw,
		Hunger_mw,
		Mic_muteness_mw,
		Mic_volume_mw,
		Muteness_mw,
		Volume_mw,
		Tile_mw,
		Malumn_mw,
		Window_state_lw,
		Clients_mw,
		Water_mw,
		Anki_mw,
		Compositor_mw,
		Dnd_mw,
		Bluetooth_mw,
		Wifi_mw,
		Layout_mw,
	},
})

local run_once = function()
	local frequents = {
		'Layout',
		'Media_time',
		'Media_state',
		'Media_volume',
		'Mic_volume',
		'Volume',
		'Wifi',
		'Bluetooth',
		'Compositor',
		'Anki',
		'Processor',
		'Ram',
	}
	for _, frequent_ in ipairs(frequents) do
		local file = io.open('/dev/shm/' .. frequent_ .. '_f', 'w')
		if file then file:close() end
	end
	Hunger_wu()
	Loago_wu()
	Note_wu()
	Malumn_wu(screen.primary.selected_tag)
	Dnd_wu()
	Tile_wu(screen.primary.selected_tag)
	return false
end
gears.timer.start_new(0, run_once)
