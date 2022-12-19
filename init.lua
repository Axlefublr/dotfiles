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
vim.keymap.set("", "K", function() hop.hint_words({
      current_line_only = true
   })
end)

vim.keymap.set("", "ga", "<Plug>(EasyAlign)")
vim.keymap.set("v", "s", "<Plug>VSurround")
vim.keymap.set("n", "R", "<Plug>ReplaceWithRegisterOperator")
vim.keymap.set("n", "RR", "<Plug>ReplaceWithRegisterLine")
vim.keymap.set("v", "R", "<Plug>ReplaceWithRegisterVisual")

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

   -- All modes
   vim.keymap.set("", "zy", function() vim.fn.VSCodeNotify("toggleTypewriter") end)

   -- Normal mode
   vim.keymap.set("n", "zh", function() vim.fn.VSCodeNotify("yo1dog.cursor-trim.lTrimCursor") end)
   vim.keymap.set("n", "zl", function() vim.fn.VSCodeNotify("yo1dog.cursor-trim.rTrimCursor") end)
   vim.keymap.set("n", "zi", function() vim.fn.VSCodeNotify("yo1dog.cursor-trim.trimCursor") end)
   vim.keymap.set("n", "[f", function() vim.fn.VSCodeNotify("workbench.view.search.focus") end)
   vim.keymap.set("n", "]f", function() vim.fn.VSCodeNotify("workbench.action.replaceInFiles") end)
   vim.keymap.set("n", "gD", function() vim.fn.VSCodeNotify("editor.action.revealDefinitionAside") end)
   vim.keymap.set("n", "[p", function() vim.fn.VSCodeNotify("extension.pasteImage") end)
   vim.keymap.set("n", "[s", function() vim.fn.VSCodeNotify("editor.action.toggleStickyScroll") end)
   vim.keymap.set("n", "=<", function() vim.fn.VSCodeNotify("editor.action.trimTrailingWhitespace") end)
   vim.keymap.set("n", "gl", function() vim.fn.VSCodeNotify("editor.action.openLink") end)
   vim.keymap.set("n", "<C-k>", function()
      vim.fn.VSCodeCall("editor.action.insertLineBefore")
      vim.cmd("norm k")
   end)

   -- Visual mode
   vim.keymap.set("v", "gs", function() vim.fn.VSCodeNotifyVisual("codesnap.start", true) end)
   vim.keymap.set("v", "<", function() vim.fn.VSCodeNotifyVisual("editor.action.outdentLines", false) end)
   vim.keymap.set("v", ">", function() vim.fn.VSCodeNotifyVisual("editor.action.indentLines", false) end)

   -- Insert mode
   vim.keymap.set("i", "<C-k>", function() vim.fn.VSCodeNotify("editor.action.insertLineBefore") end)
else
   -- Not vscode
   vim.keymap.set("", "<C-f>", "<C-f>zz")
   vim.keymap.set("", "<C-b>", "<C-b>zz")
   vim.keymap.set("", "<C-d>", "12jzz")
   vim.keymap.set("", "<C-u>", "12kzz")
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

-- All modes
vim.keymap.set("", "gr", "R")
vim.keymap.set("", ";", ":")
vim.keymap.set("", "'", '"')

-- Normal mode
vim.keymap.set("n", "Y", "yg_")
vim.keymap.set("n", "~", "~h")
vim.keymap.set("n", "<C-y>", "<C-a>")
vim.keymap.set("n", "<C-e>", "<C-x>")
vim.keymap.set("n", "Q", "@q")

-- Visual mode remaps
vim.keymap.set("v", "*", '"ry/\\V<C-r>r<CR>')
vim.keymap.set("v", "#", '"ry?\\V<C-r>r<CR>')
vim.keymap.set("v", "u", "<Esc>u")
vim.keymap.set("v", "U", "<Esc>u")
vim.keymap.set("v", "<leader>q", Multiply_Visual)

-- Insert mode remaps
vim.keymap.set("i", "<C-l>", "<C-x><C-l>")
vim.keymap.set("i", "<C-h>", '<Esc>"_ddkA')
vim.keymap.set("i", "<C-m>", '<Esc>"_ddA')
vim.keymap.set("i", "<C-i>", "<Esc>B~Ea")
vim.keymap.set("i", "<C-u>", '<Esc>"_S')

-- Control remaps
vim.keymap.set("", "<C-r>", "<C-r><C-o>")

-- Bracket remaps
vim.keymap.set("", "]x", "<C-a>")
vim.keymap.set("", "[x", "<C-x>")
vim.keymap.set("v", "g]x", "g<C-a>")
vim.keymap.set("v", "g[x", "g<C-x>")

-- Leader remaps
vim.keymap.set("", "<leader>/", function() vim.cmd("noh") end)
vim.keymap.set("", "<leader>`", "'")
vim.keymap.set("", "<leader>y", function() vim.cmd("set hlsearch!") end)
vim.keymap.set("n", "<leader>q", Multiply)
vim.keymap.set("n", "<leader>gg", "gg0")
vim.keymap.set("v", "<leader>gg", "gg0")
vim.keymap.set("n", "<leader>G", "G$")
vim.keymap.set("v", "<leader>G", "G$")

-- Functionizing
vim.keymap.set("", "U", function() vim.fn.cursor(0, vim.v.count1) end)

-- Registers
vim.keymap.set("", "p", "gp")
vim.keymap.set("", "P", "gP")
vim.keymap.set("", "gp", "p")
vim.keymap.set("", "gP", "P")
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
vim.keymap.set("n", "<leader>k", "kg_")
vim.keymap.set("v", "<leader>k", "kg_")
vim.keymap.set("n", "<leader>j", "jg_")
vim.keymap.set("v", "<leader>j", "jg_")