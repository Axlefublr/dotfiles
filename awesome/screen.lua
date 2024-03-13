Between_margin = 15

My_main_menu = awful.menu({
	items = {
		{ 'restart',  awesome.restart },
		{ 'quit',     function() awesome.quit() end },
		{ 'terminal', terminal },
	},
})

Text_clock_widget = wibox.widget.textclock(' %A %y.%m.%d %H:%M:%S ', 1)
Text_clock_widget.font = beautiful.code_font

Loago_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = 'Comfortaa 13',
})
Loago_margin_widget = wibox.container.margin(Loago_widget)

function Widget_update_loago()
	awful.spawn.easy_async_with_shell(
		'get_oldest_task',
		function(stdout) Loago_widget:set_text(stdout) end
	)
end

Clients_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.jetbrains_font .. ' 14',
})
Clients_background_widget = wibox.container.background(Clients_widget)
Clients_margin_widget = wibox.container.margin(Clients_background_widget)
function Widget_update_clients(tag)
	local clients = tag:clients()

	if #clients == 0 then
		Widget_disable_clients()
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
		Widget_disable_clients()
		return
	end

	Clients_widget:set_text(text)
	Clients_margin_widget.right = Between_margin
end

function Widget_disable_clients()
	Clients_widget:set_text('')
	Clients_margin_widget.right = 0
end

