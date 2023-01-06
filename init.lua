function FeedKeysCorrectly(keys)
   local feedableKeys = vim.api.nvim_replace_termcodes(keys, true, false, true)
   vim.api.nvim_feedkeys(feedableKeys, "n", true)
end

function Multiply() vim.cmd('norm "ryl"r' .. vim.v.count1 .. "gp") end

function Multiply_Visual() FeedKeysCorrectly('"rygv<Esc>"r' .. vim.v.count1 .. "gp") end

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.tabstop        = 3
vim.opt.smartindent    = true
vim.opt.mouse          = "a"
vim.opt.ignorecase     = true
vim.opt.smartcase      = true
vim.opt.hlsearch       = false
vim.g.mapleader        = ","
vim.opt.syntax         = "enable"

local Plug = vim.fn['plug#']
vim.call("plug#begin")
Plug("kana/vim-textobj-user")
Plug("kana/vim-textobj-entire")
Plug("kana/vim-textobj-line")
Plug("michaeljsmith/vim-indent-object")
Plug("vim-scripts/ReplaceWithRegister")
Plug("tpope/vim-repeat")
Plug("sheerun/vim-polyglot")
Plug("bkad/CamelCaseMotion")
Plug("junegunn/vim-easy-align")
Plug("tpope/vim-commentary")
Plug("huleiak47/vim-AHKcomplete")
Plug("wellle/targets.vim")
vim.call("plug#end")

require("packer").startup(function(use)
   use "wbthomason/packer.nvim"
   use "savq/melange"
   use "sainnhe/everforest"
   use "sainnhe/edge"
   use "sainnhe/gruvbox-material"
   use "jacoborus/tender.vim"
   use "farmergreg/vim-lastplace"
   use "ap/vim-css-color"
   use {
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true }
   }
   use {
      "phaazon/hop.nvim",
      branch = "v2",
      config = function()
         require("hop").setup({ keys = "asdfghjklqwertyuiopzxcvbnm;" })
      end
   }
   use({
      "kylechui/nvim-surround",
      tag = "*",
      config = function()
         require("nvim-surround").setup()
      end
   })
end)

local hop = require("hop")
local directions = require("hop.hint").HintDirection

vim.keymap.set("", "f", function() hop.hint_char1({
      direction = directions.AFTER_CURSOR,
      current_line_only = true
   })
end)
vim.keymap.set("", "F", function() hop.hint_char1({
      direction = directions.BEFORE_CURSOR,
      current_line_only = true
   })
end)
vim.keymap.set("", "t", function() hop.hint_char1({
      direction = directions.AFTER_CURSOR,
      current_line_only = true,
      hint_offset = -1,
   })
end)
vim.keymap.set("", "T", function() hop.hint_char1({
      direction = directions.BEFORE_CURSOR,
      current_line_only = true,
      hint_offset = 1,
   })
end)

vim.keymap.set("", "ga", "<Plug>(EasyAlign)")
vim.keymap.set("n", "R", "<Plug>ReplaceWithRegisterOperator")
vim.keymap.set("n", "RR", "<Plug>ReplaceWithRegisterLine")
vim.keymap.set("v", "R", "<Plug>ReplaceWithRegisterVisual")

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

vim.opt.termguicolors = true
vim.opt.background    = "dark"
vim.cmd("colorscheme tender")

vim.g.camelcasemotion_key = "<leader>"
vim.g.targets_nl          = "nN"

vim.g.clipboard = {
   name = "wslclipboard",
   copy = {
      ["+"] = "/mnt/c/Programs/Win32yank/win32yank.exe -i --crlf",
      ["*"] = "/mnt/c/Programs/Win32yank/win32yank.exe -i --crlf",
   },
   paste = {
      ["+"] = "/mnt/c/Programs/Win32yank/win32yank.exe -o --lf",
      ["*"] = "/mnt/c/Programs/Win32yank/win32yank.exe -o --lf"
   },
   cache_enabled = true
}

--Autocmd
vim.api.nvim_create_autocmd("FileType", {
   pattern = "autohotkey",
   command = "setlocal commentstring=;\\ %s"
})
vim.api.nvim_create_autocmd("FileType", {
   pattern = "cs",
   command = "setlocal commentstring=//\\ %s"
})

