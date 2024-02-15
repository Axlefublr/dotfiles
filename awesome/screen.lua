Between_margin = 12

mymainmenu = awful.menu({
	items = {
		{ "restart",  awesome.restart },
		{ "quit",     function() awesome.quit() end },
		{ "terminal", terminal }
	}
})

Text_clock_widget = wibox.widget.textclock("%A %y.%m.%d %H:%M:%S ", 1)
Text_clock_widget.font = beautiful.code_font

Mic_muteness_widget = wibox.widget {
	text = " ",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Mic_muteness_background_widget = wibox.container.background(Mic_muteness_widget)
Mic_muteness_margin_widget = wibox.container.margin(Mic_muteness_background_widget)
Mic_muteness_margin_widget.right = -6
Mic_muteness_margin_widget.left = Between_margin + 5
function Widget_update_mic_muteness()
	awful.spawn.easy_async_with_shell("get_mic_mute", function(stdout)
		local stdout = Trim_newlines(stdout)
		if stdout == "yes" then
			Mic_muteness_background_widget.fg = beautiful.red
		elseif stdout == "no" then
			Mic_muteness_background_widget.fg = beautiful.white
		end
	end)
end

Mic_volume_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
function Widget_update_mic_volume()
	awful.spawn.easy_async_with_shell("get_mic_volume", function(stdout)
		local stdout = Trim_newlines(stdout)
		Mic_volume_widget:set_text(stdout)
	end)
end

Muteness_widget = wibox.widget {
	text = " ",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Muteness_background_widget = wibox.container.background(Muteness_widget)
Muteness_margin_widget = wibox.container.margin(Muteness_background_widget)
Muteness_margin_widget.left = Between_margin + 3
function Widget_update_muteness()
	awful.spawn.easy_async_with_shell("get_mute", function(stdout)
		local stdout = Trim_newlines(stdout)
		if stdout == "yes" then
			Muteness_background_widget.fg = beautiful.red
		elseif stdout == "no" then
			Muteness_background_widget.fg = beautiful.white
		end
	end)
end

Volume_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Volume_margin_widget = wibox.container.margin(Volume_widget)
Volume_margin_widget.right = Between_margin
function Widget_update_volume()
	awful.spawn.easy_async_with_shell("get_volume", function(stdout)
		local stdout = Trim_newlines(stdout)
		Volume_widget:set_text(stdout)
	end)
end

Layout_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Layout_background_widget = wibox.container.background(Layout_widget)
Layout_margin_widget = wibox.container.margin(Layout_background_widget)
Layout_margin_widget.right = Between_margin + 3
function Widget_update_layout()
	awful.spawn.easy_async_with_shell("get_layout", function(stdout)
		local layout = Trim_newlines(stdout)
		if layout == 'English' then
			layout = 'eng'
		elseif layout == 'Russian' then
			layout = 'rus'
		end
		awful.spawn.easy_async_with_shell("get_capslock", function(stdout)
			local capslock = Trim_newlines(stdout)
			if capslock == 'on' then
				Layout_background_widget.fg = beautiful.yellow
				-- Layout_background_widget.bg = beautiful.yellow
				Layout_widget:set_text(layout:upper())
			else
				Layout_background_widget.fg = beautiful.white
				-- Layout_background_widget.bg = beautiful.background
				Layout_widget:set_text(layout:lower())
			end
		end)
	end)
end

Wifi_widget = wibox.widget {
	text = "󰖩 ",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Wifi_background_widget = wibox.container.background(Wifi_widget)
Wifi_margin_widget = wibox.container.margin(Wifi_background_widget)
Wifi_margin_widget.right = Between_margin
function Widget_update_wifi()
	awful.spawn.easy_async_with_shell("get_internet", function(stdout)
		local stdout = Trim_newlines(stdout)
		if stdout == 'none' then
			Wifi_background_widget.fg = beautiful.red
		elseif stdout == 'limited' then
			Wifi_background_widget.fg = beautiful.yellow
		elseif stdout == 'full' then
			Wifi_background_widget.fg = beautiful.white
		end
	end)
end

Compositor_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Compositor_background_widget = wibox.container.background(Compositor_widget)
Compositor_margin_widget = wibox.container.margin(Compositor_background_widget)
function Widget_disable_compositor()
	Compositor_margin_widget.right = 0
	Compositor_widget:set_text("󱕅 ")
end
function Widget_enable_compositor()
	Compositor_margin_widget.right = 0
	Compositor_widget:set_text("")
end
function Widget_update_compositor()
	awful.spawn.easy_async_with_shell("pidof picom", function(stdout)
		local stdout = Trim_newlines(stdout)
		if #stdout > 0 then
			Widget_enable_compositor()
		else
			Widget_disable_compositor()
		end
	end)
end

Gromit_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Gromit_background_widget = wibox.container.background(Gromit_widget)
Gromit_margin_widget = wibox.container.margin(Gromit_background_widget)
function Widget_disable_gromit()
	Gromit_margin_widget.right = 4
	Gromit_widget:set_text(" ")
end
function Widget_enable_gromit()
	Gromit_margin_widget.right = 0
	Gromit_widget:set_text("")
end
function Widget_update_gromit()
	awful.spawn.easy_async_with_shell("pidof gromit-mpx", function(stdout)
		local stdout = Trim_newlines(stdout)
		if #stdout > 0 then
			Widget_enable_gromit()
		else
			Widget_disable_gromit()
		end
	end)
end

Xremap_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Xremap_background_widget = wibox.container.background(Xremap_widget)
Xremap_margin_widget = wibox.container.margin(Xremap_background_widget)
function Widget_disable_xremap()
	Xremap_margin_widget.right = 4
	Xremap_widget:set_text("󱇪 ")
end
function Widget_enable_xremap()
	Xremap_margin_widget.right = 0
	Xremap_widget:set_text("")
end
function Widget_update_xremap()
	awful.spawn.easy_async_with_shell("pidof xremap", function(stdout)
		local stdout = Trim_newlines(stdout)
		if #stdout > 0 then
			Widget_enable_xremap()
		else
			Widget_disable_xremap()
		end
	end)
end

Meat_widget = wibox.widget {
	text = ' ',
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Meat_margin_widget = wibox.container.margin(Meat_widget)
Meat_margin_widget.right = 0

Hunger_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Hunger_widget:buttons(gears.table.join(
	awful.button({}, 1, function()
		awful.spawn.easy_async_with_shell("loago do eat", function()
			Widget_update_hunger()
		end)
	end)
))
Hunger_margin_widget = wibox.container.margin(Hunger_widget)

function Widget_update_hunger()
	awful.spawn.easy_async_with_shell("get_hunger", function(stdout)
		Hunger_widget:set_text(stdout)
	end)
end


Ontop_state_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Ontop_state_background_widget = wibox.container.background(Ontop_state_widget)
Ontop_state_background_widget.fg = beautiful.red
Ontop_state_margin_widget = wibox.container.margin(Ontop_state_background_widget)
function Widget_update_ontop(client)
	if client.ontop then
		Ontop_state_margin_widget.right = 1
		Ontop_state_widget:set_text(" ")
	else
		Ontop_state_margin_widget.right = 0
		Ontop_state_widget:set_text("")
	end
end

Maximized_state_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Maximized_state_background_widget = wibox.container.background(Maximized_state_widget)
Maximized_state_background_widget.fg = beautiful.yellow
Maximized_state_margin_widget = wibox.container.margin(Maximized_state_background_widget)
function Widget_update_maximized(client)
	if client.maximized then
		Maximized_state_margin_widget.right = -2
		Maximized_state_widget:set_text(" ")
	else
		Maximized_state_margin_widget.right = 0
		Maximized_state_widget:set_text("")
	end
end

Sticky_state_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Sticky_state_background_widget = wibox.container.background(Sticky_state_widget)
Sticky_state_background_widget.fg = beautiful.green
Sticky_state_margin_widget = wibox.container.margin(Sticky_state_background_widget)
function Widget_update_sticky(client)
	if client.sticky then
		Sticky_state_margin_widget.right = -2
		Sticky_state_widget:set_text("󰹧 ")
	else
		Sticky_state_margin_widget.right = 0
		Sticky_state_widget:set_text("")
	end
end

Floating_state_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Floating_state_background_widget = wibox.container.background(Floating_state_widget)
Floating_state_background_widget.fg = beautiful.cyan
Floating_state_margin_widget = wibox.container.margin(Floating_state_background_widget)
function Widget_update_floating(client)
	if client.floating then
		Floating_state_margin_widget.right = 0
		Floating_state_widget:set_text(" ")
	else
		Floating_state_margin_widget.right = 0
		Floating_state_widget:set_text("")
	end
end

Stated_margin_widget = wibox.container.margin()
Stated_margin_widget.left = 10

Title_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
}
Title_margin_widget = wibox.container.margin(Title_widget)
Title_margin_widget.left = 0
function Widget_enable_title(passed_client)
	if passed_client ~= client.focus then
		return
	end
	Title_margin_widget.left = 5
	local title = ''
	if passed_client.class then
		title = passed_client.class .. ': '
	end
	if passed_client.name then
		title = title .. passed_client.name
	end
	Title_widget:set_text(title)
end

Titlebar_layout_widget = wibox.widget {
	Stated_margin_widget,
	Ontop_state_margin_widget,
	Maximized_state_margin_widget,
	Sticky_state_margin_widget,
	Floating_state_margin_widget,
	Title_margin_widget,
	layout = wibox.layout.fixed.horizontal
}

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
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

Set_wallpaper(screen.primary)

require('tags')

Ignore_command_output = false
screen.primary.prompt_widget = awful.widget.prompt({
	prompt = "󰼁 ",
	with_shell = true,
	fg_cursor = beautiful.black,
	bg_cursor = beautiful.yellow,
	done_callback = function()
		screen.primary.prompt_margin_widget.left = 0
		screen.primary.prompt_margin_widget.right = 0
	end,
	exe_callback = function(command)
		awful.spawn.easy_async_with_shell(command, function(stdout)
			if Ignore_command_output then
				Ignore_command_output = false
				return
			end
			local stdout = Trim_newlines(stdout)
			if #stdout > 0 then
				naughty.notify({ text = stdout, timeout = 0, font = beautiful.notification_code_font })
			end
		end)
	end
})
screen.primary.prompt_margin_widget = wibox.container.margin(screen.primary.prompt_widget)
function Run_prompt()
	screen.primary.prompt_margin_widget.left = 8
	screen.primary.prompt_margin_widget.right = 8
	screen.primary.prompt_widget:run()
end
function Prompt_ignore_output()
	Ignore_command_output = true
	Run_prompt()
end

screen.primary.layout_box_widget = awful.widget.layoutbox(screen.primary)
screen.primary.layout_box_widget:buttons(gears.table.join(
	awful.button({}, 1, function() awful.layout.inc(1) end),
	awful.button({}, 3, function() awful.layout.inc(-1) end),
	awful.button({}, 4, function() awful.layout.inc(1) end),
	awful.button({}, 5, function() awful.layout.inc(-1) end)))

screen.primary.tag_list_widget = awful.widget.taglist {
	screen  = screen.primary,
	filter  = awful.widget.taglist.filter.noempty,
	buttons = Taglist_buttons,
}

screen.primary.wibox_widget = awful.wibar({ position = "top", screen = screen.primary })

-- awgts (All widgets)
screen.primary.wibox_widget:setup {
	layout = wibox.layout.align.horizontal,
	-- Left widgets
	{
		layout = wibox.layout.fixed.horizontal,
		screen.primary.layout_box_widget,
		screen.primary.tag_list_widget,
		screen.primary.prompt_margin_widget,
	},
	Titlebar_layout_widget,
	-- Right widgets
	{
		layout = wibox.layout.fixed.horizontal,
		-- wibox.widget.systray(),
		Layout_margin_widget,
		Xremap_margin_widget,
		Gromit_margin_widget,
		Compositor_margin_widget,
		Wifi_margin_widget,
		Meat_margin_widget,
		Hunger_margin_widget,
		Mic_muteness_margin_widget,
		Mic_volume_widget,
		Muteness_margin_widget,
		Volume_margin_widget,
		Text_clock_widget,
	},
}

local widget_updaters = {
	Widget_update_xremap,
	Widget_update_gromit,
	Widget_update_compositor,
	Widget_update_wifi,
	Widget_update_mic_muteness,
	Widget_update_mic_volume,
	Widget_update_volume,
	Widget_update_muteness
}

Timer_counter = 0
local perioded = function()
	Timer_counter = Timer_counter + 1
	widget_updaters[Timer_counter]()
	if Timer_counter >= #widget_updaters then
		Timer_counter = 0
	end
	return true
end

gears.timer.start_new(0.2, perioded)

local minutely = function()
	Widget_update_hunger()
	return true
end
gears.timer.start_new(60, minutely)

local run_once = function()
	Widget_update_layout()
	minutely()
	return false
end
gears.timer.start_new(0, run_once)
gears.timer.start_new(20, run_once)