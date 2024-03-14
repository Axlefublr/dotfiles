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

Clients_w = text_widget(beautiful.jetbrains_font .. ' 14')
Clients_bw = wibox.container.background(Clients_w)
Clients_mw = wibox.container.margin(Clients_bw)
function Clients_wu(tag)
	local clients = tag:clients()

	if #clients == 0 then
		Clients_wd()
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
		Clients_wd()
		return
	end

	Clients_w:set_text(text)
	Clients_mw.right = between
end

function Clients_wd()
	Clients_w:set_text('')
	Clients_mw.right = 0
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
function Mic_volume_wu()
	awful.spawn.easy_async_with_shell('get_mic_volume', function(stdout)
		local volume = Trim_newlines(stdout)
		if #volume > 0 then
			Mic_volume_mw.right = larger - 2
		else
			Mic_volume_mw.right = 0
		end
		Mic_volume_w:set_text(volume)
	end)
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
function Volume_wu()
	awful.spawn.easy_async_with_shell('get_volume', function(stdout)
		local volume = Trim_newlines(stdout)
		if #volume > 0 then
			Volume_mw.right = between
		else
			Volume_mw.right = 0
		end
		Volume_w:set_text(volume)
	end)
end

Bluetooth_w = text_widget()
Bluetooth_bw = wibox.container.background(Bluetooth_w)
Bluetooth_mw = wibox.container.margin(Bluetooth_bw)
function Bluetooth_wu()
	awful.spawn.easy_async_with_shell('get_bluetooth', function(stdout)
		local is_on = Trim_newlines(stdout)
		if is_on == 'yes' then
			Bluetooth_w:set_text('')
			Bluetooth_mw.right = between - 1
			awful.spawn.easy_async_with_shell('get_bluetooth_connected', function(is_connected)
				if #is_connected > 0 then
					Bluetooth_bw.fg = beautiful.cyan
				else
					Bluetooth_bw.fg = beautiful.white
				end
			end)
		elseif is_on == 'no' then
			Bluetooth_w:set_text('')
			Bluetooth_mw.right = 0
		end
	end)
end

Wifi_w = text_widget()
Wifi_bw = wibox.container.background(Wifi_w)
Wifi_mw = wibox.container.margin(Wifi_bw)
function Wifi_wu()
	awful.spawn.easy_async_with_shell('get_internet', function(stdout)
		local is_internet = Trim_newlines(stdout)
		if is_internet == 'disabled' then
			Wifi_wd()
			return
		end
		Wifi_we()
		awful.spawn.easy_async_with_shell('get_internet_connection', function(_connection_strength)
			local connection_strength = Trim_newlines(_connection_strength)
			if connection_strength == 'none' then
				Wifi_bw.fg = beautiful.red
			elseif connection_strength == 'limited' then
				Wifi_bw.fg = beautiful.yellow
			elseif connection_strength == 'full' then
				Wifi_bw.fg = beautiful.white
			end
		end)
	end)
end

function Wifi_wd()
	Wifi_mw.right = 0
	Wifi_w:set_text('')
end

function Wifi_we()
	Wifi_mw.right = between - 8
	Wifi_w:set_text('󰖩 ')
end

Compositor_w = text_widget()
Compositor_bw = wibox.container.background(Compositor_w)
Compositor_mw = wibox.container.margin(Compositor_bw)
function Compositor_wu()
	awful.spawn.easy_async_with_shell('pidof picom', function(stdout)
		local is_picom = Trim_newlines(stdout)
		if #is_picom > 0 then
			Compositor_we()
		else
			Compositor_wd()
		end
	end)
end

function Compositor_wd() Compositor_w:set_text('󱕅 ') end

function Compositor_we() Compositor_w:set_text('') end

Dnd_w = text_widget()
Dnd_mw = wibox.container.margin(Dnd_w)
function Dnd_wu()
	if naughty.is_suspended() then
		Dnd_we()
	else
		Dnd_wd()
	end
end

function Dnd_we()
	Dnd_mw.right = between - 6
	Dnd_w:set_text(' ')
end

function Dnd_wd()
	Dnd_mw.right = 0
	Dnd_w:set_text('')
end

Meat_w = text_widget(nil, ' ')
Meat_mw = wibox.container.margin(Meat_w)

Hunger_w = text_widget()
Hunger_mw = wibox.container.margin(Hunger_w)
function Hunger_wu()
	awful.spawn.easy_async_with_shell('get_hunger', function(stdout)
		local time = Trim_newlines(stdout)
		if #time > 0 then
			Hunger_mw.right = larger
		else
			Hunger_mw.right = 0
		end
		Hunger_w:set_text(time)
	end)
end

Water_w = text_widget()
Water_bw = wibox.container.background(Water_w)
Water_mw = wibox.container.margin(Water_bw)
function Water_we()
	Water_mw.right = between - 8
	Water_w:set_text('󰖌 ')
end

function Water_wd()
	Water_mw.right = 0
	Water_w:set_text('')
end

Media_note_w = text_widget(nil, '󰝚 ')
Media_note_mw = wibox.container.margin(Media_note_w)
Media_note_mw.left = between
Media_note_mw.right = -2

