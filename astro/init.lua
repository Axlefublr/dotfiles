-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
	-- stylua: ignore
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, 'lazy') then
	-- stylua: ignore
	vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
	vim.fn.getchar()
	vim.cmd.quit()
end

Colors = {
	shell_pink = '#ffafd7',
	shell_purple = '#af87ff',
	shell_yellow = '#ffd75f',
	shell_cyan = '#00d7ff',
	shell_green = '#87ff5f',
	shell_grey = '#878787',
	shell_red = '#ff2930',

	black = '#0f0f0f',
	red = '#ea6962',
	orange = '#e78a4e',
	yellow = '#d8a657',
	green = '#a9b665',
	mint = '#89b482',
	cyan = '#7daea3',
	purple = '#d3869b',
	white = '#d4be98',
	grey = '#928374',

	darkerest = '#1f1e1e',
	darkness = '#1a1919',
}

THROWAWAY_MARK = 'P'
THROWAWAY_REGISTER = 'p'

function FeedKeys(keys) vim.api.nvim_feedkeys(keys, 'n', false) end

function FeedKeysInt(keys)
	local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(feedable_keys, 'n', true)
end

function EscapeForLiteralSearch(input)
	input = string.gsub(input, '\\', '\\\\')
	input = string.gsub(input, '\n', '\\n')
	input = string.gsub(input, '/', '\\/')
	return input
end

function Get_vertical_line_diff(is_top)
	local winid = vim.api.nvim_get_current_win()
	local function get_visible_lines()
		local compared_line = 0
		if is_top then
			compared_line = vim.fn.line('w0')
		else
			compared_line = vim.fn.line('w$')
		end
		local current_line = vim.api.nvim_win_get_cursor(0)[1]
		local line_count = math.abs(compared_line - current_line)
		return line_count
	end
	local line_count = vim.api.nvim_win_call(winid, get_visible_lines)
	return line_count
end

function Get_char(prompt)
	vim.api.nvim_echo({ { prompt, 'Input' } }, true, {})
	local char = vim.fn.getcharstr()
	-- That's the escape character (<Esc>). Not sure how to specify it smarter
	-- In other words, if you pressed escape, we return nil
	if char == '' then char = nil end
	return char
end

function Validate_register(register)
	if register == 'q' then
		return '+'
	elseif register == 'w' then
		return '0'
	elseif register == "'" then
		return '"'
	else
		return register
	end
end

function Write_cursor_position_on_leave(path)
	vim.api.nvim_create_autocmd('VimLeave', {
		callback = function()
			local file = io.open(path, 'w')
			if file then
				local position = vim.api.nvim_win_get_cursor(0)
				local line = position[1]
				local column = position[2]
				file:write(line .. ' ' .. column + 1)
				file:close()
			end
		end,
	})
end

function ReverseTable(table)
	local reversed = setmetatable({}, { __index = table })
	local length = #table

	for i = length, 1, -1 do
		table.insert(reversed, table[i])
	end

	return reversed
end

require('lazy_setup')

if vim.fn.getcwd() == os.getenv('HOME') then vim.api.nvim_set_current_dir('~/prog/dotfiles') end
-- local argv = vim.api.nvim_get_vvar('argv')
