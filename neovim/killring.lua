local killring = setmetatable({}, { __index = table })
local numbered = setmetatable({ '', '', '', '', '', '', '', '', '', '' }, { __index = table })

function killring_push_tail()
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		print('default register is empty')
		return
	end
	killring:insert(1, register_contents)
	print('pushed')
end

function killring_push()
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		print('default register is empty')
		return
	end
	killring:insert(register_contents)
	print('pushed')
end

function killring_pop_tail(insert)
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

function killring_pop(insert)
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

function killring_compile()
	local compiled_killring = killring:concat('')
	vim.fn.setreg('"', compiled_killring)
	killring = setmetatable({}, { __index = table })
	print('killring compiled')
end

function killring_compile_reversed()
	local reversed_killring = ReverseTable(killring)
	local compiled_killring = reversed_killring:concat('')
	vim.fn.setreg('"', compiled_killring)
	killring = setmetatable({}, { __index = table })
	print('killring compiled in reverse')
end

function search_for_register(direction, death)
	local char = Get_char('register: ')
	if not char then return end
	local register = Validate_register(char)
	local escaped_register = EscapeForLiteralSearch(vim.fn.getreg(register))
	FeedKeys(direction .. '\\V' .. escaped_register .. death)
	FeedKeysInt('<cr>')
end

local function numbered_insert(index) numbered_get(index, true) end
local function numbered_command(index) numbered_get(index, 'command') end

function numbered_set(index)
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		print('default register empty')
		return
	end
	numbered[index] = register_contents
	print('stabbed')
end

function numbered_get(index, insert)
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

vim.keymap.set({ 'n', 'x' }, "'1", function() numbered_get(1) end)
vim.keymap.set({ 'n', 'x' }, "'2", function() numbered_get(2) end)
vim.keymap.set({ 'n', 'x' }, "'3", function() numbered_get(3) end)
vim.keymap.set({ 'n', 'x' }, "'4", function() numbered_get(4) end)
vim.keymap.set({ 'n', 'x' }, "'5", function() numbered_get(5) end)
vim.keymap.set({ 'n', 'x' }, "'6", function() numbered_get(6) end)
vim.keymap.set({ 'n', 'x' }, "'7", function() numbered_get(7) end)
vim.keymap.set({ 'n', 'x' }, "'8", function() numbered_get(8) end)
vim.keymap.set({ 'n', 'x' }, "'9", function() numbered_get(9) end)
vim.keymap.set({ 'n', 'x' }, "'0", function() numbered_get(10) end)

vim.keymap.set({ 'n', 'x' }, ',1', function() numbered_set(1) end)
vim.keymap.set({ 'n', 'x' }, ',2', function() numbered_set(2) end)
vim.keymap.set({ 'n', 'x' }, ',3', function() numbered_set(3) end)
vim.keymap.set({ 'n', 'x' }, ',4', function() numbered_set(4) end)
vim.keymap.set({ 'n', 'x' }, ',5', function() numbered_set(5) end)
vim.keymap.set({ 'n', 'x' }, ',6', function() numbered_set(6) end)
vim.keymap.set({ 'n', 'x' }, ',7', function() numbered_set(7) end)
vim.keymap.set({ 'n', 'x' }, ',8', function() numbered_set(8) end)
vim.keymap.set({ 'n', 'x' }, ',9', function() numbered_set(9) end)
vim.keymap.set({ 'n', 'x' }, ',0', function() numbered_set(10) end)

vim.keymap.set('i', "<a-'>1", function() numbered_insert(1) end)
vim.keymap.set('i', "<a-'>2", function() numbered_insert(2) end)
vim.keymap.set('i', "<a-'>3", function() numbered_insert(3) end)
vim.keymap.set('i', "<a-'>4", function() numbered_insert(4) end)
vim.keymap.set('i', "<a-'>5", function() numbered_insert(5) end)
vim.keymap.set('i', "<a-'>6", function() numbered_insert(6) end)
vim.keymap.set('i', "<a-'>7", function() numbered_insert(7) end)
vim.keymap.set('i', "<a-'>8", function() numbered_insert(8) end)
vim.keymap.set('i', "<a-'>9", function() numbered_insert(9) end)
vim.keymap.set('i', "<a-'>0", function() numbered_insert(10) end)

vim.keymap.set('c', "<a-'>1", function() numbered_command(1) end)
vim.keymap.set('c', "<a-'>2", function() numbered_command(2) end)
vim.keymap.set('c', "<a-'>3", function() numbered_command(3) end)
vim.keymap.set('c', "<a-'>4", function() numbered_command(4) end)
vim.keymap.set('c', "<a-'>5", function() numbered_command(5) end)
vim.keymap.set('c', "<a-'>6", function() numbered_command(6) end)
vim.keymap.set('c', "<a-'>7", function() numbered_command(7) end)
vim.keymap.set('c', "<a-'>8", function() numbered_command(8) end)
vim.keymap.set('c', "<a-'>9", function() numbered_command(9) end)
vim.keymap.set('c', "<a-'>0", function() numbered_command(10) end)

vim.keymap.set('', ',f', function() search_for_register('/', '') end)
vim.keymap.set('', ',F', function() search_for_register('?', '') end)
vim.keymap.set('', ',,f', function() search_for_register('/', '/e') end)
vim.keymap.set('', ',,F', function() search_for_register('?', '?e') end)
vim.keymap.set('x', '*', function() Search_for_selection('/', '') end)
vim.keymap.set('x', ',*', function() Search_for_selection('/', '/e') end)
vim.keymap.set('x', '#', function() Search_for_selection('?', '') end)
vim.keymap.set('x', ',#', function() Search_for_selection('?', '?e') end)

vim.keymap.set('n', "'R", killring_push_tail)
vim.keymap.set('n', "'r", killring_push)
vim.keymap.set('n', "'E", killring_pop_tail)
vim.keymap.set('n', "'e", killring_pop)
vim.keymap.set('i', "<a-'>E", function() killring_pop_tail(true) end)
vim.keymap.set('i', "<a-'>e", function() killring_pop(true) end)
vim.keymap.set('c', "<a-'>E", function() killring_pop_tail('command') end)
vim.keymap.set('c', "<a-'>e", function() killring_pop('command') end)
vim.keymap.set({ 'n', 'x' }, "'t", killring_compile)
vim.keymap.set({ 'n', 'x' }, "'T", killring_compile_reversed)

