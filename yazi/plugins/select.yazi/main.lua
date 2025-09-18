return {
	entry = function(_, job)
		local title = job.args and job.args[1] or 'Input:'

		local value, event = ya.input({
			title = title,
			pos = { "top-center", x = 0, y = 2, w = 50, h = 3 },
		})

		if event ~= 1 then
			local file = io.open('/home/axlefublr/.cache/mine/yazi-input', 'w')
			if file then
				file:write('')
				file:close()
			end
			return
		end

		local file = io.open('/home/axlefublr/.cache/mine/yazi-input', 'w')
		if file then
			file:write(value)
			file:close()
		end
	end,
}