Media_time_w = text_widget()
Media_time_mw = wibox.container.margin(Media_time_w)
function Media_time_wu()
	awful.spawn.easy_async_with_shell('get_media_time', function(output)
		local media_time = Trim_newlines(output)
		if #media_time > 0 then
			Media_time_mw.right = larger
		else
			Media_time_mw.right = 0
		end
		Media_time_w:set_text(media_time)
	end)
end

Media_state_w = text_widget(beautiful.jetbrains_font .. ' 15')
Media_state_mw = wibox.container.margin(Media_state_w)
function Media_state_wu()
	awful.spawn.easy_async_with_shell('media_state', function(stdout)
		local state = Trim_newlines(stdout)
		Media_state_mw.right = 5
		if state == 'Paused' then
			Media_state_w:set_text('󰏤')
		elseif state == 'Playing' then
			Media_state_w:set_text('󰐊')
		elseif state == 'Stopped' then
			Media_state_w:set_text('󰓛')
		elseif state == '' then
			Media_state_mw.right = 0
		else
			Media_state_w:set_text(state) -- in case there are more statuses I don't know of
		end
	end)
end

Media_volume_w = text_widget()
Media_volume_mw = wibox.container.margin(Media_volume_w)
function Media_volume_wu()
	awful.spawn.easy_async_with_shell('get_media_volume', function(stdout)
		local volume = Trim_newlines(stdout)
		if #volume > 0 then
			Media_volume_mw.right = larger
		else
			Media_volume_mw.right = 0
		end
		Media_volume_w:set_text(volume)
	end)
end

Malumn_w = text_widget(beautiful.jetbrains_font .. ' 14')
Malumn_mw = wibox.container.margin(Malumn_w)
Malumn_mw.right = between
function Malumn_wu(tag) Malumn_w:set_text(tag.master_count .. '/' .. tag.column_count) end

function Malumn_wd() Malumn_w:set_text('?/?') end

Note_w = text_widget('Comfortaa' .. beautiful.font_size)
Note_mw = wibox.container.margin(Note_w)
function Note_wu()
	awful.spawn.easy_async_with_shell('cat ~/.local/share/notie', function(stdout)
		local note = Trim_newlines(stdout)
		if #note == 0 then
			Note_mw.right = 0
			Note_mw.left = 0
		else
			Note_mw.right = between
			Note_mw.left = between
		end
		Note_w:set_text(note)
	end)
end

Ontop_state_w = text_widget()
Ontop_state_bw = wibox.container.background(Ontop_state_w)
Ontop_state_bw.fg = beautiful.red
Ontop_state_mw = wibox.container.margin(Ontop_state_bw)
function Ontop_state_wu(client)
	if client.ontop then
		Ontop_state_mw.right = 6
		Ontop_state_w:set_text(' ')
	else
		Ontop_state_mw.right = 0
		Ontop_state_w:set_text('')
	end
end

Maximized_state_w = text_widget()
Maximized_state_bw = wibox.container.background(Maximized_state_w)
Maximized_state_bw.fg = beautiful.yellow
Maximized_state_mw = wibox.container.margin(Maximized_state_bw)
function Maximized_state_wu(client)
	if client.maximized then
		Maximized_state_mw.right = 2
		Maximized_state_w:set_text(' ')
	else
		Maximized_state_mw.right = 0
		Maximized_state_w:set_text('')
	end
end

Sticky_state_w = text_widget()
Sticky_state_bw = wibox.container.background(Sticky_state_w)
Sticky_state_bw.fg = beautiful.green
Sticky_state_mw = wibox.container.margin(Sticky_state_bw)
function Sticky_state_wu(client)
	if client.sticky then
		Sticky_state_mw.right = 3
		Sticky_state_w:set_text('󰹧 ')
	else
		Sticky_state_mw.right = 0
		Sticky_state_w:set_text('')
	end
end

Floating_state_w = text_widget()
Floating_state_bw = wibox.container.background(Floating_state_w)
Floating_state_bw.fg = beautiful.cyan
Floating_state_mw = wibox.container.margin(Floating_state_bw)
function Floating_state_wu(client)
	if client.floating then
		Floating_state_mw.right = 4
		Floating_state_w:set_text(' ')
	else
		Floating_state_mw.right = 0
		Floating_state_w:set_text('')
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
function Layout_wu()
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
				Layout_bw.fg = beautiful.yellow
				Layout_w:set_text(layout:upper())
			else
				Layout_bw.fg = beautiful.white
				Layout_w:set_text(layout:lower())
			end
		end)
	end)
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
	expand = 'none',
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
		Media_note_mw,
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
		Compositor_mw,
		Water_mw,
		Dnd_mw,
		Bluetooth_mw,
		Wifi_mw,
		Layout_mw,
	},
})

local frequent_updaters = {
	Layout_wu,
	Compositor_wu,
	Bluetooth_wu,
	Wifi_wu,
	Media_time_wu,
	Media_state_wu,
	Media_volume_wu,
	Mic_muteness_wu,
	Mic_volume_wu,
	Volume_wu,
	Muteness_wu,
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
	Hunger_wu()
	Loago_wu()
	Note_wu()
	Malumn_wu(screen.primary.selected_tag)
	Dnd_wu()
	Tile_wu(screen.primary.selected_tag)
	return false
end
gears.timer.start_new(0, run_once)
gears.timer.start_new(20, run_once)
