local lazypath = vim.env.LAZY or vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
	-- stylua: ignore
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

if not pcall(require, 'lazy') then
	-- stylua: ignore
	vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
	vim.fn.getchar()
	vim.cmd.quit()
end

require('options')
require('env')

require('lazy').setup({
	{ import = 'plugins' },
}, {
	install = { colorscheme = { 'gruvbox-material' } },
	ui = { backdrop = 100 },
	change_detection = { notify = false },
	checker = {
		enabled = false,
		frequency = 60 * 60 * 24,
	},
	dev = {
		path = '~/prog/proj',
	},
	performance = {
		rtp = {
			disabled_plugins = {
				'gzip',
				'netrwPlugin',
				'tarPlugin',
				'tohtml',
				'zipPlugin',
				'tutor',
				'spellfile'
			},
		},
	},
})

env.saquire('autocmds')
env.saquire('commands')
