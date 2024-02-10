awful.rules.rules = {
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			floating = false,
			maximized = false
		}
	},

	{
		rule_any = {
			class = {
				"kruler"
			}
		},
		properties = { floating = true }
	},

	{
		rule = { class = "kitty", name = "task" },
		properties = { tag = screen.primary.tags[12] }
	}
}