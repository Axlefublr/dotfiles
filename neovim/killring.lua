local killring = setmetatable({}, {__index = table})

local function killring_push()
	local register_contents = vim.fn.getreg('"')
	killring:insert(register_contents)
end
Map("n", "<leader>z", killring_push)

local function killring_pop_tail()
	if #killring <= 0 then
		print("killring empty!")
		return
	end
	local first_index = killring:remove(1)
	vim.fn.setreg('"', first_index)
end
Map("n", "<leader>x", killring_pop_tail)