Mic_muteness_widget = wibox.widget({
	text = ' ',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Mic_muteness_background_widget = wibox.container.background(Mic_muteness_widget)
Mic_muteness_margin_widget = wibox.container.margin(Mic_muteness_background_widget)
Mic_muteness_margin_widget.right = -6
function Widget_update_mic_muteness()
	awful.spawn.easy_async_with_shell('get_mic_mute', function(stdout)
		local output = Trim_newlines(stdout)
		if output == 'yes' then
			Mic_muteness_background_widget.fg = beautiful.red
		elseif output == 'no' then
			Mic_muteness_background_widget.fg = beautiful.white
		end
	end)
end

Mic_volume_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
function Widget_update_mic_volume()
	awful.spawn.easy_async_with_shell('get_mic_volume', function(stdout)
		local output = Trim_newlines(stdout)
		Mic_volume_widget:set_text(output)
	end)
end

Muteness_widget = wibox.widget({
	text = ' ',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Muteness_background_widget = wibox.container.background(Muteness_widget)
Muteness_margin_widget = wibox.container.margin(Muteness_background_widget)
Muteness_margin_widget.left = Between_margin - 2
function Widget_update_muteness()
	awful.spawn.easy_async_with_shell('get_mute', function(stdout)
		local output = Trim_newlines(stdout)
		if output == 'yes' then
			Muteness_background_widget.fg = beautiful.red
		elseif output == 'no' then
			Muteness_background_widget.fg = beautiful.white
		end
	end)
end

Volume_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Volume_margin_widget = wibox.container.margin(Volume_widget)
function Widget_update_volume()
	awful.spawn.easy_async_with_shell('get_volume', function(stdout)
		local output = Trim_newlines(stdout)
		if #output > 0 then
			Volume_margin_widget.right = Between_margin
		else
			Volume_margin_widget.right = 0
		end
		Volume_widget:set_text(output)
	end)
end

Media_state_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.jetbrains_font .. ' 15',
})
Media_state_margin_widget = wibox.container.margin(Media_state_widget)
Media_state_margin_widget.left = Between_margin
Media_state_margin_widget.right = -5
function Widget_update_media_state()
	awful.spawn.easy_async_with_shell('media_state', function(stdout)
		local output = Trim_newlines(stdout)
		if output == 'Paused' then
			Media_state_widget:set_text('󰏤')
		elseif output == 'Playing' then
			Media_state_widget:set_text('󰐊')
		elseif output == 'Stopped' then
			Media_state_widget:set_text('󰓛')
		else
			Media_state_widget:set_text(output) -- in case there are more statuses I don't know of
		end
	end)
end

Media_volume_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Media_volume_margin_widget = wibox.container.margin(Media_volume_widget)
Media_volume_margin_widget.left = Between_margin - 4
Media_volume_margin_widget.right = Between_margin
function Widget_update_media_volume()
	awful.spawn.easy_async_with_shell('get_media_volume', function(stdout)
		local output = Trim_newlines(stdout)
		Media_volume_widget:set_text(output)
	end)
end

Bluetooth_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Bluetooth_background_widget = wibox.container.background(Bluetooth_widget)
Bluetooth_margin_widget = wibox.container.margin(Bluetooth_background_widget)
function Widget_update_bluetooth()
	awful.spawn.easy_async_with_shell('get_bluetooth', function(stdout)
		local output = Trim_newlines(stdout)
		if output == 'yes' then
			Bluetooth_widget:set_text('')
			Bluetooth_margin_widget.right = Between_margin - 1
			awful.spawn.easy_async_with_shell('get_bluetooth_connected', function(is_connected)
				if #is_connected > 0 then
					Bluetooth_background_widget.fg = beautiful.cyan
				else
					Bluetooth_background_widget.fg = beautiful.white
				end
			end)
		elseif output == 'no' then
			Bluetooth_widget:set_text('')
			Bluetooth_margin_widget.right = 0
			Bluetooth_background_widget.fg = beautiful.white
		end
	end)
end

Wifi_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Wifi_background_widget = wibox.container.background(Wifi_widget)
Wifi_margin_widget = wibox.container.margin(Wifi_background_widget)
function Widget_disable_wifi()
	Wifi_margin_widget.right = 0
	Wifi_widget:set_text('')
end

function Widget_enable_wifi()
	Wifi_margin_widget.right = Between_margin - 8
	Wifi_widget:set_text('󰖩 ')
end

function Widget_update_wifi()
	awful.spawn.easy_async_with_shell('get_internet', function(stdout)
		local is_internet = Trim_newlines(stdout)
		if is_internet == 'disabled' then
			Widget_disable_wifi()
			return
		end
		Widget_enable_wifi()
		awful.spawn.easy_async_with_shell('get_internet_connection', function(_connection_strength)
			local connection_strength = Trim_newlines(_connection_strength)
			if connection_strength == 'none' then
				Wifi_background_widget.fg = beautiful.red
			elseif connection_strength == 'limited' then
				Wifi_background_widget.fg = beautiful.yellow
			elseif connection_strength == 'full' then
				Wifi_background_widget.fg = beautiful.white
			end
		end)
	end)
end

Compositor_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Compositor_background_widget = wibox.container.background(Compositor_widget)
Compositor_margin_widget = wibox.container.margin(Compositor_background_widget)
function Widget_disable_compositor()
	Compositor_margin_widget.right = 0
	Compositor_widget:set_text('󱕅 ')
end

function Widget_enable_compositor()
	Compositor_margin_widget.right = 0
	Compositor_widget:set_text('')
end

function Widget_update_compositor()
	awful.spawn.easy_async_with_shell('pidof picom', function(stdout)
		local is_picom = Trim_newlines(stdout)
		if #is_picom > 0 then
			Widget_enable_compositor()
		else
			Widget_disable_compositor()
		end
	end)
end

Dnd_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Dnd_margin_widget = wibox.container.margin(Dnd_widget)
function Widget_enable_dnd()
	Dnd_margin_widget.right = 4
	Dnd_widget:set_text(' ')
end

function Widget_disable_dnd()
	Dnd_margin_widget.right = 0
	Dnd_widget:set_text('')
end

function Widget_update_dnd()
	if naughty.is_suspended() then
		Widget_enable_dnd()
	else
		Widget_disable_dnd()
	end
end

Meat_widget = wibox.widget({
	text = ' ',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Meat_margin_widget = wibox.container.margin(Meat_widget)
Meat_margin_widget.right = 0

Hunger_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Hunger_margin_widget = wibox.container.margin(Hunger_widget)
Hunger_margin_widget.right = Between_margin

function Widget_update_hunger()
	awful.spawn.easy_async_with_shell(
		'get_hunger',
		function(stdout) Hunger_widget:set_text(stdout) end
	)
end

Water_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Water_background_widget = wibox.container.background(Water_widget)
Water_margin_widget = wibox.container.margin(Water_background_widget)
function Widget_enable_water()
	Water_margin_widget.right = -4
	Water_widget:set_text('󰖌 ')
end

function Widget_disable_water()
	Water_margin_widget.right = 0
	Water_widget:set_text('')
end

Media_note_widget = wibox.widget({
	text = '󰝚 ',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Media_note_margin_widget = wibox.container.margin(Media_note_widget)
Media_note_margin_widget.left = Between_margin + 3
Media_note_margin_widget.right = -2

Media_time_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Media_time_margin_widget = wibox.container.margin(Media_time_widget)
function Widget_update_media_time()
	awful.spawn.easy_async_with_shell('get_media_time', function(output)
		local media_time = Trim_newlines(output)
		Media_time_widget:set_text(media_time)
	end)
end

Malumn_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.jetbrains_font .. ' 14',
})
Malumn_margin_widget = wibox.container.margin(Malumn_widget)
Malumn_margin_widget.right = Between_margin
function Widget_update_malumn(tag)
	Malumn_widget:set_text(tag.master_count .. '/' .. tag.column_count)
end

function Widget_disable_malumn() Malumn_widget:set_text('?/?') end

Note_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = 'Comfortaa' .. beautiful.font_size,
})
Note_margin_widget = wibox.container.margin(Note_widget)
function Widget_update_note()
	awful.spawn.easy_async_with_shell('cat ~/.local/share/notie', function(stdout)
		local note = Trim_newlines(stdout)
		if #note == 0 then
			Note_margin_widget.right = 0
			Note_margin_widget.left = 0
		else
			Note_margin_widget.right = Between_margin
			Note_margin_widget.left = Between_margin
		end
		Note_widget:set_text(note)
	end)
end

Ontop_state_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Ontop_state_background_widget = wibox.container.background(Ontop_state_widget)
Ontop_state_background_widget.fg = beautiful.red
Ontop_state_margin_widget = wibox.container.margin(Ontop_state_background_widget)
function Widget_update_ontop(client)
	if client.ontop then
		Ontop_state_margin_widget.right = 6
		Ontop_state_widget:set_text(' ')
	else
		Ontop_state_margin_widget.right = 0
		Ontop_state_widget:set_text('')
	end
end

Maximized_state_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Maximized_state_background_widget = wibox.container.background(Maximized_state_widget)
Maximized_state_background_widget.fg = beautiful.yellow
Maximized_state_margin_widget = wibox.container.margin(Maximized_state_background_widget)
function Widget_update_maximized(client)
	if client.maximized then
		Maximized_state_margin_widget.right = 2
		Maximized_state_widget:set_text(' ')
	else
		Maximized_state_margin_widget.right = 0
		Maximized_state_widget:set_text('')
	end
end

Sticky_state_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Sticky_state_background_widget = wibox.container.background(Sticky_state_widget)
Sticky_state_background_widget.fg = beautiful.green
Sticky_state_margin_widget = wibox.container.margin(Sticky_state_background_widget)
function Widget_update_sticky(client)
	if client.sticky then
		Sticky_state_margin_widget.right = 3
		Sticky_state_widget:set_text('󰹧 ')
	else
		Sticky_state_margin_widget.right = 0
		Sticky_state_widget:set_text('')
	end
end

Floating_state_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.code_font,
})
Floating_state_background_widget = wibox.container.background(Floating_state_widget)
Floating_state_background_widget.fg = beautiful.cyan
Floating_state_margin_widget = wibox.container.margin(Floating_state_background_widget)
function Widget_update_floating(client)
	if client.floating then
		Floating_state_margin_widget.right = 4
		Floating_state_widget:set_text(' ')
	else
		Floating_state_margin_widget.right = 0
		Floating_state_widget:set_text('')
	end
