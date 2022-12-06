vim.opt.relativenumber = true
vim.opt.tabstop        = 3
vim.opt.smartindent    = true
vim.opt.mouse          = "a"
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
Plug("christoomey/vim-titlecase")
Plug("tpope/vim-repeat")
Plug("sheerun/vim-polyglot")
Plug("tpope/vim-surround")
Plug("bkad/CamelCaseMotion")
Plug("junegunn/vim-easy-align")
Plug("tpope/vim-commentary")
Plug("huleiak47/vim-AHKcomplete")
Plug("wellle/targets.vim")
Plug("easymotion/vim-easymotion")
Plug("sainnhe/everforest")
vim.call("plug#end")

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

if vim.fn.has("termguicolors") == 1 then
   vim.g.termguicolors = true
end
vim.g.colors_name  = "everforest"
vim.opt.background = "dark"
