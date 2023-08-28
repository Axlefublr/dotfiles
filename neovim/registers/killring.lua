local killring = setmetatable({}, {__index = table})

local function killring_push_tail()
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		print("default register is empty")
		return
	end
	killring:insert(1, register_contents)
	print("pushed")
end
Map("n", "'R", killring_push_tail)

local function killring_push()
	local register_contents = vim.fn.getreg('"')
	if register_contents == '' then
		print("default register is empty")
		return
	end
	killring:insert(register_contents)
	print("pushed")
end
Map("n", "'r", killring_push)

local function killring_pop_tail()
	if #killring <= 0 then
		print("killring empty")
		return
	end
	local first_index = killring:remove(1)
	vim.fn.setreg('"', first_index)
	print("got tail")
end
Map("n", "'E", killring_pop_tail)

local function killring_pop()
	if #killring <= 0 then
		print("killring empty")
		return
	end
	local first_index = killring:remove(#killring)
	vim.fn.setreg('"', first_index)
	print("got nose")
end
Map("n", "'e", killring_pop)

local function killring_kill()
	killring = setmetatable({}, { __index = table })
	print("ring killed")
end
Map({"n", "v"}, ",z", killring_kill)

local function killring_compile()
	local compiled_killring = killring:concat('')
	vim.fn.setreg('"', compiled_killring)
	killring = setmetatable({}, { __index = table })
	print("killring compiled")
end
Map({"n", "v"}, "'t", killring_compile)

local function killring_compile_reversed()
	local reversed_killring = ReverseTable(killring)
	local compiled_killring = reversed_killring:concat('')
	vim.fn.setreg('"', compiled_killring)
	killring = setmetatable({}, { __index = table })
	print("killring compiled in reverse")
end
Map({"n", "v"}, "'T", killring_compile_reversed)