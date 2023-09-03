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

print("nvim loaded")