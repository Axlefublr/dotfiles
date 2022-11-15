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

" Correct easymotion depending on where I am
Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })
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

" Plugins settings
map <silent>ga <Plug>(EasyAlign)
vnoremap s <Plug>VSurround
let g:camelcasemotion_key = '<leader>'
autocmd FileType autohotkey setlocal commentstring=;\ %s

" Russian lang map
set langmap=фa,иb,сc,вd,уe,аf,пg,рh,шi,оj,лk,дl,ьm,тn,щo,зp,йq,кr,ыs,еt,гu,мv,цw,чx,нy,яz,ю.,ФA,ИB,СC,ВD,УE,АF,ПG,РH,ШI,ОJ,ЛK,ДL,ЬM,ТN,ЩO,ЗP,ЙQ,КR,ЫS,ЕT,ГU,МV,ЦW,ЧX,НY,ЯZ,Ж:,Б<,Ю>

" All modes remaps
map p gp
map P gP
noremap <C-a> ggVG
noremap / /\v
noremap ? ?\v
noremap ; :
noremap ' "
noremap : ,
noremap " ;
noremap Q ge

" Leader remaps
noremap <leader>r <Cmd>reg<CR>
noremap <leader>/ <Cmd>noh<CR>
noremap <leader>f $F
noremap <leader>F ^f

" Bracket remaps
noremap ]x <C-a>
noremap [x <C-x>
vnoremap g]x g<C-a>
vnoremap g[x g<C-x>
noremap [b vaBo<Esc>s=><Esc>Jjdd
noremap ]b ^f)f=c3l{<Esc>l"uDo<Esc>"up>>o<Esc>I}<Esc>
noremap [z ^dw
noremap ]z Istatic <Esc>

" Registers
noremap 'w "0
noremap 'i "_
noremap 'e "-
noremap 'q "+
noremap 'r "/
noremap 't ".
inoremap <C-r>q <C-r>+
inoremap <C-r>w <C-r>0
inoremap <C-r>e <C-r>-
inoremap <C-r>r <C-r>/
inoremap <C-r>t <C-r>"

" Normal mode remaps
nnoremap ~ ~h

" Visual mode remaps
vnoremap * "ry/\V<C-r>r<CR>
vnoremap # "ry?\V<C-r>r<CR>

if exists('g:vscode')
   
   " VsCode Any
   map ze <Cmd>call VSCodeNotify('scrollLineDown')<CR>
   map zy <Cmd>call VSCodeNotify('scrollLineUp')<CR>
   map [f <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
   map ]f <Cmd>call VSCodeNotify('workbench.action.replaceInFiles')<CR>
   map gD <Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>
   map [p <Cmd>call VSCodeNotify('extension.pasteImage')<CR>
   map [s <Cmd>call VSCodeNotify('editor.action.toggleStickyScroll')<CR>
   map gl <Cmd>call VSCodeNotify('editor.action.openLink')<CR>
   vnoremap gs <Cmd>call VSCodeNotifyRangePos('codesnap.start', line("v"), line("."), col("v"), col("."), 1)<CR>
   noremap M <Cmd>call VSCodeNotify('center-cursor.setCursor')<CR>
   
   " VsCode Folding
   map za <Cmd>call VSCodeNotify('editor.toggleFold')<CR>
   map zC <Cmd>call VSCodeNotify('editor.foldAll')<CR>
   map zO <Cmd>call VSCodeNotify('editor.unfoldAll')<CR>
   map zp <Cmd>call VSCodeNotify('editor.gotoParentFold')<CR>
   map zj <Cmd>call VSCodeNotify('editor.gotoNextFold')<CR>
   map zk <Cmd>call VSCodeNotify('editor.gotoPreviousFold')<CR>
   
   " VsCode Scrolling
   map zl <Cmd>call VSCodeNotify('toggleTypewriter')<CR>
   map [c <Cmd>call VSCodeNotify('workbench.action.editor.previousChange')<CR>
   map ]c <Cmd>call VSCodeNotify('workbench.action.editor.nextChange')<CR>
   map [e <Cmd>call VSCodeNotify('editor.action.marker.prev')<CR>
   map ]e <Cmd>call VSCodeNotify('editor.action.marker.next')<CR>
else
   map <C-d> 12jzz
   map <C-u> 12kzz
   map <C-t> <C-y>
endif
