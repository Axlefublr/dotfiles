local opts_table = {
	signcolumn = false, -- Toggle with `:Gitsigns toggle_signs`
	numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		follow_files = true,
	},
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
		border = env.borders,
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1,
	},
	diff_opts = {
		vertical = true,
	},
	on_attach = function(bufnr)
		local pkg = package.loaded.gitsigns

		local function map(mode, trigger, result, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, trigger, result, opts)
		end

		local function schedule_repeat(func)
			for _ = 1, vim.v.count1 do
				vim.schedule(func)
			end
		end

		map({ 'n', 'x' }, ']d', function() schedule_repeat(pkg.next_hunk) end)
		map({ 'n', 'x' }, '[d', function() schedule_repeat(pkg.prev_hunk) end)

		map('n', '<Leader>cj', pkg.stage_hunk)
		map('n', '<Leader>ck', pkg.undo_stage_hunk)
		map('x', '<Leader>cj', function() pkg.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
		map('n', '<Leader>cJ', pkg.stage_buffer)
		map('n', '<Leader>cK', pkg.reset_buffer_index)

		map('n', '<Leader>cr', pkg.reset_hunk)
		map('x', '<Leader>cr', function() pkg.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
		map('n', '<Leader>cR', pkg.reset_buffer)

		map('n', '<Leader>ci', pkg.preview_hunk_inline)
		map(
			'n',
			'<Leader>cI',
			function() -- calling it twice makes the floating window take focus, rather than disappear on my next move
				pkg.preview_hunk()
				pkg.preview_hunk()
			end
		)

		map('n', '<Leader>cs', ':Gitsigns show ')
		map('n', '<Leader>cd', ':Gitsigns diffthis ')

		map({ 'o', 'x' }, 'id', ':<C-U>Gitsigns select_hunk<CR>')
	end,
}

---@type LazyPluginSpec
return {
	'lewis6991/gitsigns.nvim',
	event = 'User WayAfter',
	opts = opts_table,
}
