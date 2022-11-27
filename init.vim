" Basic settings
set relativenumber
set tabstop=3
set autoindent
set smartindent
set mouse=a
set nocompatible
set ignorecase
set smartcase
set path+=**
set wildmenu
syntax enable
let mapleader = ","

function! Cond(Cond, ...)
   let opts = get(a:000, 0, {})
   return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Plugging plugins
call plug#begin()
Plug 'ThePrimeagen/vim-be-good'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'christoomey/vim-titlecase'
Plug 'tpope/vim-repeat'
Plug 'sheerun/vim-polyglot'
Plug 'sainnhe/everforest'
Plug 'tpope/vim-surround'
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'huleiak47/vim-AHKcomplete'
call plug#end()

" System clipboard access
let g:clipboard = {
\   'name': 'wslclipboard',
\   'copy': {
\      '+': '/mnt/c/Programs/Win32yank/win32yank.exe -i --crlf',
\      '*': '/mnt/c/Programs/Win32yank/win32yank.exe -i --crlf',
\    },
\   'paste': {
\      '+': '/mnt/c/Programs/Win32yank/win32yank.exe -o --lf',
\      '*': '/mnt/c/Programs/Win32yank/win32yank.exe -o --lf',
\   },
\   'cache_enabled': 1,
\ }

" Color theme configuration
if has('termguicolors')
   set termguicolors
endif
set background=dark
let g:everforest_background = 'hard'
let g:everforest_better_performance = 1
colorscheme everforest

if exists('g:vscode')

   " VsCode Any
   map zh <Cmd>call VSCodeNotify('yo1dog.cursor-trim.lTrimCursor')<CR>
   map zl <Cmd>call VSCodeNotify('yo1dog.cursor-trim.rTrimCursor')<CR>
   map zi <Cmd>call VSCodeNotify('yo1dog.cursor-trim.trimCursor')<CR>
   map ze <Cmd>call VSCodeNotify('scrollLineDown')<CR>
   map zy <Cmd>call VSCodeNotify('scrollLineUp')<CR>
   map [f <Cmd>call VSCodeNotify('workbench.view.search.focus')<CR>
   map ]f <Cmd>call VSCodeNotify('workbench.action.replaceInFiles')<CR>
   map gD <Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>
   map [p <Cmd>call VSCodeNotify('extension.pasteImage')<CR>
   map [s <Cmd>call VSCodeNotify('editor.action.toggleStickyScroll')<CR>
   map =< <Cmd>call VSCodeNotify('editor.action.trimTrailingWhitespace')<CR>
   map gl <Cmd>call VSCodeNotify('editor.action.openLink')<CR>

   vnoremap gs <Cmd>call VSCodeNotifyRangePos('codesnap.start', line("v"), line("."), col("v"), col("."), 1)<CR>
   
   noremap gM <Cmd>call VSCodeNotify('center-cursor.setCursor')<CR>
   
   " VsCode Folding
   map za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
   map zC <Cmd>call VSCodeNotify('editor.foldAll')<CR>
   map zO <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
   map zp <Cmd>call VSCodeNotify('editor.gotoParentFold')<CR>
   
   " VsCode Scrolling
   map zl <Cmd>call VSCodeNotify('toggleTypewriter')<CR>
   nmap <C-k> <Cmd>call VSCodeNotify('editor.action.insertLineBefore')<CR>k
   imap <C-k> <Cmd>call VSCodeNotify('editor.action.insertLineBefore')<CR>
else
   noremap <C-f> <C-f>zz
   noremap <C-b> <C-b>zz
   map <C-d> 12jzz
   map <C-u> 12kzz
   nnoremap zp vaBo^<Esc>
endif

" Plugins settings
map <silent>ga <Plug>(EasyAlign)
vnoremap s <Plug>VSurround
let g:camelcasemotion_key = '<leader>'
autocmd FileType autohotkey setlocal commentstring=;\ %s
nnoremap R <Plug>ReplaceWithRegisterOperator
nnoremap RR <Plug>ReplaceWithRegisterLine
vnoremap R <Plug>ReplaceWithRegisterVisual
omap K <Plug>Commentary
nmap KK <Plug>CommentaryLine
nmap K <Plug>Commentary
xmap K <Plug>Commentary

" Recursive maps
nmap Y yg_
map _ -

" Text objects
vmap im vaBlo0
vmap am vaBj$o0
omap im <Cmd>normal vaBlo0<CR>
omap am <Cmd>normal vaBj$o0<CR>
vmap iM vaBlok0
vmap aM vaBj$ok0
omap iM <Cmd>normal vaBlok0<CR>
omap aM <Cmd>normal vaBj$ok0<CR>

" All modes remaps
noremap X gM
noremap gr R
noremap ; :
noremap ' "
noremap : ,
noremap " ;
noremap Q ge
noremap zj +
noremap zk -

noremap U <Cmd>call cursor(0, v:count1)<CR>

" Leader remaps
noremap <leader>r <Cmd>reg<CR>
noremap <leader>/ <Cmd>noh<CR>
noremap <leader>f $F
noremap <leader>F ^f
noremap <leader>` '

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