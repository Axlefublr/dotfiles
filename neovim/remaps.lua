local function close_without_saving() vim.cmd('q!') end
local function trim_trailing_whitespace()
	local search = vim.fn.getreg('/')
	---@diagnostic disable-next-line: param-type-mismatch
	pcall(vim.cmd, '%s`\\v\\s+$')
	vim.fn.setreg('/', search)
end
---@diagnostic disable-next-line: param-type-mismatch
local function write() pcall(vim.cmd, 'write') end
function Write_if_modified()
	if vim.bo.modified then write() end
end

local function save()
	trim_trailing_whitespace()
	Remove_highlighting()
	Write_if_modified()
	require('lualine').refresh()
end
local function close_try_save()
	Write_if_modified()
	close_without_saving()
end
vim.keymap.set('', '<Space>', save)
vim.keymap.set('i', '<a-/>', close_try_save)
vim.keymap.set('n', ',K', close_without_saving)
vim.keymap.set('n', 'K', close_try_save)

vim.keymap.set({ 'n', 'x' }, ',dq', function()
	local full_path = Curr_buff_full_path()
	local home = os.getenv('HOME')
	if not home then return end
	local friendly_path = string.gsub(full_path, home, '~')
	vim.fn.setreg('+', friendly_path)
	print('copied: ' .. friendly_path)
end)
vim.keymap.set({ 'n', 'x' }, ',dw', function()
	local file_name = vim.fn.expand('%:t')
	vim.fn.setreg('+', file_name)
	print('copied: ' .. file_name)
end)
vim.keymap.set({ 'n', 'x' }, ',dr', function()
	local relative_path = vim.fn.expand('%:p:.')
	vim.fn.setreg('+', relative_path)
	print('copied: ' .. relative_path)
end)
vim.keymap.set({ 'n', 'x' }, ',de', function()
	local full_path = vim.api.nvim_buf_get_name(0)
	local git_root = Get_repo_root()
	local relative_path = string.gsub(full_path, '^' .. git_root .. '/', '')
	vim.fn.setreg('+', relative_path)
	print('copied: ' .. relative_path)
end)

vim.keymap.set({ 'n', 'x' }, 'gs', '=')
vim.keymap.set('n', 'gss', '==')
vim.keymap.set('', '!', ':!')
vim.keymap.set('', '!!', ':r !')
vim.keymap.set('', 'U', '@n')
vim.keymap.set('', '<cr>', ':')
vim.keymap.set({ 'n', 'x', 'o' }, "'", '"')
vim.keymap.set('', ':', ',')
vim.keymap.set('', ',/', '/\\V')
vim.keymap.set('', ',?', '?\\V')
vim.keymap.set('', '/', '/\\v')
vim.keymap.set('', '?', '?\\v')
vim.keymap.set('', 'zp', ']p')
vim.keymap.set('', 'zP', ']P')
vim.keymap.set('', 'gM', 'M')
vim.keymap.set('', 'zn', 'q')
vim.keymap.set('', 'zm', '@')
vim.keymap.set('', ',v', '<c-v>')
vim.keymap.set('n', 'gK', 'K')
vim.keymap.set('n', 'Y', 'yg_')
vim.keymap.set('n', '~', 'g~l')

vim.keymap.set('n', ',dm', '<cmd>messages<cr>')
vim.keymap.set('x', 'u', '<Esc>u')
vim.keymap.set('x', '&', ':s`\\V')
vim.keymap.set('x', '@@', function() FeedKeysInt('ygv<Esc>' .. vim.v.count1 .. 'p') end) -- multiply selection
vim.keymap.set(
	{ 'x', 'o', 'n' },
	'H',
	function() vim.cmd.normal(Get_vertical_line_diff(true) .. 'k') end
)
vim.keymap.set(
	{ 'x', 'o', 'n' },
	'L',
	function() vim.cmd.normal(Get_vertical_line_diff(false) .. 'j') end
)
vim.keymap.set('', '_', function() FeedKeysInt(vim.v.count1 .. 'k$') end)
vim.keymap.set('', 'gm', function() FeedKeys(vim.v.count * 10 .. 'gM') end) -- cuts down precision of gM to 10s
vim.keymap.set('', 'H', function() vim.cmd.normal(Get_vertical_line_diff(true) .. 'k') end)
vim.keymap.set('', 'L', function() vim.cmd.normal(Get_vertical_line_diff(false) .. 'j') end)
vim.keymap.set('n', '<c-k>', 'O<esc>')
vim.keymap.set('n', '<f6>', 'o<esc>')
vim.keymap.set('n', 'dp', 'ddp')
vim.keymap.set('n', 'dP', 'ddkP')
vim.keymap.set('n', 'yp', 'yyp')
vim.keymap.set('n', 'yP', 'yyP')
vim.keymap.set('n', '&', ':%s`\\V')
vim.keymap.set('n', 'gy', '<cmd>%y+<cr>')
vim.keymap.set('n', ',g', Move_default_to_other)
vim.keymap.set('n', '*', function() Search_for_current_word('/', '') end)
vim.keymap.set('n', ',*', function() Search_for_current_word('/', '/e') end)
vim.keymap.set('n', '#', function() Search_for_current_word('?', '') end)
vim.keymap.set('n', ',#', function() Search_for_current_word('?', '?e') end)

