local m = {}
-- ════════════════════════════════════════════ internal ════════════════════════════════════════════

local function get_buffer_cwd()
	local buffer = vim.api.nvim_buf_get_name(0)
	local parent = vim.fn.fnamemodify(buffer, ':h')
	return parent
end

local function harp_cd_get()
	local register = require('harp').get_char('get cd harp: ')
	if not register then return end
	local harp = require('harp').cd_get_path(register)
	return harp
end

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ public ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

function m.live_grep_with_args()
	local input = env.input('rg: ')
	if not input then return end

	local special_flags = { '%', ':' }
	local special_flag = nil
	local first_char = input:sub(1, 1)
	if table.contains(special_flags, first_char) then
		special_flag = first_char
		input = input:sub(2)
	end

	local default_args = { '--hidden' }
	local passed_args = input:split('\\s\\+')
	local args = vim.list_extend(passed_args, default_args)

	---@type function
	local picker = require('telescope.builtin').live_grep
	local picker_args = {
		additional_args = args,
	}

	if special_flag == '%' then
		picker_args.search_dirs = { vim.api.nvim_buf_get_name(0) }
		picker_args.path_display = function() return '' end
	elseif special_flag == ':' then
		picker_args.use_regex = true
		picker_args.word_match = '-w'
		-- I do this silly concatenation so that rg won't match this implementation
		picker_args.search = 'TO' .. 'DO|MO' .. 'VE|FI' .. 'XME'
		picker = require('telescope.builtin').grep_string
	end
	picker(picker_args)
end

function m.interactive_comment_box()
	local command = 'CB'
	local mode = vim.fn.mode()
	if mode == 'n' then
		command = command .. 'l'
		local prompt = { prompt = ' Alignment ' }
		local options = { 'left', 'center' }
		vim.ui.select(options, prompt, function(
			item --[[@as string]],
			index
		)
			if not index then return end
			command = command .. item:sub(1, 1) .. 'line'
			local prompt = { prompt = ' Style ' }
			local styles = {
				{ '─── title ───────', 1 },
				{ '┌── title ───────', 4 },
				{ '└── title ───────', 5 },
				{ '━━━ title ━━━━━━━', 9 },
				{ '════ title ══════', 13 },
			}
			mapped_styles = {}
			for index, value in ipairs(styles) do
				table.insert(mapped_styles, {
					value[1],
					function()
						command = command .. value[2]
						require('comment-box')
						vim.cmd(command)
					end,
				})
			end
			env.select(mapped_styles, prompt)
		end)
	elseif mode == 'v' or mode == 'V' then
		local prompt = { prompt = ' Alignment ' }
		local alignment = { 'left', 'center' }
		vim.ui.select(alignment, prompt, function(item, index)
			if not index then return end
			command = command .. item:sub(1, 1) .. 'abox'
			local prompt = { prompt = ' Style ' }
			local styles = {
				{ '┌────────────────', 2 },
				{ '┏━━━━━━━━━━━━━━━━', 3 },
				{ '╔════════════════', 7 },
				{ '┌               ┐', 18 },
			}
			mapped_styles = {}
			for _, value in ipairs(styles) do
				table.insert(mapped_styles, {
					value[1],
					function()
						command = command .. value[2]
						require('comment-box')
						vim.cmd(command)
					end,
				})
			end
			env.select(mapped_styles, prompt)
		end)
	end
end

function m.kitty_blank() -- Kitty blank
	local cmd = { 'kitten', '@', 'launch' }
	local extendor = {}
	local cwds = {
		{
			'Here',
			function()
				vim.list_extend(cmd, { '--cwd', vim.fn.getcwd() })
				vim.list_extend(cmd, extendor)
				env.shell(cmd)
			end,
		},
		{
			'Harp',
			function()
				local dir = harp_cd_get()
				if not dir then return end
				vim.list_extend(cmd, { '--cwd', dir })
				vim.list_extend(cmd, extendor)
				env.shell(cmd)
			end,
		},
		{
			'Buffer',
			function()
				vim.list_extend(
					cmd,
					{ '--cwd', vim.bo.filetype == 'oil' and require('oil').get_current_dir() or get_buffer_cwd() }
				)
				vim.list_extend(cmd, extendor)
				env.shell(cmd)
			end,
		},
		{
			'~',
			function()
				vim.list_extend(cmd, { '--cwd', '~' })
				vim.list_extend(cmd, extendor)
				env.shell(cmd)
			end,
		},
	}
	local app = {
		{
			'Terminal',
			function() env.select(cwds, { prompt = ' Directory ' }) end,
		},
		{
			'Neovim',
			function()
				extendor = { '--hold', 'nvim' }
				env.select(cwds, { prompt = ' Directory ' })
			end,
		},
	}
	local typ = {
		{
			'Tab',
			function()
				vim.list_extend(cmd, { '--type', 'tab' })
				env.select(app, { prompt = ' Directory ' })
			end,
		},
		{
			'Window',
			function()
				vim.list_extend(cmd, { '--type', 'window' })
				env.select(app, { prompt = ' Directory ' })
			end,
		},
	}
	env.select(typ, { prompt = ' Type ' })
end

---@param should_scream boolean|'only_errors'|nil
function m.exec_in_shell(should_scream)
	local input = env.input({ '󱕅 ', env.high({ fg = env.color.shell_yellow }) }, nil, 'shellcmd')
	if not input then return end

	local args = { 'fish', '-c', input }
	if should_scream == false then
		env.shell(args)
	elseif should_scream == 'only_errors' then
		env.shell_display(args, { only_errors = true })
	else
		env.shell_display(args)
	end
end

return m
