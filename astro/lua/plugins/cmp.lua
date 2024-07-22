---@type LazySpec
return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		{ 'hrsh7th/cmp-buffer', lazy = true },
		{ 'amarakon/nvim-cmp-buffer-lines', lazy = true },
		{ 'saadparwaiz1/cmp_luasnip', enabled = false },
	},
	opts = function(_, opts)
		local cmp = require('cmp')
		opts.mapping = nil
		for index = #opts.sources, 1, -1 do
			local source_name = opts.sources[index].name
			if source_name == 'buffer' or source_name == 'luasnip' then table.remove(opts.sources, index) end
		end
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
					border = env.borders,
				},
			},
			view = {
				docs = {
					auto_open = false,
				},
			},
			mapping = {
				['<A-m>'] = function(_)
					if cmp.visible() then
						cmp.abort()
					else
						cmp.complete()
					end
				end,
				['<A-.>'] = function(_)
					if cmp.visible() then
						if cmp.visible_docs() then
							cmp.close_docs()
						else
							cmp.open_docs()
						end
					else
						vim.lsp.buf.signature_help()
					end
				end,
				['<A-;>'] = cmp.mapping.confirm({
					select = true,
					behavior = cmp.ConfirmBehavior.Insert,
				}),
				['<A-,>'] = cmp.mapping.complete({
					config = {
						sources = {
							{ name = 'buffer-lines', priority = 50, option = {
								leading_whitespace = false,
							} },
						},
					},
				}),
				['<A-n>'] = cmp.mapping.complete({
					config = {
						sources = {
							{ name = 'buffer' },
						},
					},
				}),
				['<C-p>'] = function()
					if cmp.visible() then
						cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
					else
						cmp.complete()
					end
				end,
				['<C-n>'] = function()
					if cmp.visible() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					else
						cmp.complete()
					end
				end,
			},
		})
	end,
}
