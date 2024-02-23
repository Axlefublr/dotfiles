vim.cmd("packadd! matchit")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	"kana/vim-textobj-user",
	"tpope/vim-repeat",
	"adelarsq/vim-matchit",
	"nvim-lua/plenary.nvim",
	"farmergreg/vim-lastplace",
	"xiyaowong/transparent.nvim",
	"kyazdani42/nvim-web-devicons",
	{
		"wellle/targets.vim",
		init = function()
			vim.g.targets_nl = "nh"
		end
	},
	{
		"vim-scripts/ReplaceWithRegister",
		init = function()
			vim.keymap.set("n", "grr", "<Plug>ReplaceWithRegisterLine")
		end
	},
	{ "junegunn/vim-easy-align", init = function()
		vim.keymap.set("", "ga", "<Plug>(EasyAlign)")
	end},
	{ "sainnhe/gruvbox-material", init = function()
		vim.cmd('colorscheme gruvbox-material')
	end },
	{ "bkad/CamelCaseMotion", init = function()
		vim.g.camelcasemotion_key = "<leader>"
	end},
	{ "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {}},
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons' },
		opts = {
			extensions = {
				fzf = {
					fuzzy = true,                    -- false will only do exact matching
					override_generic_sorter = true,  -- override the generic sorter
					override_file_sorter = true,     -- override the file sorter
					case_mode = "smart_case",        -- or "ignore_case" or "respect_case" (the default case_mode is "smart_case")
				}
			}
		},
		init = function()
			require('telescope').load_extension('fzf')
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', ',jf', builtin.find_files, {})
			vim.keymap.set('n', ',jd', builtin.live_grep, {})
			vim.keymap.set('n', ',js', builtin.buffers, {})
			vim.keymap.set('n', ',jh', builtin.help_tags, {})
		end
	},
	{
		"ggandor/leap.nvim",
		opts = {
			case_sensitive = false,
			max_phase_one_targets = 1,
			equivalence_classes = { ' \t\n\r', 'qй', 'wц', 'eу', 'rк', 'tе', 'yн', 'uг', 'iш', 'oщ', 'pз', '[х', ']ъ', 'aф', 'sы', 'dв', 'fа', 'gп', 'hр', 'jо', 'kл', 'lд', ';ж', '\'э', 'zя', 'xч', 'cс', 'vм', 'bи', 'nт', 'mь', ',б', '.ю'},
			labels = { "f", "j", "d", "k", "s", "l", "a", "e", "i", "w", "o", "g", "h", "r", "u", "x", "c", "z", "/", "v", "m", "t", "y", "q", "p" },
			safe_labels = {},
		},
		init = function()
			vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = '#0f0f0f', bg = '#ffafd7' })
			vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = '#0f0f0f', bg = '#ffd75f' })
			vim.keymap.set({"n", "x", "o"}, "q", "<Plug>(leap-forward-to)")
			vim.keymap.set({"n", "x", "o"}, "Q", "<Plug>(leap-backward-to)")
			vim.keymap.set({"n", "x", "o"}, ",q", "<Plug>(leap-forward-till)")
			vim.keymap.set({"n", "x", "o"}, ",Q", "<Plug>(leap-backward-till)")
		end
	},
	{
		"monaqa/dial.nvim",
		init = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group{
				default = {
					augend.integer.alias.decimal_int,
					augend.integer.alias.hex,
					augend.integer.alias.octal,
					augend.integer.alias.binary,
					augend.hexcolor.new {
						case = "upper"
					},
					augend.semver.alias.semver,
					augend.date.new {
						pattern = "%y.%m.%d",
						default_kind = "day",
						only_valid = true,
					},
					augend.date.alias["%H:%M"],
					augend.date.new {
						pattern = "%B", -- titlecased month names
						default_kind = "day",
					},
					augend.constant.new {
						elements = { "january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december" },
						word = true,
						cyclic = true
					},
					augend.constant.new {
						elements = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
						word = true,
						cyclic = true
					},
					augend.constant.new {
						elements = { "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday" },
						word = true,
						cyclic = true
					},
				},
				toggles = {
					augend.constant.alias.bool,
					augend.constant.new{
						elements = {"and", "or"},
						word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
						cyclic = true,
					},
					augend.constant.new{
						elements = {"AND", "OR"},
						word = true,
						cyclic = true,
					},
					augend.constant.new{
						elements = {"&&", "||"},
						word = false,
						cyclic = true,
					},
					augend.constant.new{
						elements = {"yes", "no"},
						word = false,
						cyclic = true,
					},
				},
				visual = {
					augend.integer.alias.decimal_int,
					augend.integer.alias.hex,
					augend.integer.alias.octal,
					augend.constant.alias.alpha,
					augend.constant.alias.Alpha,
				}
			}

			vim.keymap.set("n", "<C-a>", function()
				require("dial.map").manipulate("increment", "normal")
			end)
			vim.keymap.set("n", "<C-x>", function()
				require("dial.map").manipulate("decrement", "normal")
			end)
			vim.keymap.set("n", "g<C-a>", function()
				require("dial.map").manipulate("increment", "gnormal")
			end)
			vim.keymap.set("n", "g<C-x>", function()
				require("dial.map").manipulate("decrement", "gnormal")
			end)

			vim.keymap.set("v", "<c-a>", require("dial.map").inc_visual("visual"), { noremap = true })
			vim.keymap.set("v", "<c-x>", require("dial.map").dec_visual("visual"), { noremap = true })
			vim.keymap.set("v", "g<c-a>", require("dial.map").inc_gvisual("visual"), { noremap = true })
			vim.keymap.set("v", "g<c-x>", require("dial.map").dec_visual("visual"), { noremap = true })

			vim.keymap.set("n", ",a", require("dial.map").inc_normal("toggles"), { noremap = true })
			vim.keymap.set("v", ",a", require("dial.map").inc_visual("toggles"), { noremap = true })
		end
	},
	{ "nvim-lualine/lualine.nvim", dependencies = { 'kyazdani42/nvim-web-devicons' }, config = function()
		require('lualine').setup({
			options = {
				icons_enabled = true,
				theme = 'auto',
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				}
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff', 'diagnostics' },
				lualine_c = { 'filename' },
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' }
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = { 'location' },
				lualine_y = {},
				lualine_z = {}
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {}
		})
	end},
	{ "chrisgrieser/nvim-various-textobjs", config = function()
		require("various-textobjs").setup({
			-- lines to seek forwards for "small" textobjs (mostly characterwise textobjs)
			-- set to 0 to only look in the current line
			lookForwardSmall = 2,
			-- lines to seek forwards for "big" textobjs (mostly linewise textobjs)
			lookForwardBig = 0,
			-- use suggested keymaps (see overview table in README)
			useDefaultKeymaps = false,
		})
		vim.keymap.set({ "o", "x" }, "ii", "<cmd>lua require('various-textobjs').indentation(true, true)<CR>")
		vim.keymap.set({ "o", "x" }, "ai", "<cmd>lua require('various-textobjs').indentation(false, true)<CR>")
		vim.keymap.set({ "o", "x" }, "iI", "<cmd>lua require('various-textobjs').indentation(true, true)<CR>")
		vim.keymap.set({ "o", "x" }, "aI", "<cmd>lua require('various-textobjs').indentation(false, false)<CR>")

		vim.keymap.set({ "o", "x" }, "R", "<cmd>lua require('various-textobjs').restOfIndentation()<CR>")

		vim.keymap.set({ "o", "x" }, "iS", "<cmd>lua require('various-textobjs').subword(true)<CR>")
		vim.keymap.set({ "o", "x" }, "aS", "<cmd>lua require('various-textobjs').subword(false)<CR>")

		vim.keymap.set({ "o", "x" }, "ie", "<cmd>lua require('various-textobjs').entireBuffer()<CR>")

		vim.keymap.set({ "o", "x" }, ".", "<cmd>lua require('various-textobjs').nearEoL()<CR>")

		vim.keymap.set({ "o", "x" }, "iv", "<cmd>lua require('various-textobjs').value(true)<CR>")
		vim.keymap.set({ "o", "x" }, "av", "<cmd>lua require('various-textobjs').value(false)<CR>")

		vim.keymap.set({ "o", "x" }, "ik", "<cmd>lua require('various-textobjs').key(true)<CR>")
		vim.keymap.set({ "o", "x" }, "ak", "<cmd>lua require('various-textobjs').key(false)<CR>")

		vim.keymap.set({ "o", "x" }, "iu", "<cmd>lua require('various-textobjs').number(true)<CR>")
		vim.keymap.set({ "o", "x" }, "au", "<cmd>lua require('various-textobjs').number(false)<CR>")

		vim.keymap.set({ "o", "x" }, "gl", "<cmd>lua require('various-textobjs').url()<CR>")

		vim.keymap.set({ "o", "x" }, "il", "<cmd>lua require('various-textobjs').lineCharacterwise(true)<CR>")
		vim.keymap.set({ "o", "x" }, "al", "<cmd>lua require('various-textobjs').lineCharacterwise(false)<CR>")

		vim.keymap.set(
			{ "o", "x" },
			"iC",
			"<cmd>lua require('various-textobjs').mdFencedCodeBlock(true)<CR>"
		)
		vim.keymap.set(
			{ "o", "x" },
			"aC",
			"<cmd>lua require('various-textobjs').mdFencedCodeBlock(false)<CR>"
		)

		vim.keymap.set(
			{ "o", "x" },
			"ix",
			"<cmd>lua require('various-textobjs').htmlAttribute(true)<CR>"
		)
		vim.keymap.set(
			{ "o", "x" },
			"ax",
			"<cmd>lua require('various-textobjs').htmlAttribute(false)<CR>"
		)

		vim.keymap.set(
			{ "o", "x" },
			"i|",
			"<cmd>lua require('various-textobjs').shellPipe(true)<CR>"
		)
		vim.keymap.set(
			{ "o", "x" },
			"a|",
			"<cmd>lua require('various-textobjs').shellPipe(false)<CR>"
		)

		vim.keymap.set("n", "gx", function()
			-- select URL
			require("various-textobjs").url()

			-- plugin only switches to visual mode when textobj found
			local foundURL = vim.fn.mode():find("v")

			-- if not found, search whole buffer via urlview.nvim instead
			if not foundURL then
				Cmd.UrlView("buffer")
				return
			end

			-- retrieve URL with the z-register as intermediary
			Cmd.normal { '"zy', bang = true }
			local url = vim.fn.getreg("z")

			-- open with the OS-specific shell command
			local opener
			if vim.fn.has("macunix") == 1 then
				opener = "open"
			elseif vim.fn.has("linux") == 1 then
				opener = "xdg-open"
			elseif vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
				opener = "start"
			end
			local openCommand = string.format("%s '%s' >/dev/null 2>&1", opener, url)
			os.execute(openCommand)
		end, { desc = "Smart URL Opener" })

		vim.keymap.set("n", "dsi", function()
			-- select inner indentation
			require("various-textobjs").indentation(true, true)

			-- plugin only switches to visual mode when a textobj has been found
			local notOnIndentedLine = vim.fn.mode():find("V") == nil
			if notOnIndentedLine then return end

			-- dedent indentation
			Cmd.normal { "<", bang = true }

			-- delete surrounding lines
			local endBorderLn = vim.api.nvim_buf_get_mark(0, ">")[1] + 1
			local startBorderLn = vim.api.nvim_buf_get_mark(0, "<")[1] - 1
			Cmd(tostring(endBorderLn) .. " delete") -- delete end first so line index is not shifted
			Cmd(tostring(startBorderLn) .. " delete")
		end, { desc = "Delete surrounding indentation" })
	end },
})
