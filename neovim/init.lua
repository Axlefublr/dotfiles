Colors = {
	smooth_black = '#0f0f0f',

	shell_pink = '#ffafd7',
	shell_yellow = '#ffd75f',
	shell_cyan = '#00d7ff',
	shell_green = '#87ff5f',
	shell_grey = '#878787',
	shell_red = '#ff2930',

	black = '#0f0f0f',
	grey = '#928374',
	yellow = '#d8a657',
	white = '#d4be98',
	orange = '#e78a4e',
	cyan = '#7daea3',
	mint = '#89b482',
	purple = '#d3869b',
	red = '#ea6962',

	darkerest = '#1f1e1e',
	darkness = '#1a1919',
}

THROWAWAY_REGISTER = 'p'
THROWAWAY_MARK = 'I'

if vim.fn.getcwd() == os.getenv('HOME') then vim.api.nvim_set_current_dir('~/prog/dotfiles') end
require('options')
require('global-functions')
require('remaps')
require('window')
require('harp')
require('killring')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
	install = {
		colorscheme = { 'gruvbox-material' },
	},
	change_detection = {
		notify = false,
	},
})

-- When I use my hotkeys to open some output I see in my kitty terminal,
-- I'm already looking at some place I want to (usually) copy.
-- Once I open it in neovim, I get the extra margin to fit in line numbers.
-- Having those makes me have to *refind* the place I was just looking at,
-- and because of that I might've been underusing the feature.
-- So I remove them, to make it *easier* to find myself in that neovim instance,
-- ironically, since usually having line numbers is helpful.
-- To add, a lot of output calculates how much to wrap using $COLUMNS.
-- If you suddenly occupy 2 (or however many) columns that were used prior,
-- the wrapping efforts go to shit and the kitty+nvim hotkeys become unreasonable to use,
-- making me have to resort to worse, built in kitty scrolling
if os.getenv('KITTY_PIPE_DATA') ~= nil then
	vim.opt.number = false
	vim.opt.relativenumber = false
end

vim.cmd('packadd! matchit')

vim.api.nvim_create_user_command('O', function(info)
	local range = ''
	if info.range > 0 then range = (info.line1 or '') .. ',' .. (info.line2 or '') end
	vim.cmd(range .. 'norm ' .. info.args)
end, { nargs = '*', range = true })

vim.api.nvim_create_autocmd('CursorMoved', {
	command = 'normal! zz',
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = { '*.XCompose' },
	command = 'setfiletype xcompose',
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = { '*.rasi' },
	command = 'setfiletype rasi',
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = { vim.fn.expand('~/.local/share/magazine/l') },
	command = 'setfiletype markdown',
})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
	callback = Write_if_modified,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'gitcommit',
	command = 'startinsert',
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'fish',
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.shiftwidth = 4
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'man',
	callback = function()
		vim.keymap.set({ 'n', 'x', 'o' }, 'q', '<Plug>(leap-forward-to)', { buffer = true })
		vim.keymap.set({ 'n', 'x', 'o' }, 'Q', '<Plug>(leap-backward-to)', { buffer = true })
		vim.keymap.set({ 'n', 'x', 'o' }, ',q', '<Plug>(leap-forward-till)', { buffer = true })
		vim.keymap.set({ 'n', 'x', 'o' }, ',Q', '<Plug>(leap-backward-till)', { buffer = true })
	end,
})

print('nvim loaded')
