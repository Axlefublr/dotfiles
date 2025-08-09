return {
	entry = function(_, _)
		local value, event = ya.input({
			title = "Zoxide:",
			position = { "top-center", x = 0, y = 2, w = 50, h = 3 },
		})

		if event ~= 1 then return end

		local output, _ = Command('fish')
		:arg({ '-c', 'z ' .. value .. ' ; echo -n $PWD' })
		:output()

		local path = output and output.stdout
		ya.emit('cd', { path })
	end,
}
