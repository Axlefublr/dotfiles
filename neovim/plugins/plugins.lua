require("packer").startup(function(use)
	use "wbthomason/packer.nvim"
	use "ggandor/leap.nvim"
	use "kana/vim-textobj-user"
	use "vim-scripts/ReplaceWithRegister"
	use "wellle/targets.vim"
	use "junegunn/vim-easy-align"
	use "tpope/vim-repeat"
	use "adelarsq/vim-matchit"
	use "sainnhe/gruvbox-material"
	use "farmergreg/vim-lastplace"
	use "bkad/CamelCaseMotion"
	use "xiyaowong/transparent.nvim"
	use {
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true }
	}
	use {
		"kylechui/nvim-surround",
		tag = "*",
		config = function()
			require("nvim-surround").setup()
		end
	}
	use {
		"chrisgrieser/nvim-various-textobjs",
		config = function()
			require("various-textobjs").setup({
				-- lines to seek forwards for "small" textobjs (mostly characterwise textobjs)
				-- set to 0 to only look in the current line
				lookForwardSmall = 2,

				-- lines to seek forwards for "big" textobjs (mostly linewise textobjs)
				lookForwardBig = 0,

				-- use suggested keymaps (see overview table in README)
				useDefaultKeymaps = false,
			})
		end,
	}
end)

vim.g.camelcasemotion_key = "<leader>"
vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = '#0f0f0f', bg = '#ffafd7' })
vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = '#0f0f0f', bg = '#ffd75f' })
Cmd("packadd! matchit")

require('leap').opts.case_sensitive = false
require('leap').opts.max_phase_one_targets = 1
require('leap').opts.equivalence_classes = { ' \t\n\r', 'qй', 'wц', 'eу', 'rк', 'tе', 'yн', 'uг', 'iш', 'oщ', 'pз', '[х', ']ъ', 'aф', 'sы', 'dв', 'fа', 'gп', 'hр', 'jо', 'kл', 'lд', ';ж', '\'э', 'zя', 'xч', 'cс', 'vм', 'bи', 'nт', 'mь', ',б', '.ю'}
require('leap').opts.safe_labels = {}
require('leap').opts.labels = { "f", "j", "d", "k", "s", "l", "a", "e", "i", "w", "o", "g", "h", "r", "u", "x", "c", "z", "/", "v", "m", "t", "y", "q", "p" }

require('lualine').setup {
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
}