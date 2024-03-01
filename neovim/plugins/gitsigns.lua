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
				attach_to_untracked = true,
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
				diff_opts = {
					vertical = true,
				},
				on_attach = function()
					local pkg = package.loaded.gitsigns

					local function map(mode, trigger, result, opts)
						opts = opts or {}
						opts.buffer = true
						vim.keymap.set(mode, trigger, result, opts)
					end

					local function schedule_repeat(func)
						for _ = 1, vim.v.count1 do
							vim.schedule(func)
						end
					end

					map('n', ']e', function() schedule_repeat(pkg.next_hunk) end)
					map('n', '[e', function() schedule_repeat(pkg.prev_hunk) end)

					map('n', ',cj', pkg.stage_hunk)
					map('n', ',ck', pkg.undo_stage_hunk)
					map(
						'v',
						',cj',
						function() pkg.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end
					)
					map('n', ',cJ', pkg.stage_buffer)
					map('n', ',cK', pkg.reset_buffer_index)

					map('n', ',cr', pkg.reset_hunk)
					map(
						'v',
						',cr',
						function() pkg.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end
					)
					map('n', ',cR', pkg.reset_buffer)

					map('n', ',ci', pkg.preview_hunk_inline)
					map(
						'n',
						',cI',
						function() -- calling it twice makes the floating window take focus, rather than disappear on my next move
							pkg.preview_hunk()
							pkg.preview_hunk()
						end
					)

					map('n', ',cs', ':Gitsigns show ')
					map('n', ',cd', ':Gitsigns diffthis ')
				end,
			})
		end,
	},
}
