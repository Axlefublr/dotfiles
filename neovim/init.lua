Colors = {
	shell_pink = '#ffafd7',
	shell_yellow = '#ffd75f',

	black = '#0f0f0f',
	grey = '#928374',
	yellow = '#d8a657',
	white = '#d4be98',
	orange = '#e78a4e',
	cyan = '#7daea3',
	mint = '#89b482',
	purple = '#d3869b',
	red = '#ea6962'
}

THROWAWAY_REGISTER = 'o'
THROWAWAY_MARK = 'I'

if vim.g.neovide then
	vim.o.guifont = 'JetBrainsMono Nerd Font:h15'
	vim.g.neovide_scroll_animation_length = 0.15
	vim.g.neovide_scroll_animation_far_lines = 5
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_animation_length = 0.07
	vim.g.neovide_cursor_trail_size = 0.4
	vim.g.neovide_padding_left = 10
	local default_scale = 1.0
	vim.g.neovide_scale_factor = default_scale
	vim.keymap.set({ 'n', 'x' }, ",a'", ':lua vim.g.neovide_scale_factor = 0.')
	vim.keymap.set({ 'n', 'x' }, ',a"', ':lua vim.g.neovide_scale_factor = 1')
	if vim.fn.getcwd() == os.getenv('HOME') then
		vim.api.nvim_set_current_dir('~/prog/dotfiles')
	end
end
require('options')
require('global-functions')
require('blob')
require('remaps')

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
		colorscheme = { 'gruvbox-material' }
	},
	change_detection = {
		notify = false
	}
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

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
	callback = Write_if_modified,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'gitcommit',
	command = 'startinsert'
})

print('nvim loaded')