if vim.g.vscode then

   -- Folding
   vim.keymap.set("n", "za", function() vim.fn.VSCodeNotify("editor.toggleFold") end)
   vim.keymap.set("n", "zc", function() vim.fn.VSCodeNotify("editor.foldRecursively") end)
   vim.keymap.set("n", "zC", function() vim.fn.VSCodeNotify("editor.foldAll") end)
   vim.keymap.set("n", "zO", function() vim.fn.VSCodeNotify("editor.unfoldAll") end)
   vim.keymap.set("n", "zo", function() vim.fn.VSCodeNotify("editor.unfoldRecursively") end)
   vim.keymap.set("n", "zp", function() vim.fn.VSCodeNotify("editor.gotoParentFold") end)

   -- All remaps
   vim.keymap.set("", "zy", function() vim.fn.VSCodeNotify("toggleTypewriter") end)

   -- Normal remaps
   vim.keymap.set("n", "zh", function() vim.fn.VSCodeNotify("yo1dog.cursor-trim.lTrimCursor") end)
   vim.keymap.set("n", "zl", function() vim.fn.VSCodeNotify("yo1dog.cursor-trim.rTrimCursor") end)
   vim.keymap.set("n", "zi", function() vim.fn.VSCodeNotify("yo1dog.cursor-trim.trimCursor") end)
   vim.keymap.set("n", "[f", function() vim.fn.VSCodeNotify("workbench.view.search.focus") end)
   vim.keymap.set("n", "]f", function() vim.fn.VSCodeNotify("workbench.action.replaceInFiles") end)
   vim.keymap.set("n", "gD", function() vim.fn.VSCodeNotify("editor.action.revealDefinitionAside") end)
   vim.keymap.set("n", "<leader>s", function() vim.fn.VSCodeNotify("editor.action.toggleStickyScroll") end)
   vim.keymap.set("n", "=<", function() vim.fn.VSCodeNotify("editor.action.trimTrailingWhitespace") end)
   vim.keymap.set("n", "gl", function() vim.fn.VSCodeNotify("editor.action.openLink") end)
   vim.keymap.set("n", "<C-k>", function()
      vim.fn.VSCodeCall("editor.action.insertLineBefore")
      vim.cmd("norm k")
   end)
   vim.keymap.set("n", "<<", function() vim.fn.VSCodeNotify("editor.action.outdentLines") end)
   vim.keymap.set("n", ">>", function() vim.fn.VSCodeNotify("editor.action.indentLines") end)

   -- Visual remaps
   vim.keymap.set("v", "gs", function() vim.fn.VSCodeNotifyVisual("codesnap.start", true) end)
   vim.keymap.set("v", "<", function() vim.fn.VSCodeNotifyVisual("editor.action.outdentLines", false) end)
   vim.keymap.set("v", ">", function() vim.fn.VSCodeNotifyVisual("editor.action.indentLines", false) end)

   -- Insert remaps
   vim.keymap.set("i", "<C-k>", function() vim.fn.VSCodeNotify("editor.action.insertLineBefore") end)
else
   -- Not vscode
   vim.keymap.set("n", "zp", "vaBo^<Esc>")
end

-- Text objects
vim.keymap.set("v", "im", "aBV")
vim.keymap.set("v", "am", "aBVj")
vim.keymap.set("v", "iM", "aBVok")
vim.keymap.set("v", "aM", "aBVjok")
vim.keymap.set("o", "im", function() vim.cmd("normal vaBV") end)
vim.keymap.set("o", "am", function() vim.cmd("normal vaBVj") end)
vim.keymap.set("o", "iM", function() vim.cmd("normal vaBVok") end)
vim.keymap.set("o", "aM", function() vim.cmd("normal vaBVjok") end)

vim.keymap.set("v", "i%", "T%ot%")
vim.keymap.set("v", "a%", "F%of%")
vim.keymap.set("o", "i%", function() vim.cmd("normal vT%ot%") end)
vim.keymap.set("o", "a%", function() vim.cmd("normal vF%of%") end)

