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
		rule = { class = "Spotify" },
		properties = { tag = screen.primary.tags[6]}
	},

	{
		rule = { class = "kitty", name = "task" },
		properties = { tag = screen.primary.tags[12] }
	},

	{
		rule = { class = "kitty", name = "meow" },
		properties = {
			tag = screen.primary.tags[3],
			urgent = false
		}
	},

	{
		rule = { class = "kitty", name = "timer" },
		properties = {
			tag = screen.primary.tags[11],
			urgent = false
		}
	},

	{
		rule = { class = "kitty", name = "content" },
		properties = {
			tag = screen.primary.tags[15],
			urgent = false
		}
	},
}