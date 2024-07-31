---@type LazySpec
return {
	'nvim-treesitter/nvim-treesitter',
	main = 'nvim-treesitter.configs',
	event = 'User WayAfter',
	build = ':TSUpdate',
	-- dependencies = {
	-- 	{ 'nvim-treesitter/nvim-treesitter-textobjects', lazy = true },
	-- },
	cmd = {
		'TSBufDisable',
		'TSBufEnable',
		'TSBufToggle',
		'TSDisable',
		'TSEnable',
		'TSToggle',
		'TSInstall',
		'TSInstallInfo',
		'TSInstallSync',
		'TSModuleInfo',
		'TSUninstall',
		'TSUpdate',
		'TSUpdateSync',
	},
	init = function(plugin)
		-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
		-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
		-- no longer trigger the **nvim-treeitter** module to be loaded in time.
		-- Luckily, the only thins that those plugins need are the custom queries, which we make available
		-- during startup.
		-- CODE FROM LazyVim (thanks folke!) https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
		require('lazy.core.loader').add_to_rtp(plugin)
		pcall(require, 'nvim-treesitter.query_predicates')
	end,
	opts_extend = { 'ensure_installed' },
	opts = {
		auto_install = vim.fn.executable('tree-sitter') == 1,
		ensure_installed = env.treesitters,
		highlight = { enable = true },
		indent = { enable = true },
	},
}
