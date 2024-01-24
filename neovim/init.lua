Map = vim.keymap.set
Cmd = vim.cmd
VSCodeNotify = vim.fn.VSCodeNotify
VSCodeCall = vim.fn.VSCodeCall

THROWAWAY_REGISTER = 'o'
THROWAWAY_MARK = 'I'

require('options')
require('functions')
require('fixes')

if vim.g.vscode then
	require('vscode/functions')
	require('vscode/mappings')
else
	require('nvim')
end

require('remaps')
require('registers/registers')
require('registers/text-objects')
require('registers/brackets')
require('features')
require('big/functions')
require('big/mappings')
require('registers/killring')
require('registers/numbered')
require('plugins/plugins')
require('plugins/configuration')
require('plugins/keymap')

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
if os.getenv("KITTY_PIPE_DATA") ~= nil then
	vim.opt.number = false
	vim.opt.relativenumber = false
end

local group = vim.api.nvim_create_augroup("KeepCentered", { clear = true })
vim.api.nvim_create_autocmd('CursorMoved', { command = 'normal! zz', group = group })

print("nvim loaded")