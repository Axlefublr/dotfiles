local killring = setmetatable({}, {__index = table})

local function killring_push()
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		print("default register is empty")
		return
	end
	killring:insert(register_contents)
	print("pushed")
end
Map("n", "<leader>z", killring_push)

local function killring_pop_tail()
	if #killring <= 0 then
		print("killring empty!")
		return
	end
	local first_index = killring:remove(1)
	vim.fn.setreg('"', first_index)
	print("got tail")
end
Map("n", "<leader>x", killring_pop_tail)

local function killring_take_numbered(index)
	if index > #killring then
		print("no value at index!")
		return
	end
	local register_contents = killring[index]
	vim.fn.setreg('"', register_contents)
end
Map({"n", "v"}, "'1", function() killring_take_numbered(1) end)
Map({"n", "v"}, "'2", function() killring_take_numbered(2) end)
Map({"n", "v"}, "'3", function() killring_take_numbered(3) end)
Map({"n", "v"}, "'4", function() killring_take_numbered(4) end)
Map({"n", "v"}, "'5", function() killring_take_numbered(5) end)
Map({"n", "v"}, "'6", function() killring_take_numbered(6) end)
Map({"n", "v"}, "'7", function() killring_take_numbered(7) end)
Map({"n", "v"}, "'8", function() killring_take_numbered(8) end)
Map({"n", "v"}, "'9", function() killring_take_numbered(9) end)
Map({"n", "v"}, "'0", function() killring_take_numbered(0) end)

local function killring_replace_numbered(index)
	if index > #killring then
		print("no value at index!")
		return
	end
	local default_contents = vim.fn.getreg('"')
	killring[index] = default_contents
end
Map({"n", "v"}, "<leader>'1", function() killring_replace_numbered(1) end)
Map({"n", "v"}, "<leader>'2", function() killring_replace_numbered(2) end)
Map({"n", "v"}, "<leader>'3", function() killring_replace_numbered(3) end)
Map({"n", "v"}, "<leader>'4", function() killring_replace_numbered(4) end)
Map({"n", "v"}, "<leader>'5", function() killring_replace_numbered(5) end)
Map({"n", "v"}, "<leader>'6", function() killring_replace_numbered(6) end)
Map({"n", "v"}, "<leader>'7", function() killring_replace_numbered(7) end)
Map({"n", "v"}, "<leader>'8", function() killring_replace_numbered(8) end)
Map({"n", "v"}, "<leader>'9", function() killring_replace_numbered(9) end)
Map({"n", "v"}, "<leader>'0", function() killring_replace_numbered(0) end)

local function killring_kill()
	local compiled_killring = killring:concat('')
	local should_kill = vim.fn.input(compiled_killring)
	if should_kill == '' then print("aborted") return end
	killring = setmetatable({}, { __index = table })
	print("ring killed!")
end
Map({"n", "v"}, "<leader>Z", killring_kill)

local function killring_compile()
	local compiled_killring = killring:concat('')
	local should_compile = vim.fn.input(compiled_killring)
	if should_compile == '' then print("aborted") return end
	vim.fn.setreg('"', compiled_killring)
	killring = setmetatable({compiled_killring}, { __index = table })
	print("killring compiled!")
end
Map({"n", "v"}, "<leader>X", killring_compile)