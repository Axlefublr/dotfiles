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
	if and_format then vim.lsp.buf.format() end
	---@diagnostic disable-next-line: param-type-mismatch
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
	local register = Get_char('magazine: ')
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

function get_repo_root()
	local git_root = env.shell({ 'git', 'rev-parse', '--show-toplevel' }, { cwd = vim.fn.expand('%:h') }):wait().stdout
	git_root = git_root and git_root:sub(1, -2) or git_root
	return git_root
end

local function copy_git_relative()
	local full_path = vim.api.nvim_buf_get_name(0)
	local git_root = get_repo_root()
	local relative_path = string.gsub(full_path, '^' .. git_root .. '/', '')
	vim.fn.setreg(env.default_register, relative_path)
	vim.notify('repo relative: ' .. relative_path)
end

local function copy_cwd()
	local cwd = vim.fn.getcwd()
	cwd = vim.fn.fnamemodify(cwd, ':~')
	vim.fn.setreg(env.default_register, cwd)
	vim.notify('cwd: ' .. cwd)
end

function killring_push_tail()
	local register_contents = vim.fn.getreg(env.default_register)
	if register_contents == '' then
		vim.notify('default register is empty')
		return
	end
	killring:insert(1, register_contents)
	vim.notify('pushed')
end

function killring_push()
	local register_contents = vim.fn.getreg(env.default_register)
	if register_contents == '' then
		vim.notify('default register is empty')
		return
	end
	killring:insert(register_contents)
	vim.notify('pushed')
end

function killring_pop_tail(insert)
	if #killring <= 0 then
		vim.notify('killring empty')
		return
	end
	local first_index = killring:remove(1)
	vim.fn.setreg(env.default_register, first_index)
	if insert then
		if insert == 'command' then
			FeedKeysInt('<C-r>' .. env.default_register)
		else
			FeedKeysInt('<C-r><C-p>' .. env.default_register)
		end
	else
		vim.notify('got tail')
	end
end

function killring_pop(insert)
	if #killring <= 0 then
		vim.notify('killring empty')
		return
	end
	local first_index = killring:remove(#killring)
	vim.fn.setreg(env.default_register, first_index)
	if insert then
		if insert == 'command' then
			FeedKeysInt('<C-r>' .. env.default_register)
		else
			FeedKeysInt('<C-r><C-p>' .. env.default_register)
		end
	else
		vim.notify('got nose')
	end
end

function killring_compile()
	local compiled_killring = killring:concat('')
	vim.fn.setreg(env.default_register, compiled_killring)
	killring = setmetatable({}, { __index = table })
	vim.notify('killring compiled')
end

function killring_compile_reversed()
	local reversed_killring = ReverseTable(killring)
	local compiled_killring = reversed_killring:concat('')
	vim.fn.setreg(env.default_register, compiled_killring)
	killring = setmetatable({}, { __index = table })
	vim.notify('killring compiled in reverse')
end

function search_for_register(direction, death)
	local escaped_register = EscapeForLiteralSearch(vim.fn.getreg(env.default_register))
	FeedKeys(direction .. '\\V' .. escaped_register .. death)
	FeedKeysInt('<CR>')
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
			FeedKeysInt('<C-r>+')
		else
			FeedKeysInt('<C-r><C-p>+')
		end
	end
end

local function numbered_insert(index) numbered_get(index, true) end
local function numbered_command(index) numbered_get(index, 'command') end

-- I call it death because that's where we end up in. Just like /e or no /e
local function search_for_selection(direction, death)
	local default = vim.fn.getreg(env.default_register)
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = EscapeForLiteralSearch(vim.fn.getreg(env.default_register))
		FeedKeys(direction .. '\\V' .. escaped_selection .. death)
		FeedKeysInt('<cr>')
		vim.fn.setreg(env.default_register, default)
	end)
end

local function search_for_current_word(direction, death)
	local register = vim.fn.getreg(env.default_register)
	FeedKeys('yiw')
	vim.schedule(function()
		local escaped_word = EscapeForLiteralSearch(vim.fn.getreg(env.default_register))
		FeedKeys(direction .. '\\V\\C' .. escaped_word .. death)
		FeedKeysInt('<CR>')
		vim.fn.setreg(env.default_register, register)
	end)
