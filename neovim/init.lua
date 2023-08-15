Map = vim.keymap.set
Cmd = vim.cmd
VSCodeNotify = vim.fn.VSCodeNotify
VSCodeCall = vim.fn.VSCodeCall

THROWAWAY_REGISTER = 'o'
THROWAWAY_MARK = 'I'

require('options')
require('functions')
require('fixes')
require('plugins')
require('conf-plugins')
require('keymap-plugins')
require('text-objects')
require('remaps')
require('registers')
require('features')
require('big')

if vim.g.vscode then
	require('vscode-functions')
	require('vscode-mappings')
else
	require('nvim')
end

print("nvim loaded")