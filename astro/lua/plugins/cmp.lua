---@type LazySpec
return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		{ 'amarakon/nvim-cmp-buffer-lines', lazy = true },
	},
	opts = function(_, opts)
		local cmp = require('cmp')
		opts.mapping = nil
		cmp.event:on('confirm_done', function() env.play_sound('drop_001.ogg', 55) end)
		return require('astrocore').extend_tbl(opts, {
			performance = {
				throttle = 0,
			},
			window = {
				completion = {
					scrolloff = 99,
					scrollbar = false,
					border = false,
				},
				documentation = {
					border = false,
				},
			},
			view = {
				docs = {
					auto_open = false,
				},
			},
			mapping = {
				['<A-o>'] = function(_)
					if cmp.visible() then
						cmp.abort()
					else
						cmp.complete()
					end
				end,
				['<A-i>'] = function(_)
					if cmp.visible_docs() then
						cmp.close_docs()
					else
						cmp.open_docs()
					end
				end,
				['<F5>'] = cmp.mapping.confirm({
					select = true,
					behavior = cmp.ConfirmBehavior.Replace,
				}),
				['<A-;>'] = cmp.mapping.confirm({
					select = true,
					behavior = cmp.ConfirmBehavior.Insert,
				}),
				['<A-m>'] = cmp.mapping.complete({
					config = {
						sources = {
							{ name = 'buffer-lines', priority = 50, option = {
								leading_whitespace = false,
							} },
						},
					},
				}),
				['<C-p>'] = function()
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
					else
						cmp.complete()
					end
				end,
				['<C-n>'] = function()
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
					else
						cmp.complete()
					end
				end,
			},
		})
	end,
}
