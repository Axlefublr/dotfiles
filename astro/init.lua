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
	shell_red = '#ff2930',
	shell_orange = '#ff9f1a',
	shell_yellow = '#ffd75f',
	shell_salad = '#87ff5f',
	shell_green = '#3dff47',
	shell_cyan = '#00d7ff',
	shell_purple = '#af87ff',
	shell_pink = '#ffafd7',
	shell_grey = '#878787',

	black = '#0f0f0f',
	red = '#ea6962',
	orange = '#e49641',
	yellow = '#d3ad5c',
	green = '#a9b665',
	mint = '#78bf84',
	cyan = '#7daea3',
	purple = '#b58cc6',
	blush = '#e491b2',
	white = '#d4be98',
	grey = '#928374',

	light25 = '#403f3f',
	light19 = '#313030',
	level = '#292828',
	dark13 = '#212121',
	dark12 = '#1f1e1e',
	dark10 = '#1a1919',
}

THROWAWAY_MARK = 'P'

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

--- Return the next character the user presses
---@param prompt string|nil
---@return string|nil character `nil` if the user pressed <Esc>
function Get_char(prompt)
	if prompt then vim.api.nvim_echo({ { prompt, 'Input' } }, true, {}) end
	---@type string|nil
	local char = vim.fn.getcharstr()
	-- In '' is the escape character (<Esc>).
	-- Not sure how to check for it without literal character magic.
	if char == '' then char = nil end
	return char
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

function Trim_trailing_whitespace()
	local search = vim.fn.getreg('/')
	---@diagnostic disable-next-line: param-type-mismatch
	pcall(vim.cmd, '%s`\\v\\s+$')
	vim.fn.setreg('/', search)
end

function Split_by_newlines(text)
	lines = {}
	for line in string.gmatch(text, '[^\r\n]+') do
		table.insert(lines, line)
	end
	return lines
end

function Join_with_newlines(lines)
	text = ''
	for _, line in ipairs(lines) do
		text = text .. line .. '\n'
	end
	return text:sub(1, -2)
end

require('lazy_setup')
