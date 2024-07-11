return {
	'numToStr/Comment.nvim',
	opts = {
		---Add a space b/w comment and the line
		padding = true,
		---Whether the cursor should stay at its position
		sticky = true,
		---Lines to be ignored while (un)comment
		ignore = '^$',
		---LHS of toggle mappings in NORMAL mode
		toggler = {
			---Line-comment toggle keymap
			line = 'gss',
			---Block-comment toggle keymap
			block = 'gSS',
		},
		---LHS of operator-pending mappings in NORMAL and VISUAL mode
		opleader = {
			---Line-comment keymap
			line = 'gs',
			---Block-comment keymap
			block = 'gS',
		},
		---LHS of extra mappings
		extra = {
			---Add comment on the line above
			above = 'gsO',
			---Add comment on the line below
			below = 'gso',
			---Add comment at the end of line
			eol = 'gsl',
		},
		---NOTE: If given `false` then the plugin won't create any mappings
		mappings = {
			---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
			basic = true,
			---Extra mapping; `gco`, `gcO`, `gcA`
			extra = true,
		},
		---Function to call before (un)comment
		pre_hook = nil,
		---Function to call after (un)comment
		post_hook = nil,
	},
}
