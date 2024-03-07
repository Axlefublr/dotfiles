local highlight_modifications = function()
	vim.api.nvim_set_hl(0, '@comment', { fg = Colors.grey })
	vim.api.nvim_set_hl(0, '@string', { fg = Colors.yellow })
	vim.api.nvim_set_hl(0, '@string.escape', { fg = Colors.grey })
	vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = Colors.white } )

	vim.api.nvim_set_hl(0, '@operator.lua', { fg = Colors.white })
	vim.api.nvim_set_hl(0, '@number.lua', { fg = Colors.orange })
	vim.api.nvim_set_hl(0, '@boolean.lua', { fg = Colors.cyan, italic = true })
	vim.api.nvim_set_hl(0, '@lsp.type.property.lua', { fg = Colors.white })
	vim.api.nvim_set_hl(0, '@lsp.type.comment.lua', { fg = Colors.grey })
	vim.api.nvim_set_hl(0, '@variable.member.lua', { fg = Colors.white })

	vim.api.nvim_set_hl(0, '@comment.yaml', { fg = Colors.grey })
	vim.api.nvim_set_hl(0, '@property.yaml', { fg = Colors.mint })
	vim.api.nvim_set_hl(0, '@boolean.yaml', { fg = Colors.cyan, italic = true })

	vim.api.nvim_set_hl(0, '@number.fish', { fg = Colors.orange } )
	vim.api.nvim_set_hl(0, '@boolean.fish', { fg = Colors.cyan, italic = true } )
	vim.api.nvim_set_hl(0, '@constant.fish', { fg = Colors.purple } )
	vim.api.nvim_set_hl(0, '@variable.fish', { fg = Colors.purple } )

	vim.api.nvim_set_hl(0, '@type.css', { fg = Colors.orange } ) -- .class
	vim.api.nvim_set_hl(0, '@number.css', { fg = Colors.orange } )
	vim.api.nvim_set_hl(0, '@property.css', { fg = Colors.mint } )
	vim.api.nvim_set_hl(0, '@operator.css', { fg = Colors.white } )
	vim.api.nvim_set_hl(0, '@type.qualifier.css', { fg = Colors.red } )
	vim.api.nvim_set_hl(0, '@tag.attribute.css', { fg = Colors.mint } )
	vim.api.nvim_set_hl(0, '@tag.css', { fg = Colors.purple } )
	vim.api.nvim_set_hl(0, '@variable.css', { fg = Colors.white, italic = true } )
	vim.api.nvim_set_hl(0, '@constant.css', { fg = Colors.cyan } ) -- #id
	vim.api.nvim_set_hl(0, '@attribute.css', { fg = Colors.cyan } ) -- [something="something"]
	vim.api.nvim_set_hl(0, '@number.float.css', { fg = Colors.orange } )

	vim.api.nvim_set_hl(0, 'confComment', { fg = Colors.grey })
	vim.api.nvim_set_hl(0, 'confString', { fg = Colors.yellow })
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
