local killring = setmetatable({}, { __index = table })
local numbered = setmetatable({ '', '', '', '', '', '', '', '', '', '' }, { __index = table })

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

function EscapeFromLiteralSearch(input)
	if string.sub(input, 1, 2) ~= '\\V' then return input end
	input = string.sub(input, 3)
	input = string.gsub(input, '\\/', '/')
	input = string.gsub(input, '\\\\', '\\')
	return input
end

function EscapeFromRegexSearch(input)
	if string.sub(input, 1, 2) ~= '\\v' then return input end
	return string.sub(input, 3)
end

function Trim_newlines(string)
	string = string:gsub('[\r\n]*$', '')
	return string:gsub('^[\r\n]*', '')
end

function Trim_trailing_newlines(string) return string:gsub('[\r\n]*$', '') end

function Split_by_newlines(string)
	local lines = {}
	for line in string:gmatch('(.-)\n') do
		table.insert(lines, line)
	end
	return lines
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

function GetBool(message)
	local char = Get_char(message .. ' (f/d):')
	local bool
	if char == 'f' then
		bool = true
	elseif char == 'd' then
		bool = false
	else
		print('press f for true, d for false')
		return nil
	end
	return bool
end

function Remove_highlighting() vim.cmd('noh') end

function Toggle_highlight_search() vim.cmd('set hlsearch!') end

function ReverseTable(table)
	local reversed = setmetatable({}, { __index = table })
	local length = #table

	for i = length, 1, -1 do
		table.insert(reversed, table[i])
	end

	return reversed
end

function Trim_trailing_newlines_buffer()
	local total_lines = vim.api.nvim_buf_line_count(0)

	local last_non_blank = total_lines
	for i = total_lines, 1, -1 do
		if not string.match(vim.fn.getline(i), '^%s*$') then
			last_non_blank = i
			break
		end
	end

	if last_non_blank < total_lines then
		vim.api.nvim_buf_set_lines(0, last_non_blank, total_lines, false, {})
	end
end

-- I call it death because that's where we end up in. Just like /e or no /e
function Search_for_selection(direction, death)
	local default = vim.fn.getreg('"')
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys(direction .. '\\V' .. escaped_selection .. death)
		FeedKeysInt('<cr>')
		vim.fn.setreg('"', default)
	end)
end

function Search_for_register(direction, death)
	local char = Get_char('register: ')
	if not char then return end
	local register = Validate_register(char)
	local escaped_register = EscapeForLiteralSearch(vim.fn.getreg(register))
	FeedKeys(direction .. '\\V' .. escaped_register .. death)
	FeedKeysInt('<cr>')
end

function Move_default_to_other()
	local char = Get_char('register: ')
	if not char then return end
	local register = Validate_register(char)
	local default_contents = vim.fn.getreg('"')
	vim.fn.setreg(register, default_contents)
end

function Search_for_current_word(direction, death)
	local register = vim.fn.getreg('"')
	FeedKeys('yiw')
	vim.schedule(function()
		local escaped_word = EscapeForLiteralSearch(vim.fn.getreg('"'))
		FeedKeys(direction .. '\\V' .. escaped_word .. death)
		FeedKeysInt('<cr>')
		vim.fn.setreg('"', register)
	end)
end

function Killring_push_tail()
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		print('default register is empty')
		return
	end
	killring:insert(1, register_contents)
	print('pushed')
end

function Killring_push()
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		print('default register is empty')
		return
	end
	killring:insert(register_contents)
	print('pushed')
end

function Killring_pop_tail(insert)
	if #killring <= 0 then
		print('killring empty')
		return
	end
	local first_index = killring:remove(1)
	vim.fn.setreg('"', first_index)
	if insert then
		if insert == 'command' then
			FeedKeysInt('<c-r>"')
		else
			FeedKeysInt('<c-r><c-p>"')
		end
	end
	print('got tail')
end

function Killring_pop(insert)
	if #killring <= 0 then
		print('killring empty')
		return
	end
	local first_index = killring:remove(#killring)
	vim.fn.setreg('"', first_index)
	if insert then
		if insert == 'command' then
			FeedKeysInt('<c-r>"')
		else
			FeedKeysInt('<c-r><c-p>"')
		end
	end
	print('got nose')
end

function Killring_compile()
	local compiled_killring = killring:concat('')
	vim.fn.setreg('"', compiled_killring)
	killring = setmetatable({}, { __index = table })
	print('killring compiled')
end

function Killring_compile_reversed()
	local reversed_killring = ReverseTable(killring)
	local compiled_killring = reversed_killring:concat('')
	vim.fn.setreg('"', compiled_killring)
	killring = setmetatable({}, { __index = table })
	print('killring compiled in reverse')
end

function Numbered_get(index, insert)
	if numbered[index] == '' then
		print(index .. ' is empty')
		return
	end
	vim.fn.setreg('"', numbered[index])
	if insert then
		if insert == 'command' then
			FeedKeysInt('<c-r>"')
		else
			FeedKeysInt('<c-r><c-p>"')
		end
	end
	print('grabbed')
end

function Numbered_set(index)
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		print('default register empty')
		return
	end
	numbered[index] = register_contents
	print('stabbed')
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

function Is_readonly()
	local current_buffer = vim.api.nvim_win_get_buf(0)
	return vim.bo[current_buffer].readonly
end

function Get_buffer_name()
	local current_buffer = vim.api.nvim_get_current_buf()
	return vim.api.nvim_buf_get_name(current_buffer)
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

function Get_repo_root()
	local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
	return git_root
end

function Curr_buff_full_path() return vim.api.nvim_buf_get_name(0) end
