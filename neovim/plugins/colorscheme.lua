local highlight_modifications = function()
	local grey = '#928374'
	local yellow = '#d8a657'
	local white = '#d4be98'
	local orange = '#e78a4e'
	local cyan = '#7daea3'
	local mint = '#89b482'

	vim.api.nvim_set_hl(0, '@comment.lua', { fg = grey })
	vim.api.nvim_set_hl(0, '@string.lua', { fg = yellow })
	vim.api.nvim_set_hl(0, '@punctuation.delimiter.lua', { fg = white })
	vim.api.nvim_set_hl(0, '@operator.lua', { fg = white })
	vim.api.nvim_set_hl(0, '@number.lua', { fg = orange })
	vim.api.nvim_set_hl(0, '@boolean.lua', { fg = cyan, italic = true })
	vim.api.nvim_set_hl(0, '@lsp.type.property.lua', { fg = mint })
	vim.api.nvim_set_hl(0, '@variable.member.lua', { fg = mint })
	vim.api.nvim_set_hl(0, '@string.escape.lua', { fg = grey })

	vim.api.nvim_set_hl(0, '@comment.yaml', { fg = grey })
	vim.api.nvim_set_hl(0, '@string.yaml', { fg = yellow })
	vim.api.nvim_set_hl(0, '@property.yaml', { fg = mint })
	vim.api.nvim_set_hl(0, '@punctuation.delimiter.yaml', { fg = white })
	vim.api.nvim_set_hl(0, '@boolean.yaml', { fg = cyan, italic = true })
end

return {
	{
		'sainnhe/gruvbox-material',
		config = function()
			vim.cmd.colorscheme('gruvbox-material')
			highlight_modifications()
		end,
	},
}