end

local function harp_cd_get_or_home()
	local register = require('harp').get_char('get cd harp: ')
	if not register then return vim.expand('~') end
	local harp = require('harp').cd_get_path(register)
	if not harp then return vim.expand('~') end
	return harp
end

local function get_buffer_cwd()
	local buffer = vim.api.nvim_buf_get_name(0)
	local parent = vim.fn.fnamemodify(buffer, ':h')
	return parent
end

local function execute_this_file()
	local file = vim.api.nvim_buf_get_name(0)
	save()
	require('astrocore').cmd({
		'kitten',
		'@',
		'launch',
		'--cwd',
		vim.fn.getcwd(),
		'--hold',
		'fish',
		'-c',
		"execute '" .. file .. "'",
	})
end

local function diag_this_file()
	local repo = get_repo_root()
	local extension = vim.fn.expand('%:e')
	if extension == 'rs' then
		local output = env.shell({ 'cargo', 'clippy', '-q' }, { cwd = repo }):wait()
		local file = io.open('/tmp/diag', 'w+')
		if not file then
			vim.notify("couldn't open /tmp/diag")
			return
		end
		file:write(output.stdout)
		file:write(output.stderr)
		file:close()
		vim.cmd.edit('/tmp/diag')
	else
		vim.notify('extension ' .. extension .. 'is not recognized')
	end
end

local function count_repeats_keys(keys)
	for _ = 1, vim.v.count1 do
		FeedKeysInt(keys)
	end
end

---@param closure function
local function count_repeats(closure)
	for _ = 1, vim.v.count1 do
		closure()
	end
end

