awful.rules.rules = {
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = Client_keys,
			buttons = Client_buttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			floating = false,
			maximized = false,
		},
	},

	{
		rule_any = {
			class = {
				'kruler',
				'Display',
			},
			name = {
				'Picture in picture',
			},
		},
		properties = {
			floating = true,
			ontop = true,
		},
	},

	{
		rule = { class = 'Spotify' },
		properties = { tag = screen.primary.tags[6] },
	},

	{
		rule = { class = 'Gimp' },
		properties = { tag = screen.primary.tags[14] },
	},

	{
		rule = { class = 'obs' },
		properties = { tag = screen.primary.tags[13] },
	},

	{
		rule = { class = 'neomax' },
		properties = {
			floating = true,
			x = 10,
			y = 45,
			width = 1894,
			height = 1019
		}
	},

	{
		rule = { class = 'neoline' },
		properties = {
			floating = true,
			x = 10,
			y = 500,
			width = 1894,
			height = 110
		}
	},

	{
		rule = { class = 'Alacritty', name = 'task' },
		properties = { tag = screen.primary.tags[12] },
	},

	{
		rule = { class = 'Alacritty', name = 'meow' },
		properties = {
			tag = screen.primary.tags[3],
			urgent = false,
		},
	},

	{
		rule = { class = 'Alacritty', name = 'timer' },
		properties = {
			tag = screen.primary.tags[11],
			urgent = false,
		},
	},

	{
		rule = { class = 'Alacritty', name = 'content' },
		properties = { tag = screen.primary.tags[15] },
	},

	{
		rule = { class = 'Alacritty', name = 'link-download' },
		properties = { tag = screen.primary.tags[12] },
	},

	{
		rule = { class = 'Alacritty', name = 'uboot' },
		properties = { tag = screen.primary.tags[14] },
	},
}