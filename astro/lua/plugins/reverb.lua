return {
	'whleucka/reverb.nvim',
	event = 'VeryLazy',
	opts = {
		sounds = {
			-- `!` means "I want this, but don't have a good enough sound effect", `?` means "the event happens when you don't expect it, making it non-viable to use", `#` means "conflicts with another event that often occures together with that one"
			--! ExitPre = { path = env.soundeffects .. 'minimize_009.ogg', volume = 65 },
			--! RecordingEnter = { path = env.soundeffects .. 'maximize_003.ogg', volume = 60 },
			--! RecordingLeave = { path = env.soundeffects .. 'minimize_003.ogg', volume = 60 },
			--! VimEnter = { path = env.soundeffects .. 'maximize_009.ogg', volume = 65 },
			--# TextChanged = { path = env.soundeffects .. 'drop_004.ogg', volume = 65 },
			--# TextYankPost = { path = env.soundeffects .. 'drop_001.ogg', volume = 65 },
			--# WinNew = { path = env.soundeffects .. 'glass_004.ogg', volume = 50 },
			--? BufEnter = { path = env.soundeffects .. 'drop_004.ogg', volume = 90 },
			--? CmdLineEnter = { path = env.soundeffects .. 'bloop-4.mp3', volume = 65 },
			--? CmdLineLeave = { path = env.soundeffects .. 'glass_002.ogg', volume = 65 },
			--? InsertCharPre = { path = env.soundeffects .. 'audio-volume-change.oga', volume = 65 },
			--? InsertLeave = { path = env.soundeffects .. 'drop_002.ogg', volume = 65 },
			--? WinClosed = { path = env.soundeffects .. 'error_005.ogg', volume = 60 },
			BufWritePost = { path = env.soundeffects .. 'confirmation_001.ogg', volume = 60 },
			CursorMoved = { path = env.soundeffects .. 'audio-volume-change.oga', volume = 90 },
			DirChanged = { path = env.soundeffects .. 'bookFlip2.ogg', volume = 70 },
			InsertEnter = { path = env.soundeffects .. 'multi-pop-2.mp3', volume = 55 },
		},
	},
}
