local killring = setmetatable({}, { __index = table })

local function trim_trailing_whitespace()
	local search = vim.fn.getreg('/')
	---@diagnostic disable-next-line: param-type-mismatch
	pcall(vim.cmd, 'silent %s`\\v\\s+$')
	vim.fn.setreg('/', search)
end

local function save(and_format)
	trim_trailing_whitespace()
	vim.cmd.nohlsearch()
	if and_format == true then require('conform').format({ async = false, lsp_format = 'fallback' }) end
	if type(and_format) == 'string' then vim.cmd('silent ' .. and_format) end
	---@diagnostic disable-next-line: param-type-mismatch
	vim.cmd.mkview({ mods = { emsg_silent = true } })
	pcall(vim.cmd, 'silent update')
end

local function close_try_save()
	---@diagnostic disable-next-line: param-type-mismatch
	pcall(vim.cmd, 'silent update')
	vim.cmd('q!')
end

local function move_to_blank_line(to_next)
	local search_opts = to_next and '' or 'b'
	vim.fn.search('^\\s*$', search_opts)
end

local function edit_magazine()
	local register = env.char('magazine: ')
	if register == nil then return end
	vim.cmd('edit ' .. vim.fn.expand('~/.local/share/magazine/') .. register)
end

local function copy_full_path()
	local full_path = vim.fn.expand('%:~')
	vim.fn.setreg(env.default_register, full_path)
	vim.notify('full path: ' .. full_path)
end

local function copy_file_name()
	local file_name = vim.fn.expand('%:t')
	vim.fn.setreg(env.default_register, file_name)
	vim.notify('name: ' .. file_name)
end

local function copy_cwd_relative()
	local relative_path = vim.fn.expand('%:p:.')
	vim.fn.setreg(env.default_register, relative_path)
	vim.notify('cwd relative: ' .. relative_path)
end

local function get_repo_root()
	local head = vim.fn.expand('%:h'):trim()
	if head == '' then head = vim.fn.getcwd() end
	local result = env.shell({ 'git', 'rev-parse', '--show-toplevel' }, { cwd = head }):wait()
	if result.code ~= 0 then return end
	return result.stdout:trim()
end

local function get_repo_relative()
	local full_path = vim.api.nvim_buf_get_name(0)
	local git_root = get_repo_root()
	local relative_path = string.gsub(full_path, '^' .. git_root .. '/', '')
	return relative_path
end

local function copy_git_relative()
	local relative_path = get_repo_relative()
	vim.fn.setreg(env.default_register, relative_path)
	vim.notify('repo relative:\n' .. relative_path)
end

local function ghl_file()
	local relative_path = get_repo_relative()
	local output = env.shell({ 'ghl', relative_path }):wait()
	if output.code ~= 0 then
		vim.notify('ghl brokie 😭')
		return
	end
	local link = output.stdout:trim()
	vim.fn.setreg(env.default_register, link, 'c')
	vim.notify('ghl buffer:\n' .. link)
end

local function get_ghl_lines()
	local selection_start_line = vim.fn.line('v')
	local cursor_line = vim.fn.line('.')
	local start_line
	local end_line
	if cursor_line > selection_start_line then
		start_line = selection_start_line
		end_line = cursor_line
	else
		start_line = cursor_line
		end_line = selection_start_line
	end
	return '#L' .. start_line .. '-L' .. end_line
end

local function ghl_file_visual()
	local relative_path = get_repo_relative()
	local output = env.shell({ 'ghl', relative_path }):wait()
	if output.code ~= 0 then
		vim.notify('ghl brokie 😭')
		return
	end
	local full_link = output.stdout:trim() .. get_ghl_lines()
	vim.fn.setreg(env.default_register, full_link, 'c')
	vim.notify('ghl buffer lined:\n' .. full_link)
end

local function ghl_file_head()
	local relative_path = get_repo_relative()
	local output = env.shell({ 'ghl', '-pb', 'head', relative_path }):wait()
	if output.code ~= 0 then
		vim.notify('ghl brokie 😭')
		return
	end
	local link = output.stdout:trim()
	vim.fn.setreg(env.default_register, link, 'c')
	vim.notify('ghl buffer head:\n' .. link)
end

local function ghl_file_head_visual()
	local relative_path = get_repo_relative()
	local output = env.shell({ 'ghl', '-pb', 'head', relative_path }):wait()
	if output.code ~= 0 then
		vim.notify('ghl brokie 😭')
		return
	end
	local link = output.stdout:trim() .. get_ghl_lines()
	vim.fn.setreg(env.default_register, link, 'c')
	vim.notify('ghl buffer head lined:\n' .. link)
end

local function ghl_repo()
	local output = env.shell({ 'ghl' }):wait()
	if output.code ~= 0 then
		vim.notify('ghl brokie 😭')
		return
	end
	vim.fn.setreg(env.default_register, output.stdout:trim(), 'c')
	vim.notify('ghl repo: ' .. output.stdout)
end

local function copy_cwd()
	local cwd = vim.fn.getcwd()
	cwd = vim.fn.fnamemodify(cwd, ':~')
	vim.fn.setreg(env.default_register, cwd)
	vim.notify('cwd: ' .. cwd)
end

local function killring_push_tail()
	local register_contents = vim.fn.getreg(env.default_register)
	if register_contents == '' then
		vim.notify('default register is empty')
		return
	end
	killring:insert(1, register_contents)
	vim.notify('pushed')
end

local function killring_push()
	local register_contents = vim.fn.getreg(env.default_register)
	if register_contents == '' then
		vim.notify('default register is empty')
		return
	end
	killring:insert(register_contents)
	vim.notify('pushed')
end

