if true then return {} end

---@type LazySpec
return {
	{
		'williamboman/mason-lspconfig.nvim',
		-- overrides `require("mason-lspconfig").setup(...)`
		opts = function(_, opts)
			-- add more things to the ensure_installed table protecting against community packs modifying it
			opts.ensure_installed = require('astrocore').list_insert_unique(opts.ensure_installed, {
				'lua_ls',
				-- add more arguments for adding more language servers
			})
		end,
	},
	-- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
	{
		'jay-babu/mason-null-ls.nvim',
		-- overrides `require("mason-null-ls").setup(...)`
		opts = function(_, opts)
			opts.ensure_installed = require('astrocore').list_insert_unique(opts.ensure_installed, {
				'prettierd',
				'stylua',
			})
		end,
	},
	{
		'jay-babu/mason-nvim-dap.nvim',
		opts = function(_, opts)
			-- add more things to the ensure_installed table protecting against community packs modifying it
			opts.ensure_installed = require('astrocore').list_insert_unique(opts.ensure_installed, {
			})
		end,
	},
}
