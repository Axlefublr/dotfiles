vim.g.camelcasemotion_key = "<leader>"
vim.api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = '#0f0f0f', bg = '#ffafd7' })
vim.api.nvim_set_hl(0, 'LeapLabelSecondary', { fg = '#0f0f0f', bg = '#ffd75f' })
Cmd("packadd! matchit")

require('leap').opts.case_sensitive = false
require('leap').opts.max_phase_one_targets = 1
require('leap').opts.equivalence_classes = { ' \t\n\r', 'qй', 'wц', 'eу', 'rк', 'tе', 'yн', 'uг', 'iш', 'oщ', 'pз', '[х', ']ъ', 'aф', 'sы', 'dв', 'fа', 'gп', 'hр', 'jо', 'kл', 'lд', ';ж', '\'э', 'zя', 'xч', 'cс', 'vм', 'bи', 'nт', 'mь', ',б', '.ю'}
require('leap').opts.safe_labels = {}
require('leap').opts.labels = { "f", "j", "d", "k", "s", "l", "a", ";", "e", "i", "w", "o", "g", "h", "r", "u", "x", ".", "c", ",", "z", "/", "v", "m", "t", "y", "q", "p" }

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