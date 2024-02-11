local activate_tag = function(index)
	local screen = awful.screen.focused()
	local tag = screen.tags[index]
	if tag then
		tag:view_only()
	end
end

local move_window_to_tag = function(index)
	if client.focus then
		local tag = client.focus.screen.tags[index]
		if tag then
			client.focus:move_to_tag(tag)
		end
	end
end

local toggle_window_on_tag = function(index)
	if client.focus then
		local tag = client.focus.screen.tags[index]
		if tag then
			client.focus:toggle_tag(tag)
		end
	end
end

-- Buttons
--
root.buttons(gears.table.join(
	awful.button({}, 3, function() mymainmenu:toggle() end)
))

clientbuttons = gears.table.join(
	awful.button({}, 1, function(client)
		client:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(client)
		client:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(client)
	end),
	awful.button({ modkey }, 3, function(client)
		client:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(client)
	end)
)

globalkeys = gears.table.join(
	awful.key({ modkey, }, "l",
		function()
			awful.client.focus.byidx(1)
		end
	),
	awful.key({ modkey, }, "h",
		function()
			awful.client.focus.byidx(-1)
		end
	),

	awful.key({ modkey, "Mod1" }, "l", function() awful.client.swap.byidx(1) end),
	awful.key({ modkey, "Mod1" }, "h", function() awful.client.swap.byidx(-1) end),

	awful.key({ modkey, }, "c", awful.client.urgent.jumpto),

	awful.key({ modkey, }, "k", function() awful.tag.incmwfact(0.02) end),
	awful.key({ modkey, }, "j", function() awful.tag.incmwfact(-0.02) end),

	awful.key({ modkey }, "]", function() awful.tag.incnmaster(1, nil, true) end),
	awful.key({ modkey }, "[", function() awful.tag.incnmaster(-1, nil, true) end),

	awful.key({ modkey, "Mod1" }, "]", function() awful.tag.incncol(1, nil, true) end),
	awful.key({ modkey, "Mod1" }, "[", function() awful.tag.incncol(-1, nil, true) end),

	awful.key({ modkey }, "'", function() awful.layout.inc(1) end),
	awful.key({ modkey, "Mod1" }, "'", function() awful.layout.inc(-1) end),

	awful.key({ modkey }, ";", function() awful.screen.focused().prompt_widget:run() end),

	-- Activate tags
	awful.key({ modkey }, "u", function() activate_tag(1) end),
	awful.key({ modkey }, "i", function() activate_tag(2) end),
	awful.key({ modkey }, "o", function() activate_tag(3) end),
	awful.key({ modkey }, "p", function() activate_tag(4) end),
	awful.key({ modkey }, "m", function() activate_tag(5) end),
	awful.key({ modkey }, ",", function() activate_tag(6) end),
	awful.key({ modkey }, ".", function() activate_tag(7) end),
	awful.key({ modkey }, "/", function() activate_tag(8) end),
	awful.key({ modkey, "Mod1" }, "u", function() activate_tag(9) end),
	awful.key({ modkey, "Mod1" }, "i", function() activate_tag(10) end),
	awful.key({ modkey, "Mod1" }, "o", function() activate_tag(11) end),
	awful.key({ modkey, "Mod1" }, "p", function() activate_tag(12) end),
	awful.key({ modkey, "Mod1" }, "m", function() activate_tag(13) end),
	awful.key({ modkey, "Mod1" }, ",", function() activate_tag(14) end),
	awful.key({ modkey, "Mod1" }, ".", function() activate_tag(15) end),
	awful.key({ modkey, "Mod1" }, "/", function() activate_tag(16) end),

	-- Move window to tag
	awful.key({ modkey, "Control" }, "u", function() move_window_to_tag(1) end),
	awful.key({ modkey, "Control" }, "i", function() move_window_to_tag(2) end),
	awful.key({ modkey, "Control" }, "o", function() move_window_to_tag(3) end),
	awful.key({ modkey, "Control" }, "p", function() move_window_to_tag(4) end),
	awful.key({ modkey, "Control" }, "m", function() move_window_to_tag(5) end),
	awful.key({ modkey, "Control" }, ",", function() move_window_to_tag(6) end),
	awful.key({ modkey, "Control" }, ".", function() move_window_to_tag(7) end),
	awful.key({ modkey, "Control" }, "/", function() move_window_to_tag(8) end),
	awful.key({ modkey, "Control", "Mod1" }, "u", function() move_window_to_tag(9) end),
	awful.key({ modkey, "Control", "Mod1" }, "i", function() move_window_to_tag(10) end),
	awful.key({ modkey, "Control", "Mod1" }, "o", function() move_window_to_tag(11) end),
	awful.key({ modkey, "Control", "Mod1" }, "p", function() move_window_to_tag(12) end),
	awful.key({ modkey, "Control", "Mod1" }, "m", function() move_window_to_tag(13) end),
	awful.key({ modkey, "Control", "Mod1" }, ",", function() move_window_to_tag(14) end),
	awful.key({ modkey, "Control", "Mod1" }, ".", function() move_window_to_tag(15) end),
	awful.key({ modkey, "Control", "Mod1" }, "/", function() move_window_to_tag(16) end),

	awful.key({ modkey, "Shift" }, "u", function() toggle_window_on_tag(1) end),
	awful.key({ modkey, "Shift" }, "i", function() toggle_window_on_tag(2) end),
	awful.key({ modkey, "Shift" }, "o", function() toggle_window_on_tag(3) end),
	awful.key({ modkey, "Shift" }, "p", function() toggle_window_on_tag(4) end),
	awful.key({ modkey, "Shift" }, "m", function() toggle_window_on_tag(5) end),
	awful.key({ modkey, "Shift" }, ",", function() toggle_window_on_tag(6) end),
	awful.key({ modkey, "Shift" }, ".", function() toggle_window_on_tag(7) end),
	awful.key({ modkey, "Shift" }, "/", function() toggle_window_on_tag(8) end),
	awful.key({ modkey, "Shift", "Mod1" }, "u", function() toggle_window_on_tag(9) end),
	awful.key({ modkey, "Shift", "Mod1" }, "i", function() toggle_window_on_tag(10) end),
	awful.key({ modkey, "Shift", "Mod1" }, "o", function() toggle_window_on_tag(11) end),
	awful.key({ modkey, "Shift", "Mod1" }, "p", function() toggle_window_on_tag(12) end),
	awful.key({ modkey, "Shift", "Mod1" }, "m", function() toggle_window_on_tag(13) end),
	awful.key({ modkey, "Shift", "Mod1" }, ",", function() toggle_window_on_tag(14) end),
	awful.key({ modkey, "Shift", "Mod1" }, ".", function() toggle_window_on_tag(15) end),
	awful.key({ modkey, "Shift", "Mod1" }, "/", function() toggle_window_on_tag(16) end)
)

root.keys(globalkeys)

clientkeys = gears.table.join(
	awful.key({ modkey }, "Return", function(client) client:swap(awful.client.getmaster()) end,
		{ description = "move to master", group = "client" })
)