local function killring_pop_tail(insert)
	if #killring <= 0 then
		vim.notify('killring empty')
		return
	end
	local first_index = killring:remove(1)
	vim.fn.setreg(env.default_register, first_index)
	if insert then
		if insert == 'command' then
			env.feedkeys_int('<C-r>' .. env.default_register)
		else
			env.feedkeys_int('<C-r><C-p>' .. env.default_register)
		end
	else
		vim.notify('got tail')
	end
end

local function killring_pop(insert)
	if #killring <= 0 then
		vim.notify('killring empty')
		return
	end
	local first_index = killring:remove(#killring)
	vim.fn.setreg(env.default_register, first_index)
	if insert then
		if insert == 'command' then
			env.feedkeys_int('<C-r>' .. env.default_register)
		else
			env.feedkeys_int('<C-r><C-p>' .. env.default_register)
		end
	else
		vim.notify('got nose')
	end
end

local function killring_compile()
	local compiled_killring = killring:concat('')
	vim.fn.setreg(env.default_register, compiled_killring)
	killring = setmetatable({}, { __index = table })
	vim.notify('killring compiled')
end

local function killring_compile_reversed()
	local reversed_killring = table.reverse(killring)
	local compiled_killring = reversed_killring:concat('')
	vim.fn.setreg(env.default_register, compiled_killring)
	killring = setmetatable({}, { __index = table })
	vim.notify('killring compiled in reverse')
end

local function numbered_get(index, insert)
	local index = index - 1
	local result = os.execute('copyq read ' .. index .. ' | xclip -selection clipboard')
	if result and not insert then
		vim.notify('got ' .. index)
	elseif not insert then
		vim.notify('failed getting ' .. index)
	end
	if insert then
		if insert == 'command' then
			env.feedkeys_int('<C-r>+')
		else
			env.feedkeys_int('<C-r><C-p>+')
		end
	end
end

local function numbered_insert(index) numbered_get(index, true) end
local function numbered_command(index) numbered_get(index, 'command') end

local function harp_cd_get()
	local register = require('harp').get_char('get cd harp: ')
	if not register then return end
	local harp = require('harp').cd_get_path(register)
	return harp
end

local function get_buffer_cwd()
	local buffer = vim.api.nvim_buf_get_name(0)
	local parent = vim.fn.fnamemodify(buffer, ':h')
	return parent
end

local function execute_this_file()
	local filetype = vim.bo.filetype
	if filetype == 'lua' then
		save()
		vim.cmd('source')
		return
	end
	save(true)
	local repo = get_repo_root()
	local file = vim.fn.expand('%')
	local command = { 'kitten', '@', 'launch', '--type', 'overlay-main', '--cwd', repo, '--hold' }
	local run = function(diag_command, opts) env.shell(vim.list_extend(command, diag_command), opts):wait() end
	if filetype == 'rust' then
		local edited_command = env.input('run: ', 'cargo run -- ')
		if not edited_command then return end
		run(vim.fn.split(edited_command))
	elseif filetype == 'python' then
		run({ 'python', file })
	elseif filetype == 'nim' then
		run({ 'nimble', 'run' })
	else
		run({ file })
	end
end

local function diag_this_file()
	save(true)
	local repo = get_repo_root()
	local extension = vim.fn.expand('%:e')
	local command = { 'kitten', '@', 'launch', '--type', 'overlay-main', '--cwd', repo, '--hold' }
	local diag = function(diag_command) env.shell(vim.list_extend(command, diag_command)):wait() end
	if extension == 'rs' then
		diag({ 'cargo', 'clippy', '-q' })
	else
		vim.notify('extension ' .. extension .. 'is not recognized')
	end
end

local function interactive_setenv()
	local options = {
		RUST_LOG = {
			'trace',
			'debug',
			'info',
			'warn',
			'error',
		},
	}
	local env_var_options = {}
	for key, _ in pairs(options) do
		table.insert(env_var_options, key)
	end
	local env_var = env.confirm_same('', env_var_options)
	if not env_var then return end
	local env_value = env.confirm_same('', options[env_var])
	if not env_value then return end
	vim.fn.setenv(env_var, env_value)
	vim.notify('set ' .. env_var .. '=' .. env_value)
end

local function open_link_in_instance(index)
	local index = (index or 1) - 1
	require('various-textobjs').url()

	-- plugin only switches to visual mode when textobj found
	local foundURL = vim.fn.mode():find('v')

	-- if not found, search whole buffer via urlview.nvim instead
	if not foundURL then
		vim.cmd.UrlView('buffer')
		return
	end

	local previous_clipboard = vim.fn.getreg(env.default_register)
	vim.cmd.normal({ 'y', bang = true })
	local url = vim.fn.getreg()
	vim.fn.setreg(env.default_register, previous_clipboard)

	env.shell({ 'wmctrl', '-s', index }):wait()
	local openCommand = string.format("xdg-open '%s' >/dev/null 2>&1", url)
	os.execute(openCommand)
end

---@param action_type 'lsp'|'selection'
local function change_case(prompt, action_type)
	local function textcase_action(case, action_type)
		if action_type == 'selection' then
			local text = env.get_inline_selection()[1]
			local converted = require('textcase').api[case](text)
			env.replace_inline_selection(converted)
			env.feedkeys_int('<Esc>')
		elseif action_type == 'lsp' then
			require('textcase').lsp_rename(case)
		end
	end
	local options = {
		{
			'UPPERCASE',
			function() textcase_action('to_upper_case', action_type) end,
		},
		{
			'lowercase',
			function() textcase_action('to_lower_case', action_type) end,
		},
		{
			'snake_case',
			function() textcase_action('to_snake_case', action_type) end,
		},
		{
			'dash-case',
			function() textcase_action('to_dash_case', action_type) end,
		},
		{
			'CONSTANT_CASE',
			function() textcase_action('to_constant_case', action_type) end,
		},
		{
			'camelCase',
			function() textcase_action('to_camel_case', action_type) end,
		},
		{
			'PascalCase',
			function() textcase_action('to_pascal_case', action_type) end,
		},
		{
			'dot.case',
			function() textcase_action('to_dot_case', action_type) end,
		},
		{
			'path/case',
			function() textcase_action('to_path_case', action_type) end,
		},
		{
			'Title Case',
			function() textcase_action('to_title_case', action_type) end,
		},
		{
			'Phrase case',
			function() textcase_action('to_phrase_case', action_type) end,
		},
		{
			'UPPER PHRASE',
			function() textcase_action('to_upper_phrase_case', action_type) end,
		},
		{
			'lower phrase',
			function() textcase_action('to_lower_phrase_case', action_type) end,
		},
	}
	return env.select(options, { prompt = prompt })
end

local function kitty_blank() -- Kitty blank
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
				vim.list_extend(cmd, { '--cwd', vim.bo.filetype == 'oil' and require('oil').get_current_dir() or get_buffer_cwd() })
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
	local typ = {
		{
			'Tab',
			function()
				vim.list_extend(cmd, { '--type', 'tab' })
				env.select(cwds, { prompt = ' Directory ' })
			end,
		},
		{
			'Window',
			function()
				vim.list_extend(cmd, { '--type', 'window' })
				env.select(cwds, { prompt = ' Directory ' })
			end,
		},
		{
			'NeoTab',
			function()
				vim.list_extend(cmd, { '--type', 'tab' })
				extendor = { '--hold', 'nvim' }
				env.select(cwds, { prompt = ' Directory ' })
			end,
		},
		{
			'NeoWindow',
			function()
				vim.list_extend(cmd, { '--type', 'window' })
				extendor = { '--hold', 'nvim' }
				env.select(cwds, { prompt = ' Directory ' })
			end,
		},
	}
	env.select(typ, { prompt = ' Type ' }) -- TODO: from last to first questions, and you just modify the table in this cool confusing way
end

-- local function store_andor_use_count(what)
-- 	if vim.v.count > 0 then
-- 		vim.g.stored_count_shared = vim.v.count
-- 		return what
-- 	else
-- 		return (vim.g.stored_count_shared or 1) .. what
-- 	end
-- end

local function count_repeats_keys(keys)
	for _ = 1, vim.v.count1 do
		env.feedkeys_int(keys)
	end
end

---@param closure function
local function count_repeats(closure)
	for _ = 1, vim.v.count1 do
		closure()
	end
end

-- end of functions

local normal_mappings = {
	['<Leader>de'] = copy_git_relative,
	['<Leader>dE'] = ghl_file,
	['<Leader>dq'] = copy_full_path,
	['<Leader>dr'] = copy_cwd_relative,
	['<Leader>dR'] = ghl_file_head,
	['<Leader>dw'] = copy_file_name,
	['<Leader>dt'] = copy_cwd,
	['<Leader>dT'] = ghl_repo,

	["'e"] = killring_pop,
	["'E"] = killring_pop_tail,
	["',"] = killring_push,
	["'<"] = killring_push_tail,
	["']"] = killring_compile,
	["'["] = killring_compile_reversed,

	-- System
	['<Leader>K'] = function() vim.cmd('q!') end,
	['<Leader>dm'] = '<Cmd>messages<CR>',
	['<Leader>ds'] = edit_magazine,
	['<Space>'] = save,
	['d<Space>'] = function() save(true) end,
	['c<Space>'] = function() save('sort') end,
	K = close_try_save,

	-- Fixes
	['<Esc>'] = function()
		vim.cmd('noh')
		require('notify').dismiss()
		env.feedkeys_int('<Esc>')
	end,
	['.'] = function() count_repeats_keys('.') end,
	yie = function() vim.cmd('%y+') end,

	-- Features
	gW = function() change_case(' LSP convert ', 'lsp') end,
	gQ = function()
		local parent = vim.fn.expand('%:h')
		vim.cmd.tcd(parent)
		local repo_root = get_repo_root()
		if repo_root then vim.cmd.tcd(repo_root) end
	end,
	['<Leader>P'] = '<Cmd>pu!<CR>',
	['<Leader>di'] = '"_ddddpk==^', -- Push line of code after block into block
	['<Leader>dl'] = '^D"_dd',
	['<Leader>do'] = 'dd<Cmd>$pu<CR>',
	['<Leader>du'] = 'dd<Cmd>0pu!<CR>',
	['<Leader>p'] = '<Cmd>pu<CR>',
	['@'] = function() env.feedkeys('yl' .. vim.v.count1 .. 'p') end,
	['z?'] = '<CMD>execute "normal! " . rand() % line(\'$\') . "G"<CR>',
	du = '"_dddd',
	gJ = '0d^kgJ', -- Join current line with the next line with no space in between, *also* discarding any leading whitespace of the next line. Because gJ would include indentation. Stupidly.
	dr = function()
		local path = vim.api.nvim_buf_get_name(0)
		env.shell({ 'xdg-open', path })
	end,
	cc = function() open_link_in_instance(2) end,
	cC = function() open_link_in_instance(7) end,

	-- Toggles
	['zs'] = function()
		local options = {
			{
				'Inlay hints',
				function() require('astrolsp.toggles').inlay_hints() end,
			},
			{
				'Diagnostics',
				function()
					---@diagnostic disable-next-line: undefined-field
					local used_type = 'underline'
					if vim.diagnostic.config()[used_type] then
						vim.diagnostic.config({ [used_type] = false })
						vim.notify('diags off')
					else
						vim.diagnostic.config({ [used_type] = true })
						vim.notify('diags on')
					end
				end,
			},
			{
				'Listchars',
				function() vim.opt_local.list = not vim.wo.list end,
			},
			{
				'Relative number',
				function()
					if vim.wo.relativenumber then
						vim.wo.relativenumber = false
					else
						vim.wo.relativenumber = true
					end
				end,
			},
			{
				'Foldcolumn',
				function()
					if vim.wo.foldcolumn == '1' then
						vim.wo.foldcolumn = '0'
					else
						vim.wo.foldcolumn = '1'
					end
				end,
			},
		}
		env.select(options, { prompt = ' Toggle ' })
	end,

	-- Lsp
	['gw'] = vim.lsp.buf.rename,
	['<Leader>lc'] = vim.lsp.buf.code_action,
	['gl'] = function()
		---@diagnostic disable-next-line: assign-type-mismatch
		vim.diagnostic.open_float({ border = env.borders, scope = 'cursor' })
		---@diagnostic disable-next-line: assign-type-mismatch
		vim.diagnostic.open_float({ border = env.borders, scope = 'cursor' })
	end,
	['gL'] = function()
		---@diagnostic disable-next-line: assign-type-mismatch
		vim.diagnostic.open_float({ border = env.borders, scope = 'buffer' })
		---@diagnostic disable-next-line: assign-type-mismatch
		vim.diagnostic.open_float({ border = env.borders, scope = 'buffer' })
	end,
	['[e'] = function()
		count_repeats(function() vim.diagnostic.goto_prev() end)
	end,
	[']e'] = function()
		count_repeats(function() vim.diagnostic.goto_next() end)
	end,
	['gh'] = function()
		vim.lsp.buf.hover()
		vim.lsp.buf.hover()
	end,
	['<Leader>cl'] = execute_this_file,
	['<Leader>lz'] = diag_this_file,
	['<Leader>le'] = interactive_setenv,

	-- Folding
	['zM'] = function() vim.wo.foldlevel = vim.v.count end,
	-- ['zM'] = function()
	-- 	vim.b.ufo_foldlevel = vim.v.count
	-- 	require('ufo').closeFoldsWith(vim.b.ufo_foldlevel)
	-- end,
	['zR'] = function() vim.wo.foldlevel = 99 end,
	-- ['zR'] = function()
	-- 	vim.b.ufo_foldlevel = 99
	-- 	require('ufo').openAllFolds()
	-- end,
	-- ['zm'] = function()
	-- 	vim.b.ufo_foldlevel = math.max(0, (vim.b.ufo_foldlevel - vim.v.count1))
	-- 	require('ufo').closeFoldsWith(vim.b.ufo_foldlevel)
	-- end,
	-- ['zr'] = function()
	-- 	vim.b.ufo_foldlevel = math.min(99, (vim.b.ufo_foldlevel + vim.v.count1))
	-- 	require('ufo').closeFoldsWith(vim.b.ufo_foldlevel)
	-- end,

	-- Git
	['<Leader>ch'] = function()
		local result = env.shell({ 'git', 'log', '--oneline', 'HEAD~7..HEAD', '--pretty=format:%s' }):wait()
		if result.code ~= 0 then return end
		local lines = result.stdout:trim():split('\n')
		vim.ui.select(lines, { prompt = ' Git Log ' }, function() end)
	end,
	['<Leader>cf'] = function()
		local result = env.shell({ 'gaf', 'print', 'new' }):wait()
		if result.code ~= 0 then
			vim.notify('gaf failed')
			return
		end
		local output = result.stdout:trim()
		if output == '' then
			vim.notify('nothing to clean')
			return
		end
		local state = {
			{ 'Jes', 'silent G clean -df' },
			{ 'Ko', nil },
		}
		local result = env.confirm(output, state)
		if not result then return end
		vim.cmd(result)
	end,
	['<Leader>cc'] = '<Cmd>silent G commit -q<CR>',
	['<Leader>cz'] = function()
		local options = {
			{
				'git add . && git commit',
				function() vim.cmd('silent Git add . | silent Git commit -q') end,
			},
			{
				'git commit -a',
				function() vim.cmd('silent Git commit -aq') end,
			},
			{
				'git commit --amend',
				function() vim.cmd('silent Git commit --amend') end,
			},
			{
				'git commit --amend --no-edit',
				function() vim.cmd('silent Git commit --amend --no-edit') end,
			},
		}
		env.select(options, { prompt = ' Commit ' })
	end,
	['<Leader>cA'] = '<Cmd>silent G add .<CR>',
	['<Leader>cU'] = '<Cmd>silent G restore --staged .<CR>',
	['cm'] = function()
		vim.opt_local.cmdheight = 1
		env.feedkeys(':Git ')
		vim.api.nvim_create_autocmd('CmdlineLeave', {
			callback = function()
				vim.opt_local.cmdheight = 0
				return true
			end,
		})
	end,
	['cM'] = function()
		vim.opt_local.cmdheight = 1
		env.feedkeys(':silent Git ')
		vim.api.nvim_create_autocmd('CmdlineLeave', {
			callback = function()
				vim.opt_local.cmdheight = 0
				return true
			end,
		})
	end,

	-- Gaf
	['<Leader>ca'] = function()
		local picked = vim.fn.confirm('Choose change type', 'Modified\nNew\nDeleted')
		if picked == 0 then return end
		if picked == 1 then
			env.shell({ 'gaf', 'stage', 'modified' }, nil, function(result)
				if result.code == 0 then
					vim.notify('stage modified')
				else
					vim.notify(result.stderr)
				end
			end)
		elseif picked == 2 then
			env.shell({ 'gaf', 'stage', 'new' }, nil, function(result)
				if result.code == 0 then
					vim.notify('stage new')
				else
					vim.notify(result.stderr)
				end
			end)
		elseif picked == 3 then
			env.shell({ 'gaf', 'stage', 'deleted' }, nil, function(result)
				if result.code == 0 then
					vim.notify('stage deleted')
				else
					vim.notify(result.stderr)
				end
			end)
		end
	end,
	['<Leader>cu'] = function()
		local picked = vim.fn.confirm('Choose change type', 'Modified\nAdded\nDeleted\nRenamed')
		if picked == 0 then
			return
		elseif picked == 1 then
			env.shell({ 'gaf', 'unstage', 'modified' }, nil, function(result)
				if result.code == 0 then
					vim.notify('unstage modified')
				else
					vim.notify(result.stderr)
				end
			end)
		elseif picked == 2 then
			env.shell({ 'gaf', 'unstage', 'added' }, nil, function(result)
				if result.code == 0 then
					vim.notify('unstage added')
				else
					vim.notify(result.stderr)
				end
			end)
		elseif picked == 3 then
			env.shell({ 'gaf', 'unstage', 'deleted' }, nil, function(result)
				if result.code == 0 then
					vim.notify('unstage deleted')
				else
					vim.notify(result.stderr)
				end
			end)
		elseif picked == 4 then
			env.shell({ 'gaf', 'unstage', 'renamed' }, nil, function(result)
				if result.code == 0 then
					vim.notify('unstage renamed')
				else
					vim.notify(result.stderr)
				end
			end)
		end
	end,

	-- Abstractions
	['dcc'] = '<Cmd>setfiletype css<CR>',
	['dcC'] = '<Cmd>e ~/t/test.css<CR>',
	['dcf'] = '<Cmd>setfiletype fish<CR>',
	['dcF'] = '<Cmd>e ~/t/test.fish<CR>',
	['dch'] = '<Cmd>setfiletype html<CR>',
	['dcH'] = '<Cmd>e ~/t/test.html<CR>',
	['dcl'] = '<Cmd>setfiletype lua<CR>',
	['dcL'] = '<Cmd>e ~/t/test.lua<CR>',
	['dca'] = '<Cmd>setfiletype man<CR>',
	['dcA'] = '<Cmd>e ~/t/test.man<CR>',
	['dcm'] = '<Cmd>setfiletype markdown<CR>',
	['dcM'] = '<Cmd>e ~/t/test.md<CR>',
	['dcp'] = '<Cmd>setfiletype python<CR>',
	['dcP'] = '<Cmd>e ~/t/test.py<CR>',
	['dct'] = '<Cmd>setfiletype text<CR>',
	['dcT'] = '<Cmd>e ~/t/test.txt<CR>',
	['dcj'] = '<Cmd>setfiletype jsonc<CR>',
	['dcJ'] = '<Cmd>e ~/t/test.jsonc<CR>',

	-- Qfetter
	['[Q'] = function() require('qfetter').another({ backwards = true, next_buffer = true }) end,
	['[q'] = function() require('qfetter').another({ backwards = true }) end,
	[']Q'] = function() require('qfetter').another({ next_buffer = true }) end,
	[']q'] = function() require('qfetter').another() end,
	["'q"] = function() require('qfetter').mark() end,
	["'Q"] = function() require('qfetter').unmark() end,
	["''q"] = function() require('qfetter').clear() end,

	-- Edister
	['<Leader>g'] = function() require('edister').move_from_one_to_another() end,
	['<Leader>G'] = function() require('edister').move_from_one_to_another(nil, nil, 'ask') end,
	['<Leader>t'] = function() require('edister').edit_register() end,
	['<Leader>T'] = function() require('edister').edit_register(nil, 'ask') end,

	-- Harp
	['<Leader>z'] = function() require('harp').cd_get() end,
	['<Leader>Z'] = function() require('harp').cd_set() end,
	['<Leader>so'] = function()
		env.shell({ 'fish', '-c', 'pjs' }):wait()
		local path = require('harp').default_get_path('o')
		vim.cmd.edit(path)
	end,
	['<Leader>s'] = function() require('harp').default_get() end,
	['<Leader>S'] = function() require('harp').default_set() end,
	['<Leader>q'] = function() require('harp').global_mark_get() end,
	['<Leader>Q'] = function() require('harp').global_mark_set() end,
	['<Leader>w'] = function() require('harp').global_search_get() end,
	['<Leader>W'] = function() require('harp').global_search_set({ ask = true }) end,
	['<Leader>e'] = function() require('harp').perbuffer_search_get() end,
	['<Leader>E'] = function() require('harp').perbuffer_search_set({ ask = true }) end,
	['<Leader>f'] = function() require('harp').filetype_search_get() end,
	['<Leader>F'] = function() require('harp').filetype_search_set({ ask = true }) end,
	['<Leader>x'] = function() require('harp').percwd_get() end,
	['<Leader>X'] = function() require('harp').percwd_set() end,
	['<Leader>r'] = function() require('harp').positional_get() end,
	['<Leader>R'] = function() require('harp').positional_set() end,
	['M'] = function() require('harp').perbuffer_mark_set() end,
	['m'] = function() require('harp').perbuffer_mark_get() end,

	-- Moving
	['#'] = function() require('lupa').word({ backwards = true }) end,
	['*'] = function() require('lupa').word() end,
	['<Leader>#'] = function() require('lupa').word({ backwards = true, edit = true }) end,
	['<Leader>*'] = function() require('lupa').word({ edit = true }) end,
	['g#'] = function() require('lupa').register(env.default_register, { backwards = true }) end,
	['g*'] = function() require('lupa').register(env.default_register) end,
	['<Leader>g#'] = function() require('lupa').register(env.default_register, { edit = true }) end,
	['<Leader>g*'] = function() require('lupa').register(env.default_register, { edit = true }) end,
	['{'] = function() move_to_blank_line(false) end,
	['}'] = function() move_to_blank_line(true) end,

	-- Window
	['<A-h>'] = '<C-w><',
	['<A-l>'] = '<C-w>>',
	['<C-n>'] = '<C-w>-',
	['<C-p>'] = '<C-w>+',
	["c'"] = '<C-w>p',
	['<Leader>ah'] = function() vim.cmd('leftabove vsplit') end,
	['<Leader>aj'] = function() vim.cmd('split') end,
	['<Leader>ak'] = function() vim.cmd('leftabove split') end,
	['<Leader>al'] = function() vim.cmd('vsplit') end,
	['<Leader>as'] = function() vim.cmd('leftabove vnew') end,
	['<Leader>af'] = function() vim.cmd('new') end,
	['<Leader>ad'] = function() vim.cmd('leftabove new') end,
	['<Leader>ag'] = function() vim.cmd('vnew') end,
	['<Leader>aa'] = function() vim.cmd('enew') end,
	['do'] = '<C-w>o',
	['co'] = '<C-w>=',
	['cu'] = '<C-w>_<C-w>|',
	["d'"] = '<C-w><C-w>',
	['[w'] = 'gT',
	[']w'] = 'gt',

	-- Telescope
	['<Leader>ja'] = function() require('telescope.builtin').find_files() end,
	['<Leader>jA'] = function()
		require('telescope.builtin').find_files({
			search_dirs = env.extra_directories,
		})
	end,
	['<Leader>jf'] = function()
		require('telescope.builtin').find_files({
			hidden = false,
			no_ignore = false,
			no_ignore_parent = false,
		})
	end,
	['<Leader>jF'] = function()
		require('telescope.builtin').find_files({
			hidden = false,
			no_ignore = false,
			no_ignore_parent = false,
			search_dirs = env.extra_directories,
		})
	end,
	['<Leader>jd'] = function() require('telescope.builtin').live_grep() end,
	['<Leader>jD'] = function()
		require('telescope.builtin').live_grep({
			search_dirs = env.extra_directories,
		})
	end,
	['<Leader>jg'] = function()
		require('telescope.builtin').live_grep({
			additional_args = {
				'--no-ignore',
				'--hidden',
			},
		})
	end,
	['<Leader>jG'] = function()
		require('telescope.builtin').live_grep({
			search_dirs = env.extra_directories,
			additional_args = {
				'--no-ignore',
				'--hidden',
			},
		})
	end,
	['<Leader>jr'] = function() require('telescope.builtin').grep_string() end,
	['<Leader>jt'] = function()
		require('telescope.builtin').grep_string({
			additional_args = {
				'--no-ignore',
				'--hidden',
			},
		})
	end,
	['<Leader>jq'] = function() require('telescope.builtin').help_tags() end,
	['d,'] = ':help ',
	['<Leader>jc'] = function() require('telescope.builtin').git_commits() end,
	['<Leader>jC'] = function() require('telescope.builtin').git_bcommits() end,
	['<Leader>jb'] = function() require('telescope.builtin').git_branches() end,
	['<Leader>jx'] = function() require('telescope.builtin').git_stash() end,
	['<Leader>je'] = function() require('telescope.builtin').git_status() end,
	['<Leader>j\\'] = function() require('telescope.builtin').builtin() end,
	['<Leader>jw'] = function() require('telescope.builtin').buffers() end,
	['<Leader>jW'] = function() require('telescope.builtin').oldfiles() end,
	['<Leader><CR>'] = function() require('telescope.builtin').command_history() end,
	['dm'] = ':Man ',
	['<Leader>ji'] = function() require('telescope.builtin').marks() end,
	['<Leader>jh'] = function() require('telescope.builtin').highlights() end,
	['<Leader>j;'] = function() require('telescope.builtin').filetypes() end,
	['<Leader>jQ'] = function() require('telescope.builtin').diagnostics() end,
	['<Leader>jj'] = function() require('telescope.builtin').quickfix() end,

	['go'] = function() require('telescope.builtin').lsp_references() end,
	['<Leader>li'] = function() require('telescope.builtin').lsp_incoming_calls() end,
	['<Leader>lo'] = function() require('telescope.builtin').lsp_outgoing_calls() end,
	['gd'] = function() require('telescope.builtin').lsp_definitions() end,
	['<Leader>lt'] = function() require('telescope.builtin').lsp_type_definitions() end,
	['<Leader>lm'] = function() require('telescope.builtin').lsp_implementations() end,
	['<Leader>ls'] = function() require('telescope.builtin').lsp_document_symbols() end,
	['<Leader>lS'] = function() require('telescope.builtin').lsp_workspace_symbols() end,

	['<Leader>jz'] = function() require('telescope').extensions.zoxide.list() end,
	['<Leader>jn'] = function() require('telescope').extensions.notify.notify() end,

	-- Numbered
	["'1"] = function() numbered_get(1) end,
	["'2"] = function() numbered_get(2) end,
	["'3"] = function() numbered_get(3) end,
	["'4"] = function() numbered_get(4) end,
	["'5"] = function() numbered_get(5) end,
	["'6"] = function() numbered_get(6) end,
	["'7"] = function() numbered_get(7) end,
	["'8"] = function() numbered_get(8) end,
	["'9"] = function() numbered_get(9) end,
	["'0"] = function() numbered_get(10) end,

	-- Kitty blank
	['<Leader>m'] = kitty_blank,
	['<A-/>'] = function() require('astrocore').cmd({ 'kitten', '@', 'launch', '--cwd', vim.fn.getcwd() }) end,

	-- Direct
	U = '<C-r>',
	zu = 'q',
	zl = '@',
	["zl'"] = '@"',
	X = '@e',
	zz = '@@',
	Y = 'yg_',
	['<C-k>'] = 'O<Esc>',
	['<F6>'] = 'o<Esc>',
	['`'] = '<C-^>',
	['~'] = 'g~l',
	dP = 'ddkP',
	dp = 'ddp',
	gK = 'K',
	yP = 'yyP',
	yp = 'yyp',
	zff = 'zfl',
	['g:'] = 'g,',
}

local visual_mappings = {
	cz = function() change_case('', 'selection') end,
	['<Leader>jr'] = function()
		local previous_clipboard = vim.fn.getreg(env.default_register)
		env.feedkeys('y')
		vim.schedule(function()
			require('telescope.builtin').grep_string({
				search = vim.fn.getreg(env.default_register),
			})
			vim.fn.setreg(env.default_register, previous_clipboard)
		end)
	end,
	['<Leader>jt'] = function()
		local previous_clipboard = vim.fn.getreg(env.default_register)
		env.feedkeys('y')
		vim.schedule(function()
			require('telescope.builtin').grep_string({
				search = vim.fn.getreg(env.default_register),
				additional_args = {
					'--no-ignore',
					'--hidden',
				},
			})
			vim.fn.setreg(env.default_register, previous_clipboard)
		end)
	end,
	['#'] = function() require('lupa').selection({ backwards = true }) end,
	['*'] = function() require('lupa').selection() end,
	['<Leader>#'] = function() require('lupa').selection({ edit = true, backwards = true }) end,
	['<Leader>*'] = function() require('lupa').selection({ edit = true }) end,
	['@@'] = function() env.feedkeys_int('ygv<Esc>' .. vim.v.count1 .. 'p') end,
	['a%'] = 'F%of%',
	['i%'] = 'T%ot%',
	u = '<Esc>u',
	['<'] = '<gv',
	['>'] = '>gv',
	im = "<Cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>ok",
	am = "<Cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>jok",
	iM = "<Cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>o2k",
	aM = "<Cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>jo2k",
	['<Leader>dE'] = ghl_file_visual,
	['<Leader>dR'] = ghl_file_head_visual,
}

local insert_mappings = {
	[';'] = function()
		if require('luasnip').expandable() then
			require('luasnip').expand()
		else
			env.feedkeys(';')
		end
	end,
	["<A-'>"] = '<C-r><C-p>',
	["<A-'>'"] = '<C-r><C-p>+',
	["<A-'>0"] = function() numbered_insert(10) end,
	["<A-'>1"] = function() numbered_insert(1) end,
	["<A-'>2"] = function() numbered_insert(2) end,
	["<A-'>3"] = function() numbered_insert(3) end,
	["<A-'>4"] = function() numbered_insert(4) end,
	["<A-'>5"] = function() numbered_insert(5) end,
	["<A-'>6"] = function() numbered_insert(6) end,
	["<A-'>7"] = function() numbered_insert(7) end,
	["<A-'>8"] = function() numbered_insert(8) end,
	["<A-'>9"] = function() numbered_insert(9) end,
	["<A-'><CR>"] = '<C-r><C-p>:',
	["<A-'>E"] = function() killring_pop_tail(true) end,
	["<A-'>e"] = function() killring_pop(true) end,
	['<A-s>'] = '<C-d>',
	['<A-d>'] = '<C-t>',
	['<A-/>'] = { close_try_save },
	['<A-;>'] = '',
	['<A-i>'] = '',
	['<A-o>'] = '',
	['<C-h>'] = '<C-o>"_S<Esc><C-o>gI<BS>', -- Delete from the current position to the last character on the previous line
	['<C-k>'] = '<C-o>O',
	['<C-v>'] = '<C-r><C-p>+',
	['<F5>'] = '',
	['<F6>'] = '<C-o>o',
	['<A-f>'] = '<C-a>',
	['<A-g>'] = '<C-g>j',
}

local pending_mappings = {
	['i%'] = function() vim.cmd('normal! vT%ot%') end,
	['a%'] = function() vim.cmd('normal! vF%of%') end,
	[']}'] = function() vim.cmd('normal! V}k') end,
	['[{'] = function() vim.cmd('normal! V{j') end,
	['{'] = 'V{',
	['}'] = 'V}',
	['+'] = 'v+',
	['-'] = 'v-',
	gs = { 'gc', remap = true },
	im = '<Cmd>lua require("various-textobjs").indentation("inner", "inner") ; vim.cmd("normal! ok")<CR>',
	am = '<Cmd>lua require("various-textobjs").indentation("inner", "inner") ; vim.cmd("normal! jok")<CR>',
	iM = '<Cmd>lua require("various-textobjs").indentation("inner", "inner") ; vim.cmd("normal! o2k")<CR>',
	aM = '<Cmd>lua require("various-textobjs").indentation("inner", "inner") ; vim.cmd("normal! jo2k")<CR>',
}

local command_mappings = {
	["<A-'>"] = '<C-r>',
	["<A-'>'"] = '<C-r>+',
	["<A-'>;"] = '<C-r><C-w>',
	["<A-'><A-;>"] = '<C-r><C-w>',
	["<A-'>0"] = function() numbered_command(10) end,
	["<A-'>1"] = function() numbered_command(1) end,
	["<A-'>2"] = function() numbered_command(2) end,
	["<A-'>3"] = function() numbered_command(3) end,
	["<A-'>4"] = function() numbered_command(4) end,
	["<A-'>5"] = function() numbered_command(5) end,
	["<A-'>6"] = function() numbered_command(6) end,
	["<A-'>7"] = function() numbered_command(7) end,
	["<A-'>8"] = function() numbered_command(8) end,
	["<A-'>9"] = function() numbered_command(9) end,
	["<A-'><CR>"] = '<C-r>:',
	["<A-'>E"] = function() killring_pop_tail('command') end,
	["<A-'>e"] = function() killring_pop('command') end,
	['<C-v>'] = '<C-r>+',
	['<A-h>'] = '<C-t>',
	['<A-l>'] = '<C-g>',
	['<C-k>'] = '<Up>',
	['<F6>'] = '<Down>',
	['<S-CR>'] = function() vim.fn.setcmdline('.,$') end,
	['<A-s>'] = '\\zs',
	['<A-d>'] = '\\ze',
	['<A-f>'] = '<C-f>',
	['<A-;>'] = '<C-l>', -- I use wildcharm, that doesn't recognize <A-;>, but does <C-l>. Hence the remap.
}

local command_insert_mappings = {
	['<A-q>'] = '<C-q>',
}

local normal_visual_pending_mappings = {
	-- Spider
	['w'] = "<Cmd>lua require('spider').motion('w')<CR>",
	['e'] = "<Cmd>lua require('spider').motion('e')<CR>",
	['b'] = "<Cmd>lua require('spider').motion('b')<CR>",
	['ge'] = "<Cmd>lua require('spider').motion('ge')<CR>",

	-- j = {
	-- 	function() return store_andor_use_count('j') end,
	-- 	expr = true,
	-- },
	-- k = {
	-- 	function() return store_andor_use_count('k') end,
	-- 	expr = true,
	-- },
	H = '<C-u>',
	L = '<C-d>',
	["m'"] = "`'",
	[':'] = ',',
	['m,'] = '`<',
	['m.'] = '`>',
	['m/'] = '`^',
	['m['] = '`[',
	['m]'] = '`]',
	gm = function() env.feedkeys(vim.v.count * 10 .. 'gM') end, -- cuts down precision of gM to 10s
	gM = 'M',
	['g.'] = 'gn',
	['g>'] = 'gN',
	['<Leader><Space>'] = function() -- test mapping
	end,
}

local normal_visual_mappings = {
	['<CR>'] = {
		function()
			vim.cmd.mkview({ mods = { emsg_silent = true } })
			if vim.v.count > 0 then
				env.feedkeys(vim.v.count + 1 .. ':')
			else
				env.feedkeys(':')
			end
		end,
	},
	['<S-CR>'] = function()
		vim.cmd.mkview({ mods = { emsg_silent = true } })
		env.feedkeys(':')
		vim.schedule(function() vim.fn.setcmdline('.,$') end)
	end,
	['_'] = function() env.feedkeys_int(vim.v.count1 .. 'k$') end,
	["';"] = '":',
	["''"] = '"_',
	["'"] = '"',
	['&'] = '@:',
	['[{'] = '{j',
	[']}'] = '}k',
	['gz'] = 'g<C-g>',
	ga = 'gv',
}

local insert_select_mappings = {
	['<A-l>'] = function() require('luasnip').jump(1) end,
	['<A-h>'] = function() require('luasnip').jump(-1) end,
	['<A-i>'] = function()
		if require('luasnip').expandable() then require('luasnip').expand() end
	end,
	['<A-o>'] = function()
		if require('luasnip').choice_active() then require('luasnip').change_choice(1) end
	end,
	['<A-S-o>'] = function()
		if require('luasnip').choice_active() then require('luasnip').change_choice(-1) end
	end,
}

local visual_select_mappings = {
	['<A-f>'] = '<C-g>',
}

local normal_select_mappings = {
	['<A-.>'] = vim.lsp.buf.signature_help,
}

local function map(modes, bindee, binding)
	if type(binding) == 'table' then
		local opts = binding
		local binding = table.remove(opts, 1)
		vim.keymap.set(modes, bindee, binding, opts)
		-- vim.notify('table worked with: ' .. vim.inspect(rhs) .. '\nand: ' .. vim.inspect(rhs_table))
	elseif type(binding) == 'string' or type(binding) == 'function' then
		vim.keymap.set(modes, bindee, binding)
		-- vim.notify('string worked with: ' .. vim.inspect(rhs_table))
	else
		vim.notify('modes: ' .. modes .. '\nlhs: ' .. bindee)
	end
end
-- map('x', ',,aa', { '<Cmd>write<CR>', expr = true })
-- map('n', ',,ss', { function() vim.cmd('write') end, expr = true })
-- map('s', ',,dd', '<Cmd>write<CR>')
-- map('c', ',,ff', function() vim.cmd('write') end)

for bindee, binding in pairs(normal_mappings) do
	map('n', bindee, binding)
end

for bindee, binding in pairs(visual_mappings) do
	map('x', bindee, binding)
end

for bindee, binding in pairs(insert_mappings) do
	map('i', bindee, binding)
end

for bindee, binding in pairs(pending_mappings) do
	map('o', bindee, binding)
end

for bindee, binding in pairs(command_mappings) do
	map('c', bindee, binding)
end

for bindee, binding in pairs(command_insert_mappings) do
	map('!', bindee, binding)
end

for bindee, binding in pairs(normal_visual_pending_mappings) do
	map({ 'x', 'n', 'o' }, bindee, binding)
end

for bindee, binding in pairs(insert_select_mappings) do
	map({ 'i', 's' }, bindee, binding)
end

for bindee, binding in pairs(visual_select_mappings) do
	map('v', bindee, binding)
end

for bindee, binding in pairs(normal_select_mappings) do
	map({ 'n', 's' }, bindee, binding)
end

for bindee, binding in pairs(normal_visual_mappings) do
	map({ 'n', 'x' }, bindee, binding)
end
