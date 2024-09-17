awful.rules.rules = {
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = ClientKeys,
			buttons = ClientButtons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			floating = false,
			maximized = false,
		},
	},

	-------------------------------------------always floating & on top-----------------------------------------
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

	----------------------------------------------always fullscreen--------------------------------------------
	{
		rule_any = {
			class = { 'Modded Slay the Spire' },
		},
		properties = {
			fullscreen = true,
		},
	},

	---------------------------------------------------neoline-------------------------------------------------
	{
		rule = { class = 'kitty', name = 'neoline' },
		properties = {
			maximized = true,
			-- floating = true,
			-- ontop = true,
			-- x = 0,
			-- y = 0,
			-- width = 1920,
			-- height = 540,
		},
	},

	---------------------------------------------------tag o/3-------------------------------------------------
	{
		rule_any = { class = 'Zathura' },
		properties = { tag = screen.primary.tags[3] },
	},
	{
		rule = { class = 'kitty', name = 'men' },
		properties = {
			tag = screen.primary.tags[3],
			urgent = false,
		},
	},

	----------------------------------------------------tag p--------------------------------------------------
	{
		rule = { class = 'kitty', name = 'screen_record' },
		properties = {
			tag = screen.primary.tags[4],
		},
	},
	-- {
	-- 	rule_any = { class = '' },
	-- 	properties = { tag = screen.primary.tags[4] },
	-- },

	---------------------------------------------------tag ,/6-------------------------------------------------
	{
		rule_any = { class = 'Spotify' },
		properties = { tag = screen.primary.tags[6] },
	},

	---------------------------------------------------tag U/9-------------------------------------------------
	----------------------------------------------------tag O--------------------------------------------------
	{
		rule = { class = 'kitty', name = 'timer' },
		properties = {
			tag = screen.primary.tags[11],
			urgent = false,
		},
	},

	----------------------------------------------------tag P--------------------------------------------------
	{
		rule = { class = 'kitty', name = 'link-download' },
		properties = { tag = screen.primary.tags[12] },
	},

	----------------------------------------------------tag M--------------------------------------------------
	{
		rule = { class = 'obs' },
		properties = { tag = screen.primary.tags[13] },
	},

	----------------------------------------------------tag <--------------------------------------------------
	{
		rule = { class = 'Gimp' },
		properties = { tag = screen.primary.tags[14] },
	},
	{
		rule = { class = 'kitty', name = 'uboot' },
		properties = { tag = screen.primary.tags[14] },
	},

	----------------------------------------------------tag >--------------------------------------------------
	{
		rule = { class = 'kitty', name = 'oil-content' },
		properties = { tag = screen.primary.tags[15], urgent = false },
	},
}
