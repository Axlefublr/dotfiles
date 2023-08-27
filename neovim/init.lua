Map = vim.keymap.set
Cmd = vim.cmd
VSCodeNotify = vim.fn.VSCodeNotify
VSCodeCall = vim.fn.VSCodeCall

THROWAWAY_REGISTER = 'o'
THROWAWAY_MARK = 'I'

require('options')
require('functions')
require('fixes')
require('plugins/plugins')
require('plugins/configuration')
require('plugins/keymap')
require('registers/text-objects')
require('remaps')
require('registers/registers')
require('features')
require('big')
require('registers/killring')

if vim.g.vscode then
	require('vscode/functions')
	require('vscode/mappings')
else
	require('nvim')
end

print("nvim loaded")