end

Window_state_layout_widget = wibox.widget({
	Ontop_state_margin_widget,
	Maximized_state_margin_widget,
	Sticky_state_margin_widget,
	Floating_state_margin_widget,
	layout = wibox.layout.fixed.horizontal,
})

Tile_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.jetbrains_font .. ' 14',
})
Tile_margin_widget = wibox.container.margin(Tile_widget)
Tile_margin_widget.right = Between_margin
function Widget_update_tile(tag)
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
	Tile_widget:set_text(layout_name)
end

Layout_widget = wibox.widget({
	text = '',
	widget = wibox.widget.textbox,
	font = beautiful.jetbrains_font .. ' 14',
})
Layout_background_widget = wibox.container.background(Layout_widget)
Layout_margin_widget = wibox.container.margin(Layout_background_widget)
Layout_margin_widget.right = Between_margin
function Widget_update_layout()
	awful.spawn.easy_async_with_shell('get_layout', function(stdout)
		local layout = Trim_newlines(stdout)
		if layout == 'English' then
			layout = 'eng'
		elseif layout == 'Russian' then
			layout = 'rus'
		end
		awful.spawn.easy_async_with_shell('get_capslock', function(output)
			local capslock = Trim_newlines(output)
			if capslock == 'on' then
				Layout_background_widget.fg = beautiful.yellow
				Layout_widget:set_text(layout:upper())
			else
				Layout_background_widget.fg = beautiful.white
				Layout_widget:set_text(layout:lower())
			end
		end)
	end)
