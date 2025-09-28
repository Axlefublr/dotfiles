--- @sync entry
return {
	entry = function()
		if cx.active.mode.is_unset then
			ya.emit('escape', { visual = true })
		else
			ya.emit('visual_mode', { unset = true })
		end
	end,
}
