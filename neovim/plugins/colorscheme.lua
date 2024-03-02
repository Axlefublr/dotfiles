local highlight_modifications = function()
	vim.api.nvim_set_hl(0, '@comment.lua', { fg = Colors.grey })
	vim.api.nvim_set_hl(0, '@string.lua', { fg = Colors.yellow })
	vim.api.nvim_set_hl(0, '@punctuation.delimiter.lua', { fg = Colors.white })
	vim.api.nvim_set_hl(0, '@operator.lua', { fg = Colors.white })
	vim.api.nvim_set_hl(0, '@number.lua', { fg = Colors.orange })
	vim.api.nvim_set_hl(0, '@boolean.lua', { fg = Colors.cyan, italic = true })
	vim.api.nvim_set_hl(0, '@lsp.type.property.lua', { fg = Colors.mint })
	vim.api.nvim_set_hl(0, '@lsp.type.comment.lua', { fg = Colors.grey })
	vim.api.nvim_set_hl(0, '@variable.member.lua', { fg = Colors.mint })
	vim.api.nvim_set_hl(0, '@string.escape.lua', { fg = Colors.grey })

	vim.api.nvim_set_hl(0, '@comment.yaml', { fg = Colors.grey })
	vim.api.nvim_set_hl(0, '@string.yaml', { fg = Colors.yellow })
	vim.api.nvim_set_hl(0, '@property.yaml', { fg = Colors.mint })
	vim.api.nvim_set_hl(0, '@punctuation.delimiter.yaml', { fg = Colors.white })
	vim.api.nvim_set_hl(0, '@boolean.yaml', { fg = Colors.cyan, italic = true })
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
