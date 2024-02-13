mymainmenu = awful.menu({
	items = {
		{ "restart",  awesome.restart },
		{ "quit",     function() awesome.quit() end },
		{ "terminal", terminal }
	}
})

Padding_widget = wibox.widget {
	text = " ",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}

Text_clock_widget = wibox.widget.textclock("%A %y.%m.%d %H:%M:%S ", 1)
Text_clock_widget.font = beautiful.code_font

Mic_muteness_widget = wibox.widget {
	text = " ",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Mic_muteness_background_widget = wibox.container.background(Mic_muteness_widget)
function Widget_update_mic_muteness()
	awful.spawn.easy_async_with_shell("get_mic_mute", function(stdout)
		local stdout = Rtrim(stdout)
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
		local stdout = Rtrim(stdout)
		Mic_volume_widget:set_text(stdout .. "% ")
	end)
end

Muteness_widget = wibox.widget {
	text = " ",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Muteness_background_widget = wibox.container.background(Muteness_widget)
function Widget_update_muteness()
	awful.spawn.easy_async_with_shell("get_mute", function(stdout)
		local stdout = Rtrim(stdout)
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
function Widget_update_volume()
	awful.spawn.easy_async_with_shell("get_volume", function(stdout)
		local stdout = Rtrim(stdout)
		Volume_widget:set_text(stdout .. "% ")
	end)
end

Layout_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Layout_background_widget = wibox.container.background(Layout_widget)
function Widget_update_layout()
	awful.spawn.easy_async_with_shell("get_layout", function(stdout)
		local layout = Rtrim(stdout)
		awful.spawn.easy_async_with_shell("get_capslock", function(stdout)
			local capslock = Rtrim(stdout)
			if capslock == 'on' then
				Layout_background_widget.fg = beautiful.black
				Layout_background_widget.bg = beautiful.yellow
				Layout_widget:set_text(" " .. layout:upper() .. " ")
			else
				Layout_background_widget.fg = beautiful.white
				Layout_background_widget.bg = beautiful.background
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
Wifi_margin_widget = wibox.container.margin(Wifi_background_widget, 0, 5, 0, 0)
function Widget_update_wifi()
	awful.spawn.easy_async_with_shell("get_internet", function(stdout)
		local stdout = Rtrim(stdout)
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
function Widget_disable_compositor()
	Compositor_background_widget.fg = beautiful.red
	Compositor_widget:set_text("󰓦 ")
end
function Widget_enable_compositor()
	Compositor_background_widget.fg = beautiful.white
	Compositor_widget:set_text("")
end

Ontop_state_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Ontop_state_background_widget = wibox.container.background(Ontop_state_widget)
Ontop_state_background_widget.fg = beautiful.red
function Widget_update_ontop(client)
	if client.ontop then
		Ontop_state_widget:set_text(" ")
	else
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
function Widget_update_maximized(client)
	if client.maximized then
		Maximized_state_widget:set_text(" ")
	else
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
function Widget_update_sticky(client)
	if client.sticky then
		Sticky_state_widget:set_text("󰹧 ")
	else
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
function Widget_update_floating(client)
	if client.floating then
		Floating_state_widget:set_text(" ")
	else
		Floating_state_widget:set_text("")
	end
end

Title_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
}

Titlebar_layout_widget = wibox.widget {
	Ontop_state_background_widget,
	Maximized_state_background_widget,
	Sticky_state_background_widget,
	Floating_state_background_widget,
	Title_widget,
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

screen.primary.prompt_widget = awful.widget.prompt()
screen.primary.prompt_margin_widget = wibox.container.margin(screen.primary.prompt_widget, 7, 7, 0, 0)

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
		wibox.widget.systray(),
		Padding_widget,
		Layout_background_widget,
		Padding_widget,
		Compositor_background_widget,
		Wifi_margin_widget,
		Mic_muteness_background_widget,
		Mic_volume_widget,
		Muteness_background_widget,
		Volume_widget,
		Text_clock_widget,
	},
}

local run_once = function()
	return false
end
local run_secondly = function()
	Widget_update_wifi()
	Widget_update_mic_muteness()
	Widget_update_mic_volume()
	Widget_update_muteness()
	Widget_update_volume()
	Widget_update_layout()
	return true
end
gears.timer.start_new(1, run_once)
gears.timer.start_new(1, run_secondly)
gears.timer.start_new(20, run_once)
