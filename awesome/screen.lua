function Widget_update_mic_muteness()
	awful.spawn.easy_async_with_shell("get_mic_mute", function(stdout)
		local stdout = Rtrim(stdout)
		if stdout == "yes" then
			Mic_muteness_background_widget.fg = beautiful.red
			Mic_muteness_widget:set_text(" ")
		elseif stdout == "no" then
			Mic_muteness_background_widget.fg = beautiful.white
			Mic_muteness_widget:set_text(" ")
		end
	end)
end

function Widget_update_mic_volume()
	awful.spawn.easy_async_with_shell("get_mic_volume", function(stdout)
		local stdout = Rtrim(stdout)
		Mic_volume_widget:set_text(stdout .. "% ")
	end)
end

function Widget_update_muteness()
	awful.spawn.easy_async_with_shell("get_mute", function(stdout)
		local stdout = Rtrim(stdout)
		if stdout == "yes" then
			Muteness_background_widget.fg = beautiful.red
			Muteness_widget:set_text(" ")
		elseif stdout == "no" then
			Muteness_background_widget.fg = beautiful.white
			Muteness_widget:set_text(" ")
		end
	end)
end

function Widget_update_volume()
	awful.spawn.easy_async_with_shell("get_volume", function(stdout)
		local stdout = Rtrim(stdout)
		Volume_widget:set_text(stdout .. "% ")
	end)
end

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

function Widget_update_wifi()
	awful.spawn.easy_async_with_shell("get_internet", function(stdout)
		local stdout = Rtrim(stdout)
		if stdout == 'none' then
			Wifi_background_widget.fg = beautiful.red
			Wifi_widget:set_text("󰖪 ")
		elseif stdout == 'limited' then
			Wifi_background_widget.fg = beautiful.yellow
			Wifi_widget:set_text("󰤟 ")
		elseif stdout == 'full' then
			Wifi_background_widget.fg = beautiful.white
			Wifi_widget:set_text("󰖩 ")
		else
			Wifi_widget:set_text("")
		end
	end)
end

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

mytextclock = wibox.widget.textclock("%A %y.%m.%d %H:%M:%S ", 1)
mytextclock.font = beautiful.code_font

Layout_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}

Layout_background_widget = wibox.container.background(Layout_widget)

Mic_muteness_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Mic_muteness_background_widget = wibox.container.background(Mic_muteness_widget)

Mic_volume_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}

Muteness_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Muteness_background_widget = wibox.container.background(Muteness_widget)

Volume_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}

Wifi_widget = wibox.widget {
	text = "",
	widget = wibox.widget.textbox,
	font = beautiful.code_font
}
Wifi_background_widget = wibox.container.background(Wifi_widget)
Wifi_margin_widget = wibox.container.margin(Wifi_background_widget, 0, 5, 0, 0)

Taglist_buttons = gears.table.join(
	awful.button({}, 1, function(tag) tag:view_only() end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({}, 5, function(tag) awful.tag.viewnext(tag.screen) end),
	awful.button({}, 4, function(tag) awful.tag.viewprev(tag.screen) end)
)

Tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(client)
		if client == client.focus then
			client.minimized = true
		else
			client:emit_signal(
				"request::activate",
				"tasklist",
				{ raise = true }
			)
		end
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(-1)
	end))

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

awful.screen.connect_for_each_screen(function(screen)
	Set_wallpaper(screen)

	-- Tag definition
	awful.tag.add("u", {
		layout              = awful.layout.suit.tile.left,
		master_fill_policy  = "expand",
		master_width_factor = 0.74,
		selected            = true,
	})
	awful.tag.add("i", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add("o", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add("p", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add("m", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add(",", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add(".", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add("/", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add("U", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add("I", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add("O", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add("P", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add("M", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add("<", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add(">", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})
	awful.tag.add("?", {
		layout              = awful.layout.suit.tile,
		master_fill_policy  = "expand",
		master_width_factor = 0.5,
	})

	screen.prompt_widget = awful.widget.prompt()
	screen.prompt_margin_widget = wibox.container.margin(screen.prompt_widget, 7, 7, 0, 0)

	screen.mylayoutbox = awful.widget.layoutbox(screen)
	screen.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function() awful.layout.inc(1) end),
		awful.button({}, 3, function() awful.layout.inc(-1) end),
		awful.button({}, 4, function() awful.layout.inc(1) end),
		awful.button({}, 5, function() awful.layout.inc(-1) end)))

	screen.mytaglist = awful.widget.taglist {
		screen  = screen,
		filter  = awful.widget.taglist.filter.all,
		buttons = Taglist_buttons
	}

	screen.mytasklist = awful.widget.tasklist {
		screen  = screen,
		filter  = awful.widget.tasklist.filter.currenttags,
		buttons = Tasklist_buttons
	}

	screen.mywibox = awful.wibar({ position = "top", screen = screen })

	screen.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		-- Left widgets
		{
			layout = wibox.layout.fixed.horizontal,
			screen.mylayoutbox,
			screen.mytaglist,
			wibox.widget.systray(),
			screen.prompt_margin_widget,
		},
		screen.mytasklist, -- Middle widget
		-- Right widgets
		{
			layout = wibox.layout.fixed.horizontal,
			Padding_widget,
			Layout_background_widget,
			Padding_widget,
			Wifi_margin_widget,
			Mic_muteness_background_widget,
			Mic_volume_widget,
			Muteness_background_widget,
			Volume_widget,
			mytextclock,
		},
	}
end)

local run_once = function()
	Widget_update_mic_muteness()
	Widget_update_mic_volume()
	Widget_update_muteness()
	Widget_update_volume()
	Widget_update_layout()
	return false
end
local run_secondly = function()
	Widget_update_wifi()
	return true
end
gears.timer.start_new(1, run_once)
gears.timer.start_new(1, run_secondly)
gears.timer.start_new(20, run_once)
