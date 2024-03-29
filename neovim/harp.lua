local function ensure_dir_exists(path)
	local stat = vim.loop.fs_stat(path)
	if not stat then
		vim.loop.fs_mkdir(path, 511) -- 511 corresponds to octal 0777
	elseif stat.type ~= 'directory' then
		error(path .. ' is not a directory')
	end
end

local function harp_set()
	local dir = vim.fn.expand('~/.local/share/harp')
	ensure_dir_exists(dir)
	local register = Get_char('harp: ')
	if register == nil then return end
	local full_path = Curr_buff_full_path()
	local file = io.open(dir .. '/' .. register, 'w')
	if file then
		file:write(full_path)
		file:close()
		print('prah ' .. register)
	end
end
vim.keymap.set('n', ',S', harp_set)

local function harp_get(edit_command)
	local dir = vim.fn.expand('~/.local/share/harp')
	ensure_dir_exists(dir)
	local register = Get_char('harp: ')
	if register == nil then return end
	local file = io.open(dir .. '/' .. register, 'r')
	if file then
		local output = file:read('l')
		if #output > 0 then
			vim.cmd((edit_command or 'edit') .. ' ' .. output)
			print('harp ' .. register)
		else
			print(register .. ' is empty')
		end
		file:close()
	else
		print(register .. ' is empty')
	end
end
vim.keymap.set('n', ',s', harp_get)