end

Taglist_buttons = gears.table.join(
	awful.button({}, 1, function(tag) tag:view_only() end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({}, 5, function(tag) awful.tag.viewnext(tag.screen) end),
	awful.button({}, 4, function(tag) awful.tag.viewprev(tag.screen) end)
)

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

require('tags')

screen.primary.layout_box_widget = awful.widget.layoutbox(screen.primary)
screen.primary.layout_box_widget:buttons(
	gears.table.join(
		awful.button({}, 1, function() awful.layout.inc(1) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc(1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)
	)
)

screen.primary.tag_list_widget = awful.widget.taglist({
	screen = screen.primary,
	filter = awful.widget.taglist.filter.noempty,
	buttons = Taglist_buttons,
})
screen.primary.tag_list_margin_widget = wibox.container.margin(screen.primary.tag_list_widget)
screen.primary.tag_list_margin_widget.right = Between_margin - 6

local wibar_height = 35
local wibar_bg = beautiful.background
screen.primary.wibox_widget = awful.wibar({
	position = 'top',
	screen = screen.primary,
	height = wibar_height,
	bg = wibar_bg,
})

-- awgts (All widgets)
screen.primary.wibox_widget:setup({
	layout = wibox.layout.align.horizontal,
	expand = 'none',
	-- Left widgets
	{
		layout = wibox.layout.fixed.horizontal,
		-- screen.primary.layout_box_widget,
		Text_clock_widget,
		screen.primary.tag_list_margin_widget,
		Loago_margin_widget,
	},
	Note_margin_widget,
	-- Right widgets
	{
		layout = wibox.layout.fixed.horizontal,
		-- awful.widget.tasklist(),
		-- wibox.widget.systray(),
		Media_note_margin_widget,
		Media_time_margin_widget,
		Media_state_margin_widget,
		Media_volume_margin_widget,
		Meat_margin_widget,
		Hunger_margin_widget,
		Window_state_layout_widget,
		Clients_margin_widget,
		Mic_muteness_margin_widget,
		Mic_volume_widget,
		Muteness_margin_widget,
		Volume_margin_widget,
		Tile_margin_widget,
		Malumn_margin_widget,
		Compositor_margin_widget,
		Water_margin_widget,
		Dnd_margin_widget,
		Bluetooth_margin_widget,
		Wifi_margin_widget,
		Layout_margin_widget,
	},
})

local frequent_updaters = {
	Widget_update_layout,
	Widget_update_compositor,
	Widget_update_bluetooth,
	Widget_update_wifi,
	Widget_update_media_time,
	Widget_update_media_state,
	Widget_update_media_volume,
	Widget_update_mic_muteness,
	Widget_update_mic_volume,
	Widget_update_volume,
	Widget_update_muteness,
}

Frequent_counter = 0
local frequent = function()
	Frequent_counter = Frequent_counter + 1
	frequent_updaters[Frequent_counter]()
	if Frequent_counter >= #frequent_updaters then Frequent_counter = 0 end
	return true
end
gears.timer.start_new(0.15, frequent)

local run_once = function()
	Widget_update_hunger()
	Widget_update_loago()
	Widget_update_note()
	Widget_update_malumn(screen.primary.selected_tag)
	Widget_update_dnd()
	Widget_update_tile(screen.primary.selected_tag)
	return false
end
gears.timer.start_new(0, run_once)
gears.timer.start_new(20, run_once)
