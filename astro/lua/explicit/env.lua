env = {}
env.temp_mark = 'P'
env.default_register = '+'
env.soundeffects = vim.fn.expand('~/mus/soundeffects/')
env.external_extensions = { 'mp4', 'webm', 'mkv', 'jpg', 'png', 'gif', 'svg', 'mp3', 'wav', 'ogg', 'oga' }
env.borders = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' }
env.extra_directories = {
	'~/t',
	'~/prog/noties',
	'~/.local/share/alien_temple',
	'~/.local/share/glaza',
}
env.color = {
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
	dark14 = '#242323',
	dark13 = '#212121',
	dark12 = '#1f1e1e',
	dark10 = '#1a1919',
}

function table.reverse(tbl)
	local reversed = {}
	local length = #tbl
	for i = length, 1, -1 do
		table.insert(reversed, tbl[i])
	end
	return reversed
end

function table.contains(table, item)
	for _, thingy in pairs(table) do
		if thingy == item then return true end
	end
	return false
end

function table.slice(tbl, start, stop)
	local sliced = {}
	for index = start or 1, (stop or #tbl) do
		table.insert(sliced, tbl[index])
	end
	return sliced
end

function table.index(tbl, item)
	for index, value in ipairs(tbl) do
		if value == item then return index end
	end
end

function string.trim(string) return vim.fn.trim(string) end

function table.join(tbl, joiner) return vim.fn.join(tbl, joiner) end

function env.echo(chunks, history)
	if history == nil then history = false end
	if type(chunks) == 'string' then
		chunks = { { chunks } }
	elseif type(chunks) == 'table' then
		for index, value in ipairs(chunks) do
			if type(value) == 'string' then
				chunks[index] = { value }
			elseif type(value) ~= 'table' then
				chunks[index] = { tostring(value) }
			end
		end
	else
		chunks = { { tostring(chunks) } }
	end
	vim.api.nvim_echo(chunks, history, {})
end

function env.shell(cmd, opts, on_exit)
	if type(cmd) == 'string' then cmd = { cmd } end
	return vim.system(cmd, vim.tbl_deep_extend('force', { text = true }, opts or {}), on_exit)
end

---@return string|nil
function env.input(prompt, default)
	local output = vim.fn.input({ prompt = prompt, default = default, cancelreturn = '\127' })
	if output == '\127' then
		return nil
	else
		return output
	end
end

function env.feedkeys(keys) vim.api.nvim_feedkeys(keys, 'n', false) end

function env.feedkeys_int(keys)
	local feedable_keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
	vim.api.nvim_feedkeys(feedable_keys, 'n', true)
end

--- Return the next character the user presses
---@param prompt string|nil
---@return string|nil character `nil` if the user pressed <Esc>
function env.char(prompt)
	if prompt then env.echo(prompt) end
	---@type string|nil
	local char = vim.fn.getcharstr()
	-- In '' is the escape character (<Esc>).
	-- Not sure how to check for it without literal character magic.
	if char == '' then char = nil end
	return char
end

function env.confirm(prompt, state, default)
	local options = {}
	for _, value in ipairs(state) do
		table.insert(options, value[1])
	end
	options = vim.fn.join(options, '\n')
	local index = vim.fn.confirm(prompt or '', options, default or 1)
	if index == 0 then return nil end
	return state[index][2]
end

function env.confirm_same(prompt, options, default)
	options_text = vim.fn.join(options, '\n')
	local index = vim.fn.confirm(prompt, options_text, default or 1)
	if index == 0 then return nil end
	return options[index]
end

function vim.ui.select(items, opts, on_choice)
	if #items == 0 then return end
	if not on_choice then return end
	local opts = opts or {}
	local hints = { 'f', 'd', 's', 'r', 'e', 'w', 'v', 'c', 'x', 'a', 'j', 'k', 'l', 'u', 'i', 'o', 'm', ',', '.', ';' }
	if #items > #hints then
		vim.notify('too many options (' .. #items .. ')')
		return
	end

	local valid_hints = table.slice(hints, 1, #items)
	local stringify = type(opts.format_item) == 'function' and opts.format_item or tostring

	lines = {}
	longest = 1
	for index, item in ipairs(items) do
		local stringified = stringify(item)
		if #stringified > longest then longest = #stringified end
		table.insert(lines, hints[index] .. ': ' .. stringified)
	end
	longest = longest + 3

	local buf = vim.api.nvim_create_buf(false, true)
	---@diagnostic disable-next-line: param-type-mismatch
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	local width = math.floor(vim.o.columns * 0.6)
	local height = #items
	local win_opts = {
		relative = 'cursor',
		style = 'minimal',
		border = env.borders,
		width = longest,
		height = height,
		row = 1,
		col = 1,
	}
	if opts.prompt then
		win_opts.title = opts.prompt
		win_opts.title_pos = 'center'
	end
	local window = vim.api.nvim_open_win(buf, true, win_opts)

	local namespace = vim.api.nvim_create_namespace('')
	for index = 0, #lines do
		vim.api.nvim_buf_add_highlight(buf, namespace, 'Orange', index, 0, 1)
		vim.api.nvim_buf_add_highlight(buf, namespace, 'Bold', index, 1, 2)
	end

	for index, value in ipairs(items) do
		vim.keymap.set('n', valid_hints[index], function()
			vim.api.nvim_win_close(window, false)
			on_choice(items[index], index)
		end, { buffer = buf })
	end
	vim.keymap.set('n', '<Esc>', function()
		vim.api.nvim_win_close(window, false)
		on_choice(nil, nil)
	end, { buffer = buf })
end
