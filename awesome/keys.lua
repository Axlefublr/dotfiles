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
		end,
		{ description = "focus next by index", group = "client" }
	),
	awful.key({ modkey, }, "h",
		function()
			awful.client.focus.byidx(-1)
		end,
		{ description = "focus previous by index", group = "client" }
	),

	awful.key({ modkey, "Mod1" }, "l", function() awful.client.swap.byidx(1) end,
		{ description = "swap with next client by index", group = "client" }),
	awful.key({ modkey, "Mod1" }, "h", function() awful.client.swap.byidx(-1) end,
		{ description = "swap with previous client by index", group = "client" }),

	awful.key({ modkey, }, "c", awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }),

	awful.key({ modkey, }, "k", function() awful.tag.incmwfact(0.02) end,
		{ description = "increase master width factor", group = "layout" }),
	awful.key({ modkey, }, "j", function() awful.tag.incmwfact(-0.02) end,
		{ description = "decrease master width factor", group = "layout" }),
	awful.key({ modkey }, "]", function() awful.tag.incnmaster(1, nil, true) end,
		{ description = "increase the number of master clients", group = "layout" }),
	awful.key({ modkey }, "[", function() awful.tag.incnmaster(-1, nil, true) end,
		{ description = "decrease the number of master clients", group = "layout" }),
	awful.key({ modkey, "Mod1" }, "]", function() awful.tag.incncol(1, nil, true) end,
		{ description = "increase the number of columns", group = "layout" }),
	awful.key({ modkey, "Mod1" }, "[", function() awful.tag.incncol(-1, nil, true) end,
		{ description = "decrease the number of columns", group = "layout" }),
	awful.key({ modkey }, "'", function() awful.layout.inc(1) end,
		{ description = "select next", group = "layout" }),
	awful.key({ modkey, "Mod1" }, "'", function() awful.layout.inc(-1) end,
		{ description = "select previous", group = "layout" }),

	awful.key({ modkey }, ";", function() awful.screen.focused().mypromptbox:run() end,
		{ description = "run prompt", group = "launcher" }),

	-- Activate tags
	awful.key({ modkey }, "u", function() activate_tag(1) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey }, "i", function() activate_tag(2) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey }, "o", function() activate_tag(3) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey }, "p", function() activate_tag(4) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey }, "m", function() activate_tag(5) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey }, ",", function() activate_tag(6) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey }, ".", function() activate_tag(7) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey }, "/", function() activate_tag(8) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey, "Mod1" }, "u", function() activate_tag(9) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey, "Mod1" }, "i", function() activate_tag(10) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey, "Mod1" }, "o", function() activate_tag(11) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey, "Mod1" }, "p", function() activate_tag(12) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey, "Mod1" }, "m", function() activate_tag(13) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey, "Mod1" }, ",", function() activate_tag(14) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey, "Mod1" }, ".", function() activate_tag(15) end, { description = "activate tag", group = "tag" }),
	awful.key({ modkey, "Mod1" }, "/", function() activate_tag(16) end, { description = "activate tag", group = "tag" }),

	-- Move window to tag
	awful.key({ modkey, "Control" }, "u", function() move_window_to_tag(1) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control" }, "i", function() move_window_to_tag(2) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control" }, "o", function() move_window_to_tag(3) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control" }, "p", function() move_window_to_tag(4) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control" }, "m", function() move_window_to_tag(5) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control" }, ",", function() move_window_to_tag(6) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control" }, ".", function() move_window_to_tag(7) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control" }, "/", function() move_window_to_tag(8) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control", "Mod1" }, "u", function() move_window_to_tag(9) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control", "Mod1" }, "i", function() move_window_to_tag(10) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control", "Mod1" }, "o", function() move_window_to_tag(11) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control", "Mod1" }, "p", function() move_window_to_tag(12) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control", "Mod1" }, "m", function() move_window_to_tag(13) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control", "Mod1" }, ",", function() move_window_to_tag(14) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control", "Mod1" }, ".", function() move_window_to_tag(15) end,
		{ description = "move window", group = "tag" }),
	awful.key({ modkey, "Control", "Mod1" }, "/", function() move_window_to_tag(16) end,
		{ description = "move window", group = "tag" })
)

for i = 1, 9 do
	globalkeys = gears.table.join(globalkeys,
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{ description = "toggle focused client on tag #" .. i, group = "tag" })
	)
end

root.keys(globalkeys)

clientkeys = gears.table.join(
	awful.key({ modkey }, "Return", function(client) client:swap(awful.client.getmaster()) end,
		{ description = "move to master", group = "client" })
)