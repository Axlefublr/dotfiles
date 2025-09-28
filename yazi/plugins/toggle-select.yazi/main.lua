--- @sync entry
return {
	entry = function()
		if cx.active.mode.is_select then
			ya.emit('escape', { visual = true })
		else
			ya.emit('visual_mode', {})
		end
	end,
}