vim.keymap.set('i', '<a-,>', '<c-d>')
vim.keymap.set('i', '<a-.>', '<c-t>')
vim.keymap.set('i', '<c-l>', '<C-x><C-l>')
vim.keymap.set('i', '<C-k>', '<C-o>O')
vim.keymap.set('i', '<f6>', '<C-o>o')
vim.keymap.set('i', '<C-h>', '<C-o>"_S<Esc><C-o>gI<BS>') -- Delete from the current position to the last character on the previous line
vim.keymap.set('i', '<a-s>', '<c-x>')
vim.keymap.set('!', '<a-f>', '<c-f>')

vim.keymap.set('o', '{', 'V{')
vim.keymap.set('o', '}', 'V}')
vim.keymap.set('o', '+', 'v+')
vim.keymap.set('o', '-', 'v-')

local function move_to_blank_line(to_next)
	local search_opts = to_next and '' or 'b'
	vim.fn.search('^\\s*$', search_opts)
end
vim.keymap.set('n', '{', function() move_to_blank_line(false) end)
vim.keymap.set('n', '}', function() move_to_blank_line(true) end)
vim.keymap.set({ 'n', 'x' }, ',da', '<cmd>echo getcwd()<cr>')
vim.keymap.set('n', 'gJ', 'j0d^kgJ') -- Join current line with the next line with no space in between, *also* discarding any leading whitespace of the next line. Because gJ would include indentation. Stupidly.
vim.keymap.set('n', ',di', '"_ddddpvaB<Esc>>iB') -- Push line of code after block into block
vim.keymap.set('n', ',du', 'ddm' .. THROWAWAY_MARK .. 'ggP`' .. THROWAWAY_MARK) -- Move line to the top
vim.keymap.set('n', ',do', 'ddm' .. THROWAWAY_MARK .. 'Gp`' .. THROWAWAY_MARK) -- Bottom
vim.keymap.set('n', ',p', 'Pv`[o`]do<c-r><c-p>"<esc>') -- Paste a characterwise register on a new line
vim.keymap.set('n', ',P', 'Pv`[o`]dO<c-r><c-p>"<esc>') -- Paste a characterwise register on a new line
vim.keymap.set('n', '@', function() FeedKeysInt('yl' .. vim.v.count1 .. 'p') end) -- multiply character
vim.keymap.set('n', '<Esc>', function()
	Remove_highlighting()
	FeedKeysInt('<Esc>')
end)
vim.keymap.set('n', 'J', function()
	for _ = 1, vim.v.count1 do
		FeedKeys('J')
	end
end)
vim.keymap.set('n', '.', function()
	for _ = 1, vim.v.count1 do
		FeedKeys('.')
	end
end)
vim.keymap.set('n', 'du', function()
	for _ = 1, vim.v.count1 do
		FeedKeys('dd')
	end
end)

-- registers

vim.keymap.set('', 'm', '`')
vim.keymap.set('', ',m', 'm')
vim.keymap.set('', 'm[', '`[')
vim.keymap.set('', 'm]', '`]')
vim.keymap.set('', 'm.', '`>')
vim.keymap.set('', 'm,', '`<')
vim.keymap.set('', 'm/', '`^')
vim.keymap.set('', 'M', '``')

vim.keymap.set({ 'n', 'x', 'o' }, "'q", '"+')
vim.keymap.set({ 'n', 'x', 'o' }, "'w", '"0')
vim.keymap.set({ 'n', 'x', 'o' }, "'a", '"_')
vim.keymap.set({ 'n', 'x', 'o' }, "';", '":')

vim.keymap.set('i', "<a-'>", '<C-r><C-p>')
vim.keymap.set('i', '<c-v>', '<C-r><C-p>+')
vim.keymap.set('i', "<a-'>q", '<C-r><C-p>+')
vim.keymap.set('i', "<a-'>w", '<C-r><C-p>0')
vim.keymap.set('i', "<a-'>'", '<C-r><C-p>"')
vim.keymap.set('i', "<a-'><cr>", '<C-r><C-p>:')

vim.keymap.set('c', "<a-'>", '<C-r>')
vim.keymap.set('c', '<c-v>', '<C-r>+')
vim.keymap.set('c', "<a-'>q", '<C-r>+')
vim.keymap.set('c', "<a-'>w", '<C-r>0')
vim.keymap.set('c', "<a-'>'", '<C-r>"')
vim.keymap.set('c', "<a-'><cr>", '<C-r>:')

-- text objects

-- Percent sign %
vim.keymap.set('x', 'i%', 'T%ot%')
vim.keymap.set('x', 'a%', 'F%of%')
vim.keymap.set('o', 'i%', function() vim.cmd('normal vT%ot%') end)
vim.keymap.set('o', 'a%', function() vim.cmd('normal vF%of%') end)

-- Exclusive previous / next blank line
vim.keymap.set({ 'n', 'x' }, ']}', '}k')
vim.keymap.set({ 'n', 'x' }, '[{', '{j')
vim.keymap.set('o', ']}', function() vim.cmd('normal V}k') end)
vim.keymap.set('o', '[{', function() vim.cmd('normal V{j') end)

-- big
local function edit_magazine()
	local register = Get_char('magazine: ')
	if register == nil then return end
	vim.cmd('edit ' .. vim.fn.expand('~/.local/share/magazine/') .. register)
	print('shoot ' .. register)
end
vim.keymap.set('n', '"', edit_magazine)
vim.keymap.set('n', '""d', '<cmd>tcd ~/prog/dotfiles<cr>')
vim.keymap.set('n', '""t', '<cmd>tcd ~/prog/noties<cr>')
vim.keymap.set('n', '""b', '<cmd>tcd ~/prog/backup<cr>')
