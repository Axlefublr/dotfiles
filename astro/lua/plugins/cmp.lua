return {
	'hrsh7th/nvim-cmp',
	opts = function(_, opts)
		local cmp = require('cmp')
		opts.mapping = nil
		return require('astrocore').extend_tbl(opts, {
			performance = {
				throttle = 0,
			},
			window = {
				completion = {
					scrolloff = 99,
					scrollbar = false,
					border = false
				},
				documentation = false
			},
			view = {
				docs = {
					auto_open = false,
				},
			},
			mapping = cmp.mapping.preset.insert({
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
			}),
		})
	end
}
