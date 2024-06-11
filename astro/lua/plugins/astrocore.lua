local killring = setmetatable({}, { __index = table })

function validate_register(register)
	if register == 'w' then
		return '0'
	elseif register == "'" then
		return '+'
	else
		return register
	end
end

local function save()
	Trim_trailing_whitespace()
	vim.cmd('nohl')
	---@diagnostic disable-next-line: param-type-mismatch
	if vim.bo.modified then pcall(vim.cmd, 'write') end
end

local function close_try_save()
	---@diagnostic disable-next-line: param-type-mismatch
	if vim.bo.modified then pcall(vim.cmd, 'write') end
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
	local full_path = vim.api.nvim_buf_get_name(0)
	local home = os.getenv('HOME')
	if not home then return end
	local friendly_path = string.gsub(full_path, home, '~')
	vim.fn.setreg('+', friendly_path)
	vim.notify('full path: ' .. friendly_path)
end

local function copy_file_name()
	local file_name = vim.fn.expand('%:t')
	vim.fn.setreg('+', file_name)
	vim.notify('name: ' .. file_name)
end

local function copy_cwd_relative()
	local relative_path = vim.fn.expand('%:p:.')
	vim.fn.setreg('+', relative_path)
	vim.notify('cwd relative: ' .. relative_path)
end

local function get_repo_root()
	local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
	return git_root
end

local function copy_git_relative()
	local full_path = vim.api.nvim_buf_get_name(0)
	local git_root = get_repo_root()
	local relative_path = string.gsub(full_path, '^' .. git_root .. '/', '')
	vim.fn.setreg('+', relative_path)
	vim.notify('repo relative: ' .. relative_path)
end

local function copy_cwd()
	local cwd = vim.fn.getcwd()
	cwd = vim.fn.fnamemodify(cwd, ':~')
	vim.fn.setreg('+', cwd)
	vim.notify('cwd: ' .. cwd)
end

local function another_quickfix_entry(to_next, buffer)
	local qflist = vim.fn.getqflist()
	if #qflist == 0 then
		vim.notify('quickfix list is empty')
		return
	end

	if vim.v.count > 0 then
		vim.cmd('silent! cc ' .. vim.v.count)
		vim.notify('qf ' .. vim.v.count)
		return
	end

	local qflist_index = vim.fn.getqflist({ idx = 0 }).idx
	local current_buffer = vim.api.nvim_get_current_buf()
	local current_line = vim.api.nvim_win_get_cursor(0)[1]

	if qflist_index == 1 and (qflist[1].bufnr ~= current_buffer or qflist[1].lnum ~= current_line) then -- If you do have a quickfix list, the first index is automatically selected, meaning that the first time you try to `cnext`, you go to the second quickfix entry, even though you have never actually visited the first one. This is what I mean when I say vim has a bad foundation and is terrible to build upon. We need a modal editor with a better foundation, with no strange behavior like this!
		vim.cmd('silent! cfirst')
		return
	end

	local status = true
	if to_next then
		if buffer then
			---@diagnostic disable-next-line: param-type-mismatch
			status, _ = pcall(vim.cmd, 'cnfile')
		else
			---@diagnostic disable-next-line: param-type-mismatch
			status, _ = pcall(vim.cmd, 'cnext')
		end
		if not status then vim.cmd('silent! cfirst') end
	else
		if buffer then
			---@diagnostic disable-next-line: param-type-mismatch
			status, _ = pcall(vim.cmd, 'cpfile')
		else
			---@diagnostic disable-next-line: param-type-mismatch
			status, _ = pcall(vim.cmd, 'cprev')
		end
		if not status then vim.cmd('silent! clast') end
	end
end

function killring_push_tail()
	local register_contents = vim.fn.getreg('+')
	if register_contents == '' then
		vim.notify('default register is empty')
		return
	end
	killring:insert(1, register_contents)
	vim.notify('pushed')
end

function killring_push()
	local register_contents = vim.fn.getreg('+')
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
	vim.fn.setreg('+', first_index)
	if insert then
		if insert == 'command' then
			FeedKeysInt('<C-r>+')
		else
			FeedKeysInt('<C-r><C-p>+')
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
	vim.fn.setreg('+', first_index)
	if insert then
		if insert == 'command' then
			FeedKeysInt('<C-r>+')
		else
			FeedKeysInt('<C-r><C-p>+')
		end
	else
		vim.notify('got nose')
	end
