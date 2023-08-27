require("packer").startup(function(use)
	use "wbthomason/packer.nvim"
	use "kana/vim-textobj-user"
	use "vim-scripts/ReplaceWithRegister"
	use "wellle/targets.vim"
	use "junegunn/vim-easy-align"
	-- use "sheerun/vim-polyglot"
	use "tpope/vim-repeat"
	use "adelarsq/vim-matchit"
	use "sainnhe/gruvbox-material"
	use "farmergreg/vim-lastplace"
	use "bkad/CamelCaseMotion"
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