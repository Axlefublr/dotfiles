local globals = {
	mapleader = ',',
	rust_recommended_style = true,
}

local diagnostics = {
	underline = true,
	virtual_text = false,
}

local options = {
	-- foldclose = 'all',
	-- showbreak = '󱞩 ',
	autowrite = true,
	autowriteall = true,
	background = 'dark',
	backup = false,
	breakindent = false,
	clipboard = 'unnamedplus',
	cmdheight = 0,
	cmdwinheight = 1,
	colorcolumn = '',
	cpoptions = 'aABceFs',
	cursorline = true,
	cursorlineopt = 'both',
	eol = false,
	expandtab = false,
	fillchars = 'eob: ,fold: ,foldopen:;,foldclose:;,foldsep: ',
	fixeol = false,
	foldcolumn = '1',
	foldlevel = 0,
	foldlevelstart = 0,
	foldminlines = 0,
	foldtext = '',
	gdefault = true,
	helpheight = 0,
	hlsearch = true,
	ignorecase = true,
	inccommand = 'nosplit',
	langmap = 'йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:\'\\"zZxXcCvVbBnNmM\\,<.>',
	laststatus = 3,
	lazyredraw = false,
	linebreak = false,
	list = false,
	listchars = 'tab:→ ,multispace:·,leadmultispace:   ',
	matchpairs = '(:),{:},[:],<:>',
	mouse = '',
	number = false,
	numberwidth = 1,
	relativenumber = true,
	report = 9999,
	scrolloff = 999,
	shiftwidth = 3,
	shortmess = 'finxtTIoOF',
	showcmd = true,
	showcmdloc = 'statusline',
	showtabline = 2,
	sidescrolloff = 999,
	signcolumn = 'no',
	smartcase = true,
	smartindent = true,
	smoothscroll = false,
	spell = false,
	splitbelow = true,
	splitright = true,
	startofline = true,
	swapfile = false,
	syntax = 'enable',
	tabstop = 3,
	termguicolors = true,
	timeout = false,
	undofile = true,
	virtualedit = 'block',
	wildcharm = 12, -- is <C-l>
	wildoptions = 'fuzzy,pum',
	wrap = true,
	writebackup = false,
}

for key, value in pairs(globals) do
	vim.g[key] = value
end

vim.diagnostic.config(diagnostics)

for key, value in pairs(options) do
	vim.opt[key] = value
end