local normal_mappings = {
	['<Leader>de'] = copy_git_relative,
	['<Leader>dq'] = copy_full_path,
	['<Leader>dr'] = copy_cwd_relative,
	['<Leader>dw'] = copy_file_name,
	['<Leader>dt'] = copy_cwd,

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
	['<Leader>lp'] = function() vim.cmd('Inspect') end,
	['<Space>'] = save,
	['d<Space>'] = function() save(true) end,
	K = close_try_save,

	-- Fixes
	['<Esc>'] = function()
		vim.cmd('noh')
		require('notify').dismiss()
		FeedKeysInt('<Esc>')
	end,
	['.'] = function() count_repeats_keys('.') end,
	-- ['>>'] = function() count_repeats_keys('>>') end,
	-- ['<<'] = function() count_repeats_keys('<<') end,
	yie = function() vim.cmd('%y+') end,

	-- Features
	gQ = function()
		local parent = vim.fn.expand('%:h')
		vim.cmd.tcd(parent)
		local repo_root = get_repo_root()
		if repo_root then vim.cmd.tcd(repo_root) end
	end,
	['<Leader>P'] = '<Cmd>pu!<CR>',
	['<Leader>di'] = '"_ddddpvaB<Esc>>iB', -- Push line of code after block into block
	['<Leader>dl'] = '^D"_dd',
	['<Leader>do'] = 'dd<Cmd>$pu<CR>',
	['<Leader>du'] = 'dd<Cmd>0pu!<CR>',
	['<Leader>p'] = '<Cmd>pu<CR>',
	['@'] = function() FeedKeys('yl' .. vim.v.count1 .. 'p') end,
	['z?'] = '<CMD>execute "normal! " . rand() % line(\'$\') . "G"<CR>',
	du = '"_dddd',
	gJ = '0d^kgJ', -- Join current line with the next line with no space in between, *also* discarding any leading whitespace of the next line. Because gJ would include indentation. Stupidly.

	-- Toggles
	['<Leader>ce'] = function()
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
	['<Leader>cl'] = '<Cmd>set list!<CR>',
	['<Leader>co'] = function() require('astrolsp.toggles').buffer_inlay_hints() end,
	['<Leader>cO'] = function() require('astrolsp.toggles').inlay_hints() end,

	-- Lsp
	['gw'] = vim.lsp.buf.rename,
	['<Leader>lc'] = vim.lsp.buf.code_action,
	['gl'] = function()
		vim.diagnostic.open_float({ border = 'none', scope = 'cursor', source = 'if_many' })
		vim.diagnostic.open_float({ border = 'none', scope = 'cursor', source = 'if_many' })
	end,
	['gL'] = function()
		vim.diagnostic.open_float({ border = 'none', scope = 'buffer', source = 'if_many' })
		vim.diagnostic.open_float({ border = 'none', scope = 'buffer', source = 'if_many' })
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
	['<Leader>lx'] = execute_this_file,
	['<Leader>lz'] = diag_this_file,

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

	-- Gaf
	['<Leader>ca'] = function()
		local picked = vim.fn.confirm('Choose change type', 'Modified\nNew\nDeleted')
		if picked == 0 then return end
		if picked == 1 then
			env.shell({ 'gaf', 'stage', 'modified' }, function(result)
				if result.code == 0 then
					vim.notify('stage modified')
				else
					vim.notify(result.stderr)
				end
			end)
		elseif picked == 2 then
			env.shell({ 'gaf', 'stage', 'new' }, function(result)
				if result.code == 0 then
					vim.notify('stage new')
				else
					vim.notify(result.stderr)
				end
			end)
		elseif picked == 3 then
			env.shell({ 'gaf', 'stage', 'deleted' }, function(result)
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
			env.shell({ 'gaf', 'unstage', 'modified' }, function(result)
				if result.code == 0 then
					vim.notify('unstage modified')
				else
					vim.notify(result.stderr)
				end
			end)
		elseif picked == 2 then
			env.shell({ 'gaf', 'unstage', 'added' }, function(result)
				if result.code == 0 then
					vim.notify('unstage added')
				else
					vim.notify(result.stderr)
				end
			end)
		elseif picked == 3 then
			env.shell({ 'gaf', 'unstage', 'deleted' }, function(result)
				if result.code == 0 then
					vim.notify('unstage deleted')
				else
					vim.notify(result.stderr)
				end
			end)
		elseif picked == 4 then
			env.shell({ 'gaf', 'unstage', 'renamed' }, function(result)
				if result.code == 0 then
					vim.notify('unstage renamed')
				else
					vim.notify(result.stderr)
				end
			end)
		end
	end,

	-- Abstractions
	['<Leader>;c'] = '<Cmd>setfiletype css<CR>',
	['<Leader>;f'] = '<Cmd>setfiletype fish<CR>',
	['<Leader>;h'] = '<Cmd>setfiletype html<CR>',
	['<Leader>;l'] = '<Cmd>setfiletype lua<CR>',
	['<Leader>;a'] = '<Cmd>setfiletype man<CR>',
	['<Leader>;m'] = '<Cmd>setfiletype markdown<CR>',
	['<Leader>;p'] = '<Cmd>setfiletype python<CR>',
	['<Leader>;t'] = '<Cmd>setfiletype text<CR>',

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
	['<Leader>s'] = function() require('harp').default_get() end,
	['<Leader>S'] = function() require('harp').default_set() end,
	['<Leader>w'] = function() require('harp').global_mark_get() end,
	['<Leader>W'] = function() require('harp').global_mark_set() end,
	['<Leader>e'] = function() require('harp').global_search_get() end,
	['<Leader>E'] = function() require('harp').global_search_set({ ask = true }) end,
	['<Leader>/'] = function() require('harp').perbuffer_search_get() end,
	['<Leader>?'] = function() require('harp').perbuffer_search_set({ ask = true }) end,
	['<Leader>f'] = function() require('harp').filetype_search_get() end,
	['<Leader>F'] = function() require('harp').filetype_search_set({ ask = true }) end,
	['<Leader>x'] = function() require('harp').percwd_get() end,
	['<Leader>X'] = function() require('harp').percwd_set() end,
	['<Leader>r'] = function() require('harp').positional_get() end,
	['<Leader>R'] = function() require('harp').positional_set() end,
	['M'] = function() require('harp').perbuffer_mark_set() end,
	['m'] = function() require('harp').perbuffer_mark_get() end,

	-- Moving
	['#'] = function() search_for_current_word('?', '') end,
	['*'] = function() search_for_current_word('/', '') end,
	['<Leader>#'] = function() search_for_current_word('?', '?e') end,
	['<Leader>*'] = function() search_for_current_word('/', '/e') end,
	['g#'] = function() search_for_register('?', '') end,
	['g*'] = function() search_for_register('/', '') end,
	['<Leader>g#'] = function() search_for_register('?', '?e') end,
	['<Leader>g*'] = function() search_for_register('/', '/e') end,
	['{'] = function() move_to_blank_line(false) end,
	['}'] = function() move_to_blank_line(true) end,

	-- Window
	["<Leader>a'"] = '<C-w>|',
	['<A-h>'] = '<C-w><',
	['<A-l>'] = '<C-w>>',
	['<C-n>'] = '<C-w>-',
	['<C-p>'] = '<C-w>+',
	['<Leader>a//'] = '<C-w>p',
	['<Leader>a/h'] = function() vim.cmd('exe "leftabove vertical normal \\<c-w>^"') end,
	['<Leader>a/j'] = function() vim.cmd('exe "normal \\<c-w>^"') end,
	['<Leader>a/k'] = function() vim.cmd('exe "leftabove normal \\<c-w>^"') end,
	['<Leader>a/l'] = function() vim.cmd('exe "vertical normal \\<c-w>^"') end,
	['<Leader>a1'] = '1<C-w>w',
	['<Leader>a2'] = '2<C-w>w',
	['<Leader>a3'] = '3<C-w>w',
	['<Leader>a4'] = '4<C-w>w',
	['<Leader>a5'] = '5<C-w>w',
	['<Leader>a6'] = '6<C-w>w',
	['<Leader>a7'] = '7<C-w>w',
	['<Leader>a8'] = '8<C-w>w',
	['<Leader>a9'] = '9<C-w>w',
	['<Leader>aH'] = '<C-w>h<C-w>|',
	['<Leader>aJ'] = '<C-w>j<C-w>_',
	['<Leader>aK'] = '<C-w>k<C-w>_',
	['<Leader>aL'] = '<C-w>l<C-w>|',
	['<Leader>aO'] = '<C-w>b<C-w>|<C-w>_',
	['<Leader>aP'] = '<Cmd>tabclose<CR>',
	['<Leader>aR'] = '<C-w>R',
	['<Leader>aU'] = '<C-w>t<C-w>|<C-w>_',
	['<Leader>ad'] = '<C-w>K',
	['<Leader>af'] = '<C-w>J',
	['<Leader>ag'] = '<C-w>L',
	['<Leader>ah'] = '<C-w>h',
	['<Leader>aj'] = '<C-w>j',
	['<Leader>ak'] = '<C-w>k',
	['<Leader>al'] = '<C-w>l',
	['<Leader>ao'] = '<C-w>b',
	['<Leader>ap'] = '<Cmd>tabnew<CR>',
	['<Leader>ar'] = '<C-w>r',
	['<Leader>as'] = '<C-w>H',
	['<Leader>ath'] = function() vim.cmd('leftabove vsplit') end,
	['<Leader>atj'] = function() vim.cmd('split') end,
	['<Leader>atk'] = function() vim.cmd('leftabove split') end,
	['<Leader>atl'] = function() vim.cmd('vsplit') end,
	['<Leader>au'] = '<C-w>t',
	['<Leader>av'] = '<C-w>_',
	['<Leader>awh'] = function() vim.cmd('leftabove vnew') end,
	['<Leader>awj'] = function() vim.cmd('new') end,
	['<Leader>awk'] = function() vim.cmd('leftabove new') end,
	['<Leader>awl'] = function() vim.cmd('vnew') end,
	['<Leader>aww'] = function() vim.cmd('enew') end,
	['<Leader>ay'] = '<C-w>x',
	['<Leader>a;'] = '<C-w>o',
	['<Leader>ai'] = '<C-w>=',
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
	['<Leader>jh'] = function() require('telescope.builtin').help_tags() end,
	['<Leader>js'] = function() require('telescope.builtin').current_buffer_fuzzy_find() end,
	['<Leader>jc'] = function() require('telescope.builtin').git_commits() end,
	['<Leader>jC'] = function() require('telescope.builtin').git_bcommits() end,
	['<Leader>jx'] = function() require('telescope.builtin').git_branches() end,
	['<Leader>je'] = function() require('telescope.builtin').git_status() end,
	['<Leader>j\\'] = function() require('telescope.builtin').builtin() end,
	['<Leader>jw'] = function() require('telescope.builtin').buffers() end,
	['<Leader>jW'] = function() require('telescope.builtin').oldfiles() end,
	['<Leader><CR>'] = function() require('telescope.builtin').command_history() end,
	['<Leader>jm'] = function() require('telescope.builtin').man_pages() end,
	['<Leader>ji'] = function() require('telescope.builtin').marks() end,
	['<Leader>jH'] = function() require('telescope.builtin').highlights() end,
	['gy'] = function() require('telescope.builtin').filetypes() end,
	['<Leader>jq'] = function() require('telescope.builtin').diagnostics({ bufnr = 0 }) end,
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
	['<A-/>'] = function() require('astrocore').cmd({ 'kitten', '@', 'launch', '--cwd', vim.fn.getcwd() }) end,
	['<Leader>daf'] = function() require('astrocore').cmd({ 'kitten', '@', 'launch', '--cwd', vim.fn.getcwd() }) end,
	['<Leader>das'] = function() require('astrocore').cmd({ 'kitten', '@', 'launch', '--cwd', get_buffer_cwd() }) end,
	['<Leader>dad'] = function() require('astrocore').cmd({ 'kitten', '@', 'launch', '--cwd', harp_cd_get_or_home() }) end,
	['<Leader>dff'] = function()
		require('astrocore').cmd({ 'kitten', '@', 'launch', '--type', 'tab', '--cwd', vim.fn.getcwd() })
	end,
	['<Leader>dfs'] = function()
		require('astrocore').cmd({ 'kitten', '@', 'launch', '--type', 'tab', '--cwd', get_buffer_cwd() })
	end,
	['<Leader>dfd'] = function()
		require('astrocore').cmd({ 'kitten', '@', 'launch', '--type', 'tab', '--cwd', harp_cd_get_or_home() })
	end,

	-- Direct
	U = '<C-r>',
	zL = 'q',
	zl = '@',
	["zl'"] = '@"',
	zz = '@@',
	Y = 'yg_',
	['<C-k>'] = 'O<Esc>',
	['<F6>'] = 'o<Esc>',
	['`'] = '<C-^>',
	['z:'] = 'zA',
	['z;'] = 'za',
	['~'] = 'g~l',
	dP = 'ddkP',
	dp = 'ddp',
	gK = 'K',
	gss = '==',
	yP = 'yyP',
	yp = 'yyp',
	zff = 'zfl',
	['<Leader><Space>'] = function() -- test mapping
	end,
}

local visual_mappings = {
	['<Leader>jr'] = function()
		local previous_clipboard = vim.fn.getreg(env.default_register)
		FeedKeys('y')
		vim.schedule(function()
			require('telescope.builtin').grep_string({
				search = vim.fn.getreg(env.default_register),
			})
			vim.fn.setreg(env.default_register, previous_clipboard)
		end)
	end,
	['<Leader>jt'] = function()
		local previous_clipboard = vim.fn.getreg(env.default_register)
		FeedKeys('y')
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
	['#'] = function() search_for_selection('?', '') end,
	['*'] = function() search_for_selection('/', '') end,
	['<Leader>#'] = function() search_for_selection('?', '?e') end,
	['<Leader>*'] = function() search_for_selection('/', '/e') end,
	['@@'] = function() FeedKeysInt('ygv<Esc>' .. vim.v.count1 .. 'p') end,
	['a%'] = 'F%of%',
	['i%'] = 'T%ot%',
	u = '<Esc>u',
}

local insert_mappings = {
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
	['<A-,>'] = '<C-d>',
	['<A-.>'] = '<C-t>',
	['<A-/>'] = { close_try_save },
	['<A-;>'] = '',
	['<A-i>'] = '',
	['<A-o>'] = '',
	['<C-h>'] = '<C-o>"_S<Esc><C-o>gI<BS>', -- Delete from the current position to the last character on the previous line
	['<C-k>'] = '<C-o>O',
	['<C-v>'] = '<C-r><C-p>+',
	['<F5>'] = '',
	['<F6>'] = '<C-o>o',
	['<A-a>'] = '<C-a>',
}

local pending_mappings = {
	['i%'] = function() vim.cmd('normal vT%ot%') end,
	['a%'] = function() vim.cmd('normal vF%of%') end,
	[']}'] = function() vim.cmd('normal V}k') end,
	['[{'] = function() vim.cmd('normal V{j') end,
	['{'] = 'V{',
	['}'] = 'V}',
	['+'] = 'v+',
	['-'] = 'v-',
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
	['<C-y>'] = '<C-l>',
	['<A-h>'] = '<C-t>',
	['<A-l>'] = '<C-g>',
	['<C-k>'] = '<Up>',
	['<F6>'] = '<Down>',
	['<S-CR>'] = function() vim.fn.setcmdline('.,$') end,
	['<A-s>'] = '\\zs',
	['<A-d>'] = '\\ze',
}

local command_insert_mappings = {
	['<A-f>'] = '<C-f>',
	['<A-q>'] = '<C-q>',
}

local normal_visual_pending_mappings = {
	-- Spider
	['w'] = "<Cmd>lua require('spider').motion('w')<CR>",
	['e'] = "<Cmd>lua require('spider').motion('e')<CR>",
	['b'] = "<Cmd>lua require('spider').motion('b')<CR>",
	['ge'] = "<Cmd>lua require('spider').motion('ge')<CR>",

	H = '<C-u>',
	L = '<C-d>',
	["m'"] = "`'",
	[':'] = ',',
	['m,'] = '`<',
	['m.'] = '`>',
	['m/'] = '`^',
	['m['] = '`[',
	['m]'] = '`]',
	gm = function() FeedKeys(vim.v.count * 10 .. 'gM') end, -- cuts down precision of gM to 10s
	gM = 'M',
}

local normal_visual_mappings = {
	['<CR>'] = {
		function()
			if vim.v.count > 0 then
				FeedKeys(vim.v.count + 1 .. ':')
			else
				FeedKeys(':')
			end
			env.play_sound('bloop-4.mp3', 70)
		end,
	},
	['<S-CR>'] = function()
		env.play_sound('bloop-4.mp3', 70)
		FeedKeys(':')
		vim.schedule(function() vim.fn.setcmdline('.,$') end)
	end,
	['/'] = function()
		env.play_sound('drop_004.ogg', 60)
		FeedKeys('/')
	end,
	['?'] = function()
		env.play_sound('drop_004.ogg', 60)
		FeedKeys('?')
	end,
	['_'] = function() FeedKeysInt(vim.v.count1 .. 'k$') end,
	["';"] = '":',
	["''"] = '"_',
	["'"] = '"',
	['&'] = '@:',
	['[{'] = '{j',
	[']}'] = '}k',
	['gz'] = 'g<C-g>',
	gs = '=',
}

local insert_select_mappings = {
	['<A-l>'] = function() require('luasnip').jump(1) end,
	['<A-h>'] = function() require('luasnip').jump(-1) end,
}

local visual_select_mappings = {
	['<A-f>'] = '<C-g>',
}

local normal_insert_select_mappings = {
	['<A-u>'] = vim.lsp.buf.signature_help,
}

local mappings_table = {
	n = normal_mappings,
	x = visual_mappings,
	i = insert_mappings,
	o = pending_mappings,
	c = command_mappings,
	['!'] = command_insert_mappings,
	s = {},
	v = {},
}

for key, value in pairs(normal_visual_pending_mappings) do
	mappings_table.n[key] = value
	mappings_table.x[key] = value
	mappings_table.o[key] = value
end

for key, value in pairs(normal_visual_mappings) do
	---@diagnostic disable-next-line: assign-type-mismatch
	mappings_table.n[key] = value
	---@diagnostic disable-next-line: assign-type-mismatch
	mappings_table.x[key] = value
end

for key, value in pairs(insert_select_mappings) do
	mappings_table.i[key] = value
	mappings_table.s[key] = value
end

for key, value in pairs(visual_select_mappings) do
	mappings_table.x[key] = value
	mappings_table.s[key] = value
end

for key, value in pairs(normal_insert_select_mappings) do
	mappings_table.n[key] = value
	mappings_table.i[key] = value
	mappings_table.s[key] = value
end

local opts_table = {
	features = {
		large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
		autopairs = true,
		cmp = true,
		diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
		highlighturl = true, -- highlight URLs at start
		notifications = true, -- enable notifications at start
	},
	-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
	diagnostics = {
		-- virtual_text = {
		-- 	virt_text_pos = 'eol',
		-- 	source = 'if_many',
		-- 	spacing = 0,
		-- },
		virtual_text = false,
		underline = true,
		signs = false,
		virtual_lines = false,
	},
	options = {
		opt = {
			-- showbreak = '󱞩 ',
			-- showtabline = 0,
			autowrite = true,
			autowriteall = true,
			background = 'dark',
			backup = false,
			breakindent = false,
			clipboard = 'unnamedplus',
			cmdwinheight = 1,
			colorcolumn = '',
			cpoptions = 'aABceFs',
			cursorline = false,
			eol = false,
			expandtab = false,
			fillchars = 'eob: ,fold: ',
			fixeol = false,
			foldcolumn = '1',
			foldminlines = 0,
			foldtext = '',
			gdefault = true,
			hlsearch = true,
			ignorecase = true,
			inccommand = 'nosplit',
			langmap = 'йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:\'\\"zZxXcCvVbBnNmM\\,<.>',
			lazyredraw = true,
			linebreak = false,
			list = true,
			listchars = 'tab:↦ ,multispace:·',
			matchpairs = '(:),{:},[:],<:>',
			mouse = '',
			number = false,
			numberwidth = 3, -- this weirdly means 2
			relativenumber = true,
			scrolloff = 999,
			shiftwidth = 3,
			shortmess = 'finxtTIoOF',
			sidescrolloff = 999,
			signcolumn = 'no',
			smartcase = true,
			smartindent = true,
			spell = false,
			splitbelow = true,
			splitright = true,
			swapfile = false,
			syntax = 'enable',
			tabstop = 3,
			termguicolors = true,
			timeout = false,
			undofile = true,
			virtualedit = 'block',
			wildoptions = 'fuzzy,pum',
			wrap = true,
			writebackup = false,
		},
		g = {
			rust_recommended_style = true,
		},
	},
	commands = {
		Young = {
			function()
				if vim.fn.getcwd() == os.getenv('HOME') then vim.api.nvim_set_current_dir('~/prog/dotfiles') end
				local recent = vim.v.oldfiles[1]
				vim.cmd.edit(recent)
			end,
		},
	},
	autocmds = {
		everything = {
			{
				event = { 'BufWinLeave', 'BufWritePost' },
				pattern = '*.*',
				command = 'mkview',
			},
			{
				event = 'BufWinEnter',
				pattern = '*.*',
				command = 'silent! loadview',
			},
			{
				event = { 'VimEnter', 'WinEnter' },
				callback = function() vim.fn.matchadd('OrangeBoldBackground', ' \\=FIXME:\\= \\=') end,
			},
			{
				event = { 'BufRead', 'BufNewFile' },
				pattern = '*.XCompose',
				command = 'setfiletype xcompose',
			},
			{
				event = { 'BufRead', 'BufNewFile' },
				pattern = '*.rasi',
				command = 'setfiletype rasi',
			},
			{
				event = { 'BufRead', 'BufNewFile' },
				pattern = 'kitty.conf',
				command = 'setfiletype conf',
			},
			{
				event = 'FileType',
				pattern = 'gitcommit',
				command = 'startinsert',
			},
			{
				event = 'FileType',
				pattern = 'fish',
				callback = function()
					vim.opt_local.expandtab = true
					vim.opt_local.shiftwidth = 4
				end,
			},
			{
				event = 'FileType',
				pattern = 'help',
				callback = function() vim.opt_local.list = false end,
			},
			{ -- needed to stop `q` from exiting manpages
				event = 'FileType',
				pattern = 'man',
				callback = function()
					vim.keymap.set({ 'n', 'x', 'o' }, 'q', '<Plug>(leap-forward-to)', { buffer = true })
					vim.keymap.set({ 'n', 'x', 'o' }, 'Q', '<Plug>(leap-backward-to)', { buffer = true })
					vim.keymap.set({ 'n', 'x', 'o' }, ',q', '<Plug>(leap-forward-till)', { buffer = true })
					vim.keymap.set({ 'n', 'x', 'o' }, ',Q', '<Plug>(leap-backward-till)', { buffer = true })
				end,
			},
			{
				event = 'User',
				pattern = 'LeapEnter',
				callback = function() env.play_sound('drop_004.ogg', 60) end,
			},
			{
				event = 'CmdwinEnter',
				callback = function() vim.keymap.set('n', '<CR>', '<CR>', { buffer = true }) end,
			},
			{
				event = 'BufEnter',
				pattern = '/tmp/pjs',
				callback = function()
					vim.b.match_paths = vim.fn.matchadd('Blush', '^\\~.*')
				end
			},
			{
				event = 'BufLeave',
				pattern = '/tmp/pjs',
				callback = function()
					vim.fn.matchdelete(vim.b.match_paths)
				end
			},
			{ -- Special behavior autocommands
				event = 'BufUnload',
				pattern = '/dev/shm/fish_edit_commandline.fish',
				callback = function()
					local file = io.open('/dev/shm/fish_edit_commandline_cursor', 'w+')
					if file then
						local position = vim.api.nvim_win_get_cursor(0)
						local line = position[1]
						local column = position[2]
						file:write(line .. ' ' .. column + 1)
						file:close()
					end
				end,
			},
			{
				event = 'User',
				pattern = 'KittyInput',
				callback = function()
					vim.opt_local.relativenumber = false
					vim.opt_local.laststatus = 0
					vim.opt_local.showtabline = 0
					vim.opt_local.foldcolumn = '0'
					vim.opt_local.list = false
					vim.opt_local.showbreak = ''
					vim.opt_local.linebreak = false
					vim.opt_local.breakindent = false
					vim.cmd('%s;\\s*$;;e')
					vim.cmd('%s;\\n\\+\\%$;;e')
					vim.fn.matchadd('ShellPinkBold', '^[\\/~].*\\ze 󱕅')
					vim.fn.matchadd('ShellYellow', '󱕅')
					vim.fn.matchadd('ShellPurpleBold', '\\S\\+')
					vim.fn.matchadd('ShellRedBold', '󱎘\\d\\+')
					vim.fn.matchadd('ShellCyan', '\\d\\+')
					vim.fn.matchadd('Green', '󱕅 \\zs.*')
				end
			},
			{
				event = { 'BufLeave', 'FocusLost' },
				callback = function()
					---@diagnostic disable-next-line: param-type-mismatch
					pcall(vim.cmd, 'silent update')
				end,
			},
		},
	},
}

---@type LazySpec
return {
	'AstroNvim/astrocore',
	---@param opts AstroCoreOpts
	opts = function(_, opts)
		---@diagnostic disable-next-line: inject-field
		opts.mappings = mappings_table
		---@diagnostic disable-next-line: undefined-field
		opts.autocmds.autoview = nil
		---@diagnostic disable-next-line: undefined-field
		opts.autocmds.q_close_windows = nil
		return require('astrocore').extend_tbl(opts, opts_table)
	end,
}
