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

vim.g.colors_name         = "everforest"
vim.opt.background        = "dark"
vim.g.camelcasemotion_key = "<leader>"
vim.g.targets_nl          = "nN"

if vim.g.vscode then
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

   vim.keymap.set("v", "gs", function() vim.fn.VSCodeNotifyVisual("codesnap.start", true) end)

   vim.keymap.set("n", "za", function() vim.fn.VSCodeNotify("editor.toggleFold") end)
   vim.keymap.set("n", "zC", function() vim.fn.VSCodeNotify("editor.foldAll") end)
   vim.keymap.set("n", "zO", function() vim.fn.VSCodeNotify("editor.unfoldAll") end)
   vim.keymap.set("n", "zp", function() vim.fn.VSCodeNotify("editor.gotoParentFold") end)

   vim.keymap.set("", "zl", function() vim.fn.VSCodeNotify("toggleTypewriter") end)

   vim.keymap.set("n", "<C-k>", function()
      vim.fn.VSCodeCall("editor.action.insertLineBefore")
      vim.cmd("norm k")
   end)
   vim.keymap.set("i", "<C-k>", function() vim.fn.VSCodeNotify("editor.action.insertLineBefore") end)
else
   vim.keymap.set("", "<C-f>", "<C-f>zz")
   vim.keymap.set("", "<C-b>", "<C-b>zz")
   vim.keymap.set("", "<C-d>", "12jzz")
   vim.keymap.set("", "<C-u>", "12kzz")
   vim.keymap.set("n", "zp", "vaBo^<Esc>")
end

vim.keymap.set("", "ga", "<Plug>(EasyAlign)")
vim.keymap.set("v", "s", "<Plug>VSurround")
vim.keymap.set("n", "R", "<Plug>ReplaceWithRegisterOperator")
vim.keymap.set("n", "RR", "<Plug>ReplaceWithRegisterLine")
vim.keymap.set("v", "R", "<Plug>ReplaceWithRegisterVisual")

vim.keymap.set("n", "Y", "yg_")
vim.keymap.set("n", "_", "-")

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

vim.keymap.set("", "K", "gM")
vim.keymap.set("", "gr", "R")
vim.keymap.set("", ";", ":")
vim.keymap.set("", "'", '"')
vim.keymap.set("", ":", ",")
vim.keymap.set("", '"', ";")

vim.keymap.set("", "U", function() vim.fn.cursor(0, vim.v.count1) end)

vim.cmd [[

" Leader remaps
noremap <leader>/ <Cmd>noh<CR>
noremap <leader>f $F
noremap <leader>F ^f
noremap <leader>` '
noremap <leader>h <Cmd>set hlsearch!<CR>

" Bracket remaps
noremap ]x <C-a>
noremap [x <C-x>
vnoremap g]x g<C-a>
vnoremap g[x g<C-x>
noremap [b $F{"_s=><Esc>Jj"_dd
noremap ]b ^f)f=c3l{<Esc>l"uDo<Esc>"up>>o<Esc>I}<Esc>

" Registers
noremap p gp
noremap P gP
noremap gp p
noremap gP P
noremap 'w "0
noremap 'i "_
noremap 'e "-
noremap 'q "+
noremap 'r ".
noremap '; ":
noremap! <C-r>w <C-r><C-o>0
noremap! <C-r>e <C-r><C-o>-
noremap! <C-r>q <C-r><C-o>+
noremap! <C-r>r <C-r><C-o>"
noremap! <C-r>; <C-r><C-o>:

" Normal mode remaps
nnoremap ~ ~h

" Visual mode remaps
vnoremap * "ry/\V<C-r>r<CR>
vnoremap # "ry?\V<C-r>r<CR>
vnoremap u <Esc>u
vnoremap U <Esc>u

" Control remaps
noremap <C-t> <C-a>
noremap <C-e> <C-x>
noremap <C-r> <C-r><C-o>

autocmd FileType autohotkey setlocal commentstring=;\ %s
autocmd FileType cs setlocal commentstring=//\ %s

]]
