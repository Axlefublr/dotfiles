return {
	entry = function(_, job)
		local value, event = ya.input({
			title = "Shell:",
			position = { "top-center", x = 0, y = 2, w = 50, h = 3 },
		})

		local file = io.open('/tmp/cami-yazi-command', 'w')
		if file then
			file:write(value)
			file:close()
		end

		if event == 1 then
			ya.emit('shell', {
				'consume.rs /tmp/cami-yazi-command | sd "%%" "(blammo)" | fish',
				block = false,
				orphan = false,
				confirm = true,
			})
		end
	end,
}