-- All remaps
vim.keymap.set("", "gr", "R")
vim.keymap.set("", ";", ":")
vim.keymap.set("", "'", '"')
vim.keymap.set("", "K", "ge")
vim.keymap.set("", "U", "gE")
-- vim.keymap.set("", "`", "@")
-- vim.keymap.set("", ":", ",")
-- vim.keymap.set("", '"', ";")

-- Normal remaps
vim.keymap.set("n", "Y", "yg_")
vim.keymap.set("n", "~", "~h")
vim.keymap.set("n", "Q", "@q")

-- Visual remaps
vim.keymap.set("v", "*", '"ry/\\V<C-r>r<CR>')
vim.keymap.set("v", "#", '"ry?\\V<C-r>r<CR>')
vim.keymap.set("v", "u", "<Esc>u")
vim.keymap.set("v", "U", "<Esc>u")
vim.keymap.set("v", "<leader>q", Multiply_Visual)

-- Insert remaps
vim.keymap.set("i", "<C-l>", "<C-x><C-l>")
vim.keymap.set("i", "<C-h>", '<Esc>"_ddkA')
vim.keymap.set("i", "<C-m>", '<Esc>"_ddA')
vim.keymap.set("i", "<C-b>", "<Esc>B~Ea")
vim.keymap.set("i", "<C-u>", '<Esc>"_S')
vim.keymap.set("i", "<C-i>", '<Esc>"_S<Esc>I')

-- Control remaps
vim.keymap.set("", "<C-f>", "20jzz")
vim.keymap.set("", "<C-b>", "20kzz")
vim.keymap.set("", "<C-d>", "12jzz")
vim.keymap.set("", "<C-u>", "12kzz")
vim.keymap.set("", "<C-r>", "<C-r><C-o>")

-- Leader remaps
vim.keymap.set("", "<leader>/", function() vim.cmd("noh") end)
vim.keymap.set("", "<leader>`", "'")
vim.keymap.set("", "<leader>y", function() vim.cmd("set hlsearch!") end)
vim.keymap.set("n", "<leader>q", Multiply)
vim.keymap.set("", "<leader>f", "f")
vim.keymap.set("", "<leader>F", "F")
vim.keymap.set("", "<leader>t", "t")
vim.keymap.set("", "<leader>T", "T")

-- Registers
vim.keymap.set("", "p", "]p")
vim.keymap.set("", "P", "]P")
vim.keymap.set("", "gp", "gp")
vim.keymap.set("", "gP", "gp")
vim.keymap.set("", "'w", '"0')
vim.keymap.set("", "'i", '"_')
vim.keymap.set("", "'e", '"-')
vim.keymap.set("", "'q", '"+')
vim.keymap.set("", "'r", '".')
vim.keymap.set("", "';", '":')

vim.keymap.set("!", "<C-r>w", "<C-r><C-o>0")
vim.keymap.set("!", "<C-r>e", "<C-r><C-o>-")
vim.keymap.set("!", "<C-r>q", "<C-r><C-o>+")
vim.keymap.set("!", "<C-r>r", '<C-r><C-o>"')
vim.keymap.set("!", "<C-r>;", "<C-r><C-o>:")

-- Vertical movement
vim.keymap.set("v", "_", "-")
vim.keymap.set("n", "_", "-")

Mark_m = 1
vim.keymap.set("n", "mm", function() Mark_m = vim.fn.line(".") end)
vim.keymap.set("n", "`m", function() vim.cmd(tostring(Mark_m)) end)
Mark_n = 1
vim.keymap.set("n", "mn", function() Mark_n = vim.fn.line(".") end)
vim.keymap.set("n", "`n", function() vim.cmd(tostring(Mark_n)) end)
Mark_j = 1
vim.keymap.set("n", "mj", function() Mark_j = vim.fn.line(".") end)
vim.keymap.set("n", "`j", function() vim.cmd(tostring(Mark_j)) end)
Mark_k = 1
vim.keymap.set("n", "mk", function() Mark_k = vim.fn.line(".") end)
vim.keymap.set("n", "`k", function() vim.cmd(tostring(Mark_k)) end)
Mark_l = 1
vim.keymap.set("n", "ml", function() Mark_l = vim.fn.line(".") end)
vim.keymap.set("n", "`l", function() vim.cmd(tostring(Mark_l)) end)