end

function killring_compile()
	local compiled_killring = killring:concat('')
	vim.fn.setreg('+', compiled_killring)
	killring = setmetatable({}, { __index = table })
	vim.notify('killring compiled')
end

function killring_compile_reversed()
	local reversed_killring = ReverseTable(killring)
	local compiled_killring = reversed_killring:concat('')
	vim.fn.setreg('+', compiled_killring)
	killring = setmetatable({}, { __index = table })
	vim.notify('killring compiled in reverse')
end

function search_for_register(direction, death)
	local char = Get_char('register: ')
	if not char then return end
	local register = validate_register(char)
	local escaped_register = EscapeForLiteralSearch(vim.fn.getreg(register))
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
	local default = vim.fn.getreg('+')
	FeedKeys('y')
	vim.schedule(function()
		local escaped_selection = EscapeForLiteralSearch(vim.fn.getreg('+'))
		FeedKeys(direction .. '\\V' .. escaped_selection .. death)
		FeedKeysInt('<cr>')
		vim.fn.setreg('+', default)
	end)
end

local function move_default_to_other()
	local char = Get_char('register: ')
	if not char then return end
	local register = validate_register(char)
	local default_contents = vim.fn.getreg('+')
	vim.fn.setreg(register, default_contents)
end

local function search_for_current_word(direction, death)
	local register = vim.fn.getreg('+')
	FeedKeys('yiw')
	vim.schedule(function()
		local escaped_word = EscapeForLiteralSearch(vim.fn.getreg('+'))
		FeedKeys(direction .. '\\V\\C' .. escaped_word .. death)
		FeedKeysInt('<CR>')
		vim.fn.setreg('+', register)
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

local function rotate_range()
	local cmd = vim.fn.getcmdline()
	if cmd == '' or cmd == '.,$' then
		vim.fn.setcmdline('%')
	elseif cmd == '%' then
		vim.fn.setcmdline('')
	else
		FeedKeysInt('<CR>')
	end
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

local function count_repeats_keys(keys)
	for _ = 1, vim.v.count1 do
		FeedKeysInt(keys)
	end
end

local function count_repeats(closure)
	for _ = 1, vim.v.count1 do
		closure()
	end
end

local normal_mappings = {
	['<Leader>de'] = { copy_git_relative },
	['<Leader>dq'] = { copy_full_path },
	['<Leader>dr'] = { copy_cwd_relative },
	['<Leader>dw'] = { copy_file_name },

	["'E"] = { killring_pop_tail },
	["'R"] = { killring_push_tail },
	["'T"] = { killring_compile_reversed },
	["'e"] = { killring_pop },
	["'r"] = { killring_push },
	["'t"] = { killring_compile },

	-- System
	K = { close_try_save },
	['<Leader>K'] = { function() vim.cmd('q!') end },
	['<Leader>dm'] = { function() vim.cmd('messages') end },
	['<Leader>ds'] = { edit_magazine },
	['<Leader>g'] = { move_default_to_other },
	['<Leader>lp'] = { function() vim.cmd('Inspect') end },
	['<Leader>lx'] = { execute_this_file },
	['<Space>'] = { save },

	-- Fixes
	['<Esc>'] = {
		function()
			vim.cmd('noh')
			FeedKeysInt('<Esc>')
		end,
	},
	['.'] = { function() count_repeats_keys('.') end },
	['>>'] = { function() count_repeats_keys('>>') end },
	['<<'] = { function() count_repeats_keys('<<') end },
	yie = { function() vim.cmd('%y+') end },
	zM = function() vim.wo.foldlevel = vim.v.count end,
	zR = '<Cmd>set foldlevel=99<CR>',

	-- Features
	["'q"] = {
		function()
			local buffer = vim.api.nvim_get_current_buf()
			local cursor = vim.api.nvim_win_get_cursor(0)
			local line = cursor[1]
			local column = cursor[2] + 1
			vim.fn.setqflist({ {
				bufnr = buffer,
				lnum = line,
				col = column,
			} }, 'a')
			vim.notify('add qf entry')
		end,
	},
	["'Q"] = {
		function()
			local selected = vim.fn.getqflist({ idx = 0 }).idx
			local qflist = vim.fn.getqflist()
			table.remove(qflist, selected)
			vim.fn.setqflist(qflist, 'r')
			vim.notify('remove qf ' .. selected)
		end,
	},
	["''q"] = function()
		vim.fn.setqflist({}, 'r')
		vim.notify('qflist cleared')
	end,
	gQ = function()
		local parent = vim.fn.expand('%:h')
		vim.cmd.tcd(parent)
		local repo_root = get_repo_root()
		if repo_root then vim.cmd.tcd(repo_root) end
	end,
	['<Leader>P'] = 'Pv`[o`]dO<c-r><c-p>"<esc>', -- Paste a characterwise register on a new line
	['<Leader>di'] = '"_ddddpvaB<Esc>>iB', -- Push line of code after block into block
	['<Leader>dl'] = { "dil'dd", remap = true },
	['<Leader>do'] = 'ddm' .. THROWAWAY_MARK .. 'Gp`' .. THROWAWAY_MARK, -- Bottom
	['<Leader>du'] = 'ddm' .. THROWAWAY_MARK .. 'ggP`' .. THROWAWAY_MARK, -- Move line to the top
	['<Leader>p'] = 'Pv`[o`]do<c-r><c-p>"<esc>', -- Paste a characterwise register on a new line
	['@'] = { function() FeedKeys('yl' .. vim.v.count1 .. 'p') end },
	['z?'] = '<CMD>execute "normal! " . rand() % line(\'$\') . "G"<CR>',
	du = { function() count_repeats_keys('dd') end },
	gJ = 'j0d^kgJ', -- Join current line with the next line with no space in between, *also* discarding any leading whitespace of the next line. Because gJ would include indentation. Stupidly.
	gy = '<Cmd>set list!<CR>',

	-- Lsp
	['<Leader>lD'] = { vim.lsp.buf.declaration },
	['<Leader>lr'] = { vim.lsp.buf.rename },
	['gl'] = {
		function()
			vim.diagnostic.open_float()
			vim.diagnostic.open_float()
		end,
	},
	['[e'] = {
		function()
			count_repeats(function() vim.diagnostic.goto_prev() end)
		end,
	},
	[']e'] = {
		function()
			count_repeats(function() vim.diagnostic.goto_next() end)
		end,
	},
	['gh'] = {
		function()
			vim.lsp.buf.hover()
			vim.lsp.buf.hover()
		end,
	},

	-- Abstractions
	['<Leader>j:c'] = '<Cmd>setfiletype css<CR>',
	['<Leader>j:f'] = '<Cmd>setfiletype fish<CR>',
	['<Leader>j:h'] = '<Cmd>setfiletype html<CR>',
	['<Leader>j:l'] = '<Cmd>setfiletype lua<CR>',
	['<Leader>j:m'] = '<Cmd>setfiletype man<CR>',
	['<Leader>j:p'] = '<Cmd>setfiletype python<CR>',
	['<Leader>j:t'] = '<Cmd>setfiletype text<CR>',

	-- Harp
	['""'] = { function() require('harp').cd_set() end },
	['"'] = { function() require('harp').cd_get() end },
	['<Leader>R'] = { function() require('harp').positional_set() end },
	['<Leader>S'] = { function() require('harp').default_set() end },
	['<Leader>X'] = { function() require('harp').percwd_set() end },
	['<Leader>Z'] = { function() require('harp').global_mark_set() end },
	['<Leader>r'] = { function() require('harp').positional_get() end },
	['<Leader>s'] = { function() require('harp').default_get() end },
	['<Leader>x'] = { function() require('harp').percwd_get() end },
	['<Leader>z'] = { function() require('harp').global_mark_get() end },
	['M'] = { function() require('harp').perbuffer_mark_set() end },
	['m'] = { function() require('harp').perbuffer_mark_get() end },

	-- Moving
	['#'] = { function() search_for_current_word('?', '') end },
	['*'] = { function() search_for_current_word('/', '') end },
	['<Leader>#'] = { function() search_for_current_word('?', '?e') end },
	['<Leader>*'] = { function() search_for_current_word('/', '/e') end },
	['[Q'] = { function() another_quickfix_entry(false, true) end },
	['[q'] = { function() another_quickfix_entry(false, false) end },
	[']Q'] = { function() another_quickfix_entry(true, true) end },
	[']q'] = { function() another_quickfix_entry(true, false) end },
	['{'] = { function() move_to_blank_line(false) end },
	['}'] = { function() move_to_blank_line(true) end },

	-- Window
	["<Leader>a'"] = '<C-w>|',
	['<A-h>'] = '<C-w><',
	['<A-l>'] = '<C-w>>',
	['<C-n>'] = '<C-w>-',
	['<C-p>'] = '<C-w>+',
	['<Leader>a//'] = '<C-w>p',
	['<Leader>a/h'] = { function() vim.cmd('exe "leftabove vertical normal \\<c-w>^"') end },
	['<Leader>a/j'] = { function() vim.cmd('exe "normal \\<c-w>^"') end },
	['<Leader>a/k'] = { function() vim.cmd('exe "leftabove normal \\<c-w>^"') end },
	['<Leader>a/l'] = { function() vim.cmd('exe "vertical normal \\<c-w>^"') end },
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
	['<Leader>ath'] = { function() vim.cmd('leftabove vsplit') end },
	['<Leader>atj'] = { function() vim.cmd('split') end },
	['<Leader>atk'] = { function() vim.cmd('leftabove split') end },
	['<Leader>atl'] = { function() vim.cmd('vsplit') end },
	['<Leader>au'] = '<C-w>t',
	['<Leader>av'] = '<C-w>_',
	['<Leader>awh'] = { function() vim.cmd('leftabove vnew') end },
	['<Leader>awj'] = { function() vim.cmd('new') end },
	['<Leader>awk'] = { function() vim.cmd('leftabove new') end },
	['<Leader>awl'] = { function() vim.cmd('vnew') end },
	['<Leader>aww'] = { function() vim.cmd('enew') end },
	['<Leader>ay'] = '<C-w>x',
	['<Leader>a;'] = '<C-w>o',
	['<Leader>ai'] = '<C-w>=',
	['[w'] = 'gT',
	[']w'] = 'gt',

	-- Numbered
	["'1"] = { function() numbered_get(1) end },
	["'2"] = { function() numbered_get(2) end },
	["'3"] = { function() numbered_get(3) end },
	["'4"] = { function() numbered_get(4) end },
	["'5"] = { function() numbered_get(5) end },
	["'6"] = { function() numbered_get(6) end },
	["'7"] = { function() numbered_get(7) end },
	["'8"] = { function() numbered_get(8) end },
	["'9"] = { function() numbered_get(9) end },
	["'0"] = { function() numbered_get(10) end },

	-- Kitty blank
	['<Leader>tws'] = function()
		require('astrocore').cmd({ 'kitten', '@', 'launch', '--type', 'os-window', '--cwd', get_buffer_cwd() })
	end,
	['<Leader>tqs'] = function()
		require('astrocore').cmd({ 'kitten', '@', 'launch', '--type', 'tab', '--cwd', get_buffer_cwd() })
	end,
	['<Leader>tes'] = function() require('astrocore').cmd({ 'kitten', '@', 'launch', '--cwd', get_buffer_cwd() }) end,
	['<Leader>twf'] = function()
		require('astrocore').cmd({ 'kitten', '@', 'launch', '--type', 'os-window', '--cwd', vim.fn.getcwd() })
	end,
	['<Leader>tqf'] = function()
		require('astrocore').cmd({ 'kitten', '@', 'launch', '--type', 'tab', '--cwd', vim.fn.getcwd() })
	end,
	['<Leader>tef'] = function() require('astrocore').cmd({ 'kitten', '@', 'launch', '--cwd', vim.fn.getcwd() }) end,
	['<Leader>twd'] = function()
		require('astrocore').cmd({
			'kitten',
			'@',
			'launch',
			'--type',
			'os-window',
			'--cwd',
			harp_cd_get_or_home(),
		})
	end,
	['<Leader>tqd'] = function()
		require('astrocore').cmd({
			'kitten',
			'@',
			'launch',
			'--type',
			'tab',
			'--cwd',
			harp_cd_get_or_home(),
		})
	end,
	['<Leader>ted'] = function()
		require('astrocore').cmd({
			'kitten',
			'@',
			'launch',
			'--cwd',
			harp_cd_get_or_home(),
		})
	end,
	['<A-/>'] = function() require('astrocore').cmd({ 'kitten', '@', 'launch', '--cwd', vim.fn.getcwd() }) end,
	['<Leader><A-/>'] = function() require('astrocore').cmd({ 'kitten', '@', 'launch', '--cwd', get_buffer_cwd() }) end,

	-- Direct
	U = '@n',
	Y = 'yg_',
	["zx'"] = '@"',
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
	zn = 'q',
	zx = '@',
}

local visual_mappings = {
	['#'] = { function() search_for_selection('?', '') end },
	['*'] = { function() search_for_selection('/', '') end },
	['<Leader>#'] = { function() search_for_selection('?', '?e') end },
	['<Leader>*'] = { function() search_for_selection('/', '/e') end },
	['@@'] = { function() FeedKeysInt('ygv<Esc>' .. vim.v.count1 .. 'p') end },
	['a%'] = 'F%of%',
	['i%'] = 'T%ot%',
	u = '<Esc>u',
}

local insert_mappings = {
	["<A-'>"] = '<C-r><C-p>',
	["<A-'>'"] = '<C-r><C-p>+',
	["<A-'>0"] = { function() numbered_insert(10) end },
	["<A-'>1"] = { function() numbered_insert(1) end },
	["<A-'>2"] = { function() numbered_insert(2) end },
	["<A-'>3"] = { function() numbered_insert(3) end },
	["<A-'>4"] = { function() numbered_insert(4) end },
	["<A-'>5"] = { function() numbered_insert(5) end },
	["<A-'>6"] = { function() numbered_insert(6) end },
	["<A-'>7"] = { function() numbered_insert(7) end },
	["<A-'>8"] = { function() numbered_insert(8) end },
	["<A-'>9"] = { function() numbered_insert(9) end },
	["<A-'><CR>"] = '<C-r><C-p>:',
	["<A-'>E"] = { function() killring_pop_tail(true) end },
	["<A-'>e"] = { function() killring_pop(true) end },
	["<A-'>w"] = '<C-r><C-p>0',
	['<A-,>'] = '<C-d>',
	['<A-.>'] = '<C-t>',
	['<A-/>'] = { close_try_save },
	['<A-;>'] = '',
	['<A-i>'] = '',
	['<A-o>'] = '',
	['<C-h>'] = '<C-o>"_S<Esc><C-o>gI<BS>', -- Delete from the current position to the last character on the previous line
	['<C-k>'] = '<C-o>O',
	['<C-l>'] = '<C-x><C-l>',
	['<C-v>'] = '<C-r><C-p>+',
	['<F5>'] = '',
	['<F6>'] = '<C-o>o',
}

local pending_mappings = {
	['i%'] = { function() vim.cmd('normal vT%ot%') end },
	['a%'] = { function() vim.cmd('normal vF%of%') end },
	[']}'] = { function() vim.cmd('normal V}k') end },
	['[{'] = { function() vim.cmd('normal V{j') end },
	['{'] = 'V{',
	['}'] = 'V}',
	['+'] = 'v+',
	['-'] = 'v-',
}

local command_mappings = {
	["<A-'>"] = '<C-r>',
	["<A-'>'"] = '<C-r>+',
	["<A-'>0"] = { function() numbered_command(10) end },
	["<A-'>1"] = { function() numbered_command(1) end },
	["<A-'>2"] = { function() numbered_command(2) end },
	["<A-'>3"] = { function() numbered_command(3) end },
	["<A-'>4"] = { function() numbered_command(4) end },
	["<A-'>5"] = { function() numbered_command(5) end },
	["<A-'>6"] = { function() numbered_command(6) end },
	["<A-'>7"] = { function() numbered_command(7) end },
	["<A-'>8"] = { function() numbered_command(8) end },
	["<A-'>9"] = { function() numbered_command(9) end },
	["<A-'><CR>"] = '<C-r>:',
	["<A-'>E"] = { function() killring_pop_tail('command') end },
	["<A-'>e"] = { function() killring_pop('command') end },
	["<A-'>w"] = '<C-r>0',
	['<C-v>'] = '<C-r>+',
	['<CR>'] = { rotate_range },
	['<S-CR>'] = { function() vim.fn.setcmdline('.,$') end },
}

local command_insert_mappings = {
	['<A-f>'] = '<C-f>',
	['<A-q>'] = '<C-q>',
}

local normal_visual_pending_mappings = {
	H = '<C-u>',
	L = '<C-d>',
	["';"] = '":',
	["'C"] = '"_C',
	["'D"] = '"_D',
	["'S"] = '"_S',
	["'X"] = '"_X',
	["'c"] = '"_c',
	["'d"] = '"_d',
	["'s"] = '"_s',
	["'w"] = '"0',
	["'x"] = '"_x',
	["m'"] = "`'",
	[':'] = ',',
	['<Leader><Leader>F'] = { function() search_for_register('?', '?e') end },
	['<Leader><Leader>f'] = { function() search_for_register('/', '/e') end },
	['<Leader>F'] = { function() search_for_register('?', '') end },
	['<Leader>f'] = { function() search_for_register('/', '') end },
	['_'] = { function() FeedKeysInt(vim.v.count1 .. 'k$') end },
	['m,'] = '`<',
	['m.'] = '`>',
	['m/'] = '`^',
	['m['] = '`[',
	['m]'] = '`]',
	gM = 'M',
	gm = { function() FeedKeys(vim.v.count * 10 .. 'gM') end }, -- cuts down precision of gM to 10s
}

local normal_visual_mappings = {
	['<CR>'] = {
		function()
			if vim.v.count > 0 then
				FeedKeys(vim.v.count + 1 .. ':')
			else
				FeedKeys(':')
			end
		end,
	},
	["'"] = '"',
	['&'] = '@:',
	['<Leader>da'] = { copy_cwd },
	['<Leader>lc'] = { vim.lsp.buf.code_action },
	['<Leader>lf'] = { function() vim.lsp.buf.format({ async = true }) end },
	['<S-CR>'] = ':.,$',
	['[{'] = '{j',
	[']}'] = '}k',
	gs = '=',
}

local insert_select_mappings = {
	['<A-l>'] = { function() require('luasnip').jump(1) end, silent = true },
	['<A-h>'] = { function() require('luasnip').jump(-1) end, silent = true },
}

local normal_insert_select_mappings = {
	['<A-u>'] = { vim.lsp.buf.signature_help },
}

local mappings_table = {
	n = normal_mappings,
	x = visual_mappings,
	i = insert_mappings,
	o = pending_mappings,
	c = command_mappings,
	['!'] = command_insert_mappings,
}

if not mappings_table.s then mappings_table.s = {} end

for key, value in pairs(normal_visual_pending_mappings) do
	mappings_table.n[key] = value
	mappings_table.x[key] = value
	mappings_table.o[key] = value
end

for key, value in pairs(normal_visual_mappings) do
	mappings_table.n[key] = value
	mappings_table.x[key] = value
end

for key, value in pairs(insert_select_mappings) do
	mappings_table.i[key] = value
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
		virtual_text = true,
		underline = true,
		signs = false,
		virtual_lines = false,
	},
	options = {
		opt = {
			lazyredraw = true,
			gdefault = true,
			relativenumber = true,
			number = false,
			spell = false,
			signcolumn = 'no',
			wrap = true,
			tabstop = 3,
			shiftwidth = 3,
			numberwidth = 3, -- this weirdly means 2
			scrolloff = 999,
			expandtab = false,
			smartindent = true,
			mouse = '',
			ignorecase = true,
			smartcase = true,
			hlsearch = true,
			colorcolumn = '',
			syntax = 'enable',
			termguicolors = true,
			background = 'dark',
			backup = false,
			writebackup = false,
			swapfile = false,
			undofile = true,
			timeout = false,
			eol = false,
			fixeol = false,
			cpoptions = 'aABceFs',
			splitbelow = true,
			splitright = true,
			virtualedit = 'block',
			inccommand = 'split',
			listchars = 'tab:↦ ,multispace:·',
			list = true,
			shortmess = 'finxtTIoOF',
			-- showtabline = 0,
			fillchars = 'eob: ',
			foldcolumn = '1',
			foldminlines = 0,
			autowrite = true,
			autowriteall = true,
			cursorline = false,
			cmdwinheight = 1,
			matchpairs = '(:),{:},[:],<:>',
			-- showbreak = '󱞩 ',
			breakindent = false,
			linebreak = false,
			sidescrolloff = 999,
			clipboard = 'unnamedplus',
			wildoptions = 'fuzzy,pum,tagfile',
			langmap = 'йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:\'\\"zZxXcCvVbBnNmM\\,<.>',
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
		J = {
			function(info)
				local range = ''
				if info.range > 0 then range = (info.line1 or '') .. ',' .. (info.line2 or '') end
				vim.cmd(range .. 'norm ' .. info.args)
			end,
			nargs = '*',
			range = true,
		},
	},
	autocmds = {
		-- center_cursorline = {
		-- 	{
		-- 		event = { 'BufNewFile', 'BufReadPost', 'BufWritePost' },
		-- 		desc = 'Keeps the cursorline at the center of the screen [1]',
		-- 		callback = function(args)
		-- 			-- add virtual lines at the top
		-- 			local win_height = vim.api.nvim_win_get_height(0)
		-- 			local win_offset = math.floor(win_height / 2)
		-- 			local extmark_ns = vim.api.nvim_create_namespace('always_center')

		-- 			local virt_lines = {}
		-- 			for _ = 1, win_offset do
		-- 				table.insert(virt_lines, { { '', '' } })
		-- 			end
		-- 			vim.api.nvim_buf_set_extmark(0, extmark_ns, 0, 0, {
		-- 				id = 1,
		-- 				virt_lines = virt_lines,
		-- 				virt_lines_above = true,
		-- 			})

		-- 			-- add autocmd to trigger on movement
		-- 			vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufEnter' }, {
		-- 				desc = 'Keeps the cursorline at the center of the screen [2]',
		-- 				callback = function(args_lcl)
		-- 					local current_line = vim.api.nvim_win_get_cursor(0)[1]

		-- 					-- if the event is CursorMoved or CursorMovedI (~BufEnter), only trigger if the cursorline has changed
		-- 					if
		-- 						args_lcl.event ~= 'BufEnter' and current_line == vim.b[args.buf].center_cursorline_last_line
		-- 					then
		-- 						return
		-- 					end
		-- 					vim.b[args.buf].center_cursorline_last_line = current_line

		-- 					local win_view = vim.fn.winsaveview()
		-- 					win_view.topline = math.max(current_line - win_offset, 1)
		-- 					win_view.topfill = math.max(win_offset - current_line + 1, 0)
		-- 					vim.fn.winrestview(win_view)
		-- 				end,
		-- 				buffer = args.buf,
		-- 				group = vim.api.nvim_create_augroup('center_cursorline' .. args.buf, { clear = true }),
		-- 			})
		-- 		end,
		-- 	},
		-- },
		everything = {
			-- {
			-- 	event = 'CursorMoved',
			-- 	command = 'normal! zz',
			-- },
			-- {
			-- 	event = { 'CursorMoved' },
			-- 	callback = function() vim.schedule(vim.cmd.redrawtabline) end,
			-- },
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
				event = { 'FileType' },
				callback = function()
					if vim.bo.filetype == 'lazy' then
						vim.diagnostic.config({ virtual_lines = false })
					else
						vim.diagnostic.config({ virtual_lines = true })
					end
				end,
			},
			{
				event = { 'BufRead', 'BufNewFile' },
				pattern = 'kitty.conf',
				command = 'setfiletype conf',
			},
			{
				event = { 'BufLeave', 'FocusLost' },
				callback = function()
					---@diagnostic disable-next-line: param-type-mismatch
					if vim.bo.modified then pcall(vim.cmd, 'write') end
				end,
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
		},
	},
}

---@type LazySpec
return {
	'AstroNvim/astrocore',
	---@param opts AstroCoreOpts
	opts = function(_, opts)
		opts.mappings = mappings_table
		opts.autocmds.autoview = nil
		opts.autocmds.q_close_windows = nil
		return require('astrocore').extend_tbl(opts, opts_table)
	end,
}
