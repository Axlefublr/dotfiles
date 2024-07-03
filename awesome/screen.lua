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
		{ 'restart', awesome.restart },
		{ 'quit', function() awesome.quit() end },
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
	local file = io.open('/dev/shm/Loago_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Loago_mw.visible = true
			Loago_w:set_text(text)
		else
			Loago_mw.visible = false
		end
	end
end

Anki_w = text_widget()
Anki_bw = wibox.container.background(Anki_w)
Anki_bw.fg = beautiful.red
Anki_mw = wibox.container.margin(Anki_bw)
Anki_mw.left = between
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

	Clients_mw.visible = true
	Clients_w:set_text(#clients)

	local has_minimized = false
	for _, cliente in ipairs(clients) do
		if cliente.minimized then
			has_minimized = true
			break
		end
	end
	if has_minimized then
		Clients_bw.fg = beautiful.cyan
	else
		Clients_bw.fg = beautiful.white
	end
end

Mic_muteness_w = text_widget(nil, ' ')
Mic_muteness_bw = wibox.container.background(Mic_muteness_w)
Mic_muteness_mw = wibox.container.margin(Mic_muteness_bw)
Mic_muteness_mw.right = -8
Mic_muteness_mw.left = larger
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

Muteness_w = text_widget(beautiful.jetbrains_font .. ' 12', ' ')
Muteness_bw = wibox.container.background(Muteness_w)
Muteness_mw = wibox.container.margin(Muteness_bw)
Muteness_mw.left = larger - 1
Muteness_mw.right = 4
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
			elseif text == 'connected full' then
				Bluetooth_bw.fg = beautiful.green
			elseif text == 'connected low' then
				Bluetooth_bw.fg = beautiful.yellow
			elseif text == 'connected critical' then
				Bluetooth_bw.fg = beautiful.red
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
Meat_mw.left = larger

Hunger_w = text_widget()
Hunger_mw = wibox.container.margin(Hunger_w)
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

Disk_w = text_widget(beautiful.jetbrains_font .. ' 14', '󰩹 ')
Disk_mw = wibox.container.margin(Disk_w)
Disk_mw.left = larger
Disk_mw.right = -6
Disk_mw.visible = false

Disk_usage_w = text_widget()
Disk_usage_mw = wibox.container.margin(Disk_usage_w)
Disk_usage_mw.visible = false
function Disk_usage_wu()
	local file = io.open('/dev/shm/Disk_usage_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Disk_usage_mw.visible = true
			Disk_mw.visible = true
			Disk_usage_w:set_text(text)
		else
			Disk_usage_mw.visible = false
			Disk_mw.visible = false
		end
	end
end

Battery_w = text_widget(nil, ' ')
Battery_mw = wibox.container.margin(Battery_w)
Battery_mw.left = larger
Battery_mw.right = 3
Battery_mw.visible = false

Charge_w = text_widget()
Charge_mw = wibox.container.margin(Charge_w)
Charge_mw.visible = false
function Charge_wu()
	local file = io.open('/dev/shm/Charge_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 and text ~= '100' then
			Charge_mw.visible = true
			Battery_mw.visible = true
			Charge_w:set_text(text)
		else
			Charge_mw.visible = false
			Battery_mw.visible = false
		end
	end
end

Monitor_w = text_widget(nil, '󰃟 ')
Monitor_mw = wibox.container.margin(Monitor_w)
Monitor_mw.left = larger
Monitor_mw.right = -1
Monitor_mw.visible = false

Brightness_w = text_widget()
Brightness_mw = wibox.container.margin(Brightness_w)
Brightness_mw.visible = false
function Brightness_wu()
	awful.spawn.easy_async_with_shell('brillo | math -s 0', function(stdout)
		local value = Trim_newlines(stdout)
		if #value > 0 and value ~= '100' then
			Monitor_mw.visible = true
			Brightness_mw.visible = true
			Brightness_w:set_text(value)
		else
			Monitor_mw.visible = false
			Brightness_mw.visible = false
		end
	end)
end

Media_state_w = text_widget(beautiful.jetbrains_font .. ' 15')
Media_state_mw = wibox.container.margin(Media_state_w)
Media_state_mw.right = between
Media_state_mw.visible = false
function Media_state_wu()
	local file = io.open('/dev/shm/Media_state_f', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 then
			Media_state_mw.visible = true
			Media_state_w:set_text(text)
		end
	end
end

Malumn_w = text_widget()
Malumn_mw = wibox.container.margin(Malumn_w)
Malumn_mw.left = between
Malumn_mw.right = between
function Malumn_wu(tag) Malumn_w:set_text(tag.master_count .. '/' .. tag.column_count) end

function Malumn_wd() Malumn_w:set_text('?/?') end

Brain_w = text_widget(beautiful.jetbrains_font .. ' 14', ' ')
Brain_mw = wibox.container.margin(Brain_w)
Brain_mw.right = -6
Brain_mw.left = larger
Brain_mw.visible = false

Ram_w = text_widget()
Ram_mw = wibox.container.margin(Ram_w)
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
Fire_mw.left = larger
Fire_mw.visible = false

Processor_w = text_widget()
Processor_mw = wibox.container.margin(Processor_w)
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

Ontop_state_w = text_widget(nil, ' ')
Ontop_state_bw = wibox.container.background(Ontop_state_w)
Ontop_state_bw.fg = beautiful.red
Ontop_state_mw = wibox.container.margin(Ontop_state_bw)
Ontop_state_mw.right = between - 4
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
Maximized_state_mw.right = between - 5
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
Sticky_state_mw.right = between - 5
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
Floating_state_mw.right = between - 4
Floating_state_mw.visible = false
function Floating_state_wu(client)
	if client and client.floating then
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

Tile_w = text_widget(beautiful.ubuntu_font .. ' 15')
Tile_mw = wibox.container.margin(Tile_w)
Tile_mw.right = between
function Tile_wu(tag)
	local layout_name = tag.layout.name
	if layout_name == 'tile' then
		layout_name = '→'
	elseif layout_name == 'tileleft' then
		layout_name = '←'
	elseif layout_name == 'tilebottom' then
		layout_name = '↓'
	elseif layout_name == 'tiletop' then
		layout_name = '↑'
	elseif layout_name == 'cornernw' then
		layout_name = '↘'
	elseif layout_name == 'cornerne' then
		layout_name = '↙'
	elseif layout_name == 'cornersw' then
		layout_name = '↗'
	elseif layout_name == 'cornerse' then
		layout_name = '↖'
	elseif layout_name == 'fairv' then
		layout_name = '↔'
	elseif layout_name == 'fairh' then
		layout_name = '↕'
	elseif layout_name == 'max' then
		layout_name = '⇅'
	end
	Tile_w:set_text(layout_name)
end

Layout_w = text_widget(beautiful.jetbrains_font .. ' 14')
Layout_bw = wibox.container.background(Layout_w)
Layout_mw = wibox.container.margin(Layout_bw)
Layout_mw.right = between - 4
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

Registers_w = text_widget()
Registers_bw = wibox.container.background(Registers_w)
Registers_bw.fg = beautiful.yellow
Registers_mw = wibox.container.margin(Registers_bw)
Registers_mw.visible = false
Registers_mw.left = between
function Registers_wu()
	local widget = ''

	for num = 0, 9 do
		local filename = os.getenv('HOME') .. '/.local/share/magazine/' .. tostring(num)
		local file = io.open(filename, 'r')

		if file then
			local size = file:seek('end') -- Check file size
			if size > 0 then -- If the file is not empty, add the number to widget
				widget = widget .. num
			end
			file:close()
		end
	end

	if #widget > 0 then
		Registers_mw.visible = true
		Registers_w:set_text(widget)
	else
		Registers_mw.visible = false
	end
end

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(tag) tag:view_only() end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({}, 5, function(tag) awful.tag.viewnext(tag.screen) end),
	awful.button({}, 4, function(tag) awful.tag.viewprev(tag.screen) end)
)

Mouse_w = text_widget(nil, '󰇀')
Mouse_bw = wibox.container.background(Mouse_w)
Mouse_bw.fg = beautiful.purple
Mouse_mw = wibox.container.margin(Mouse_bw)
Mouse_mw.right = between - 2
Mouse_mw.visible = false
function Mouse_wd() Mouse_mw.visible = false end

function Mouse_we(mode_type)
	if mode_type and mode_type == 'green' and Mouse_bw.fg ~= beautiful.green then
		Mouse_bw.fg = beautiful.green
	elseif mode_type and Mouse_bw.fg ~= beautiful.yellow then
		Mouse_bw.fg = beautiful.yellow
	elseif Mouse_bw.fg ~= beautiful.purple then
		Mouse_bw.fg = beautiful.purple
	end
	Mouse_mw.visible = true
end

Clorange_w = text_widget()
Clorange_bw = wibox.container.background(Clorange_w)
Clorange_bw.fg = beautiful.purple
Clorange_mw = wibox.container.margin(Clorange_bw)
Clorange_mw.left = between + 1
Clorange_mw.visible = false
function Clorange_wu()
	local file = io.open('/home/axlefublr/.local/share/clorange/widget', 'r')
	if file then
		local text = file:read('*a')
		file:close()
		if #text > 0 and text ~= '0' then
			Clorange_mw.visible = true
			Clorange_w:set_text(text)
		else
			Clorange_mw.visible = false
		end
	end
end

Taglist_w = awful.widget.taglist({
	screen = screen.primary,
	filter = awful.widget.taglist.filter.noempty,
	buttons = taglist_buttons,
})
Taglist_mw = wibox.container.margin(Taglist_w)
Taglist_mw.right = between

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
		Registers_mw,
		Clock_mw,
		Taglist_mw,
		Clients_mw,
	},
	Loago_mw,
	-- Right widgets
	{
		layout = wibox.layout.fixed.horizontal,
		-- awful.widget.tasklist(),
		-- wibox.widget.systray(),
		Battery_mw,
		Charge_mw,
		Disk_mw,
		Disk_usage_mw,
		Brain_mw,
		Ram_mw,
		Fire_mw,
		Processor_mw,
		Meat_mw,
		Hunger_mw,
		Monitor_mw,
		Brightness_mw,
		Mic_muteness_mw,
		Mic_volume_mw,
		Muteness_mw,
		Volume_mw,
		Clorange_mw,
		Anki_mw,
		Malumn_mw,
		Window_state_lw,
		Mouse_mw,
		Media_state_mw,
		Dnd_mw,
		Bluetooth_mw,
		Wifi_mw,
		Layout_mw,
		Tile_mw,
	},
})

local run_once = function()
	local frequents = {
		'Layout',
		'Media_state',
		'Mic_volume',
		'Volume',
		'Wifi',
		'Bluetooth',
		'Anki',
		'Processor',
		'Ram',
		'Loago',
		'Disk_usage',
		'Charge',
	}
	for _, frequent_ in ipairs(frequents) do
		local file = io.open('/dev/shm/' .. frequent_ .. '_f', 'w')
		if file then
			file:write('')
			file:close()
		end
	end
	Clorange_wu()
	Registers_wu()
	Brightness_wu()
	Hunger_wu()
	Malumn_wu(screen.primary.selected_tag)
	Dnd_wu()
	Tile_wu(screen.primary.selected_tag)
	return false
end
gears.timer.start_new(0, run_once)
