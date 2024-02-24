VSCodeNotify = vim.fn.VSCodeNotify
VSCodeCall = vim.fn.VSCodeCall

THROWAWAY_REGISTER = 'o'
THROWAWAY_MARK = 'I'

require('options')
require('global-functions')
require('blob')

if vim.g.vscode then
	require('vscode/api')
	require('vscode/only-vscode')
else
	require('only-pure')
end

require('remaps')
require('plugins')

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

vim.api.nvim_create_autocmd('CursorMoved', {
	command = 'normal! zz'
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = { '*.XCompose' },
	command = 'setfiletype xcompose'
})

print('nvim loaded')