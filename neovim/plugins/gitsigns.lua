return {
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			local gs = require('gitsigns')
			gs.setup({
				signs = {
					add = { text = '│' },
					change = { text = '│' },
					delete = { text = '_' },
					topdelete = { text = '‾' },
					changedelete = { text = '~' },
					untracked = { text = '┆' },
				},
				signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
				numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					follow_files = true,
				},
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
				current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = 'single',
					style = 'minimal',
					relative = 'cursor',
					row = 0,
					col = 1,
				},
				yadm = {
					enable = false,
				},
			})

			local function schedule_repeat(func)
				for _ = 1, vim.v.count1 do
					vim.schedule(func)
				end
			end

			vim.keymap.set('n', ']e', function() schedule_repeat(gs.next_hunk) end)
			vim.keymap.set('n', '[e', function() schedule_repeat(gs.prev_hunk) end)

			vim.keymap.set('n', ',gj', gs.stage_hunk)
			vim.keymap.set('n', ',gk', gs.undo_stage_hunk)
			vim.keymap.set(
				'v',
				',gj',
				function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end
			)
			vim.keymap.set('n', ',gJ', gs.stage_buffer)

			vim.keymap.set('n', ',gr', gs.reset_hunk)
			vim.keymap.set(
				'v',
				',gr',
				function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end
			)
			vim.keymap.set('n', ',gR', gs.reset_buffer)

			vim.keymap.set('n', ',gi', gs.preview_hunk_inline)
			vim.keymap.set('n', ',gI', function()
				gs.preview_hunk()
				gs.preview_hunk()
			end)
		end,
	},
}
