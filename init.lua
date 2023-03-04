--- Options
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
vim.opt.termguicolors  = true
vim.opt.background     = "dark"
vim.cmd("colorscheme tender")

--- Plugins: VimPlug
local Plug = vim.fn['plug#']
vim.call("plug#begin")
Plug("tpope/vim-repeat")
Plug("sheerun/vim-polyglot")
Plug("bkad/CamelCaseMotion")
Plug("junegunn/vim-easy-align")
Plug("kana/vim-textobj-user")
Plug("kana/vim-textobj-entire")
Plug("kana/vim-textobj-line")
Plug("michaeljsmith/vim-indent-object")
Plug("vim-scripts/ReplaceWithRegister")
Plug("wellle/targets.vim")
vim.call("plug#end")

--- Plugins: Packer
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

--- Plugins: setup
local hop = require("hop")
local directions = require("hop.hint").HintDirection

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

--- Clipboard fix
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

--- Mark fix
vim.keymap.set("n", "mq", "mQ")
vim.keymap.set("n", "mw", "mW")
vim.keymap.set("n", "me", "mE")
vim.keymap.set("n", "mr", "mR")
vim.keymap.set("n", "mt", "mT")
vim.keymap.set("n", "my", "mY")
vim.keymap.set("n", "mu", "mU")
vim.keymap.set("n", "mi", "mI")
vim.keymap.set("n", "mo", "mO")
vim.keymap.set("n", "mp", "mP")
vim.keymap.set("n", "ma", "mA")
vim.keymap.set("n", "ms", "mS")
vim.keymap.set("n", "md", "mD")
vim.keymap.set("n", "mf", "mF")
vim.keymap.set("n", "mg", "mG")
vim.keymap.set("n", "mh", "mH")
vim.keymap.set("n", "mj", "mJ")
vim.keymap.set("n", "mk", "mK")
vim.keymap.set("n", "ml", "mL")
vim.keymap.set("n", "mz", "mZ")
vim.keymap.set("n", "mx", "mX")
vim.keymap.set("n", "mc", "mC")
vim.keymap.set("n", "mv", "mV")
vim.keymap.set("n", "mb", "mB")
vim.keymap.set("n", "mn", "mN")
vim.keymap.set("n", "mm", "mM")

vim.keymap.set("n", "`q", "`Q")
vim.keymap.set("n", "`w", "`W")
vim.keymap.set("n", "`e", "`E")
vim.keymap.set("n", "`r", "`R")
vim.keymap.set("n", "`t", "`T")
vim.keymap.set("n", "`y", "`Y")
vim.keymap.set("n", "`u", "`U")
vim.keymap.set("n", "`i", "`I")
vim.keymap.set("n", "`o", "`O")
vim.keymap.set("n", "`p", "`P")
vim.keymap.set("n", "`a", "`A")
vim.keymap.set("n", "`s", "`S")
vim.keymap.set("n", "`d", "`D")
vim.keymap.set("n", "`f", "`F")
vim.keymap.set("n", "`g", "`G")
vim.keymap.set("n", "`h", "`H")
vim.keymap.set("n", "`j", "`J")
vim.keymap.set("n", "`k", "`K")
vim.keymap.set("n", "`l", "`L")
vim.keymap.set("n", "`z", "`Z")
vim.keymap.set("n", "`x", "`X")
vim.keymap.set("n", "`c", "`C")
vim.keymap.set("n", "`v", "`V")
vim.keymap.set("n", "`b", "`B")
vim.keymap.set("n", "`n", "`N")
vim.keymap.set("n", "`m", "`M")

--- Meta abstractions
function FeedKeysCorrectly(keys)
    local feedableKeys = vim.api.nvim_replace_termcodes(keys, true, false, true)
    vim.api.nvim_feedkeys(feedableKeys, "n", true)
end

--- Remap abstractions
--# Multiply
local multiply_current_character = '"ryl"r' .. vim.v.count1 .. "p"
local multiply_selection = '"rygv<Esc>"r' .. vim.v.count1 .. "p"

function CenterScreen() vim.cmd("call <SNR>4_reveal('center', 0)") end
function TopScreen() vim.cmd("call <SNR>4_reveal('top', 0)") end
function BottomScreen() vim.cmd("call <SNR>4_reveal('bottom', 0)") end

--# Hops
function Hop_forward_f_sameline() hop.hint_char1({
    direction = directions.AFTER_CURSOR,
    current_line_only = true
})
end
function Hop_backward_f_sameline() hop.hint_char1({
    direction = directions.BEFORE_CURSOR,
    current_line_only = true
})
end
function Hop_forward_t_sameline() hop.hint_char1({
    direction = directions.AFTER_CURSOR,
    current_line_only = true,
    hint_offset = -1,
})
end
function Hop_backward_t_sameline() hop.hint_char1({
    direction = directions.BEFORE_CURSOR,
    current_line_only = true,
    hint_offset = 1,
})
end

--# Vscode: Folding
function Vscode_toggle_fold() vim.fn.VSCodeNotify("editor.toggleFold") end
function Vscode_goto_parent_fold() vim.fn.VSCodeNotify("editor.gotoParentFold") end
function Vscode_next_folding_section() vim.fn.VSCodeNotify("editor.gotoNextFold") end
function Vscode_prev_folding_section() vim.fn.VSCodeNotify("editor.gotoPreviousFold") end

--# Vscode: All remaps
function Vscode_toggle_typewriter() vim.fn.VSCodeNotify("toggleTypewriter") end

--# Vscode: Normal remaps
function Vscode_trim_left() vim.fn.VSCodeNotify("yo1dog.cursor-trim.lTrimCursor") end
function Vscode_trim_right() vim.fn.VSCodeNotify("yo1dog.cursor-trim.rTrimCursor") end
function Vscode_trim_both() vim.fn.VSCodeNotify("yo1dog.cursor-trim.trimCursor") end
function Vscode_reveal_definition_aside() vim.fn.VSCodeNotify("editor.action.revealDefinitionAside") end
function Vscode_toggle_sticky_scroll() vim.fn.VSCodeNotify("editor.action.toggleStickyScroll") end
function Vscode_trim_trailing_whitespace() vim.fn.VSCodeNotify("editor.action.trimTrailingWhitespace") end
function Vscode_open_link() vim.fn.VSCodeNotify("editor.action.openLink") end
function Vscode_insert_line_above() vim.fn.VSCodeCall("editor.action.insertLineBefore") end
function Vscode_insert_line_above_moveup() Vscode_insert_line_above() vim.cmd("norm k") end
function Vscode_outdent() vim.fn.VSCodeNotify("editor.action.outdentLines") end
function Vscode_indent() vim.fn.VSCodeNotify("editor.action.indentLines") end
function Vscode_comment() vim.fn.VSCodeNotify("editor.action.commentLine") end
function Vscode_reindent() vim.fn.VSCodeNotify("editor.action.reindentlines") end
function Vscode_convert_to_spaces() vim.fn.VSCodeNotify("editor.action.indentationToSpaces") end
function Vscode_convert_to_tabs() vim.fn.VSCodeNotify("editor.action.indentationToTabs") end
function Vscode_indent_with_spaces() vim.fn.VSCodeNotify("editor.action.indentUsingSpaces") end
function Vscode_indent_with_tabs() vim.fn.VSCodeNotify("editor.action.indentUsingTabs") end
function Vscode_change_encoding() vim.fn.VSCodeNotify("workbench.action.editor.changeEncoding") end
function Vscode_rename_symbol() vim.fn.VSCodeNotify("editor.action.rename") end

--# Vscode: Visual remaps
function Vscode_vis_codesnap() vim.fn.VSCodeNotifyVisual("codesnap.start", true) end
function Vscode_vis_outdent() vim.fn.VSCodeNotifyVisual("editor.action.outdentLines", false) end
function Vscode_vis_indent() vim.fn.VSCodeNotifyVisual("editor.action.indentLines", false) end
function Vscode_vis_comment() vim.fn.VSCodeNotifyVisual("editor.action.commentLine", false) end
function Vscode_vis_reindent() vim.fn.VSCodeNotifyVisual("editor.action.reindentselectedlines", true) end

--- Plugins: options
vim.g.camelcasemotion_key = "<leader>"
vim.g.targets_nl          = "nh"

--- Vscode
if vim.g.vscode then

    --# Vscode: All remaps
    vim.keymap.set("", "zy", Vscode_toggle_typewriter)
    vim.keymap.set("", "zp", Vscode_goto_parent_fold)
    vim.keymap.set("", "]f", Vscode_next_folding_section)
    vim.keymap.set("", "[f", Vscode_prev_folding_section)

    --# Vscode: Normal remaps
    vim.keymap.set("n", "gD",        Vscode_reveal_definition_aside)
    vim.keymap.set("n", "<leader>s", Vscode_toggle_sticky_scroll)
    vim.keymap.set("n", "<leader>r", Vscode_rename_symbol)
    vim.keymap.set("n", "==",        Vscode_trim_trailing_whitespace)
    vim.keymap.set("n", "gl",        Vscode_open_link)
    vim.keymap.set("n", "<C-k>",     Vscode_insert_line_above_moveup)
    vim.keymap.set("n", "<<",        Vscode_outdent)
    vim.keymap.set("n", ">>",        Vscode_indent)
    vim.keymap.set("n", "gcc",       Vscode_comment)
    vim.keymap.set("n", "=>",        Vscode_reindent)
    vim.keymap.set("n", "=s",        Vscode_convert_to_spaces)
    vim.keymap.set("n", "=t",        Vscode_convert_to_tabs)
    vim.keymap.set("n", "za",        Vscode_toggle_fold)

    --# Vscode: Visual remaps
    vim.keymap.set("v", "gs", Vscode_vis_codesnap)
    vim.keymap.set("v", "<",  Vscode_vis_outdent)
    vim.keymap.set("v", ">",  Vscode_vis_indent)
    vim.keymap.set("v", "gc", Vscode_vis_comment)

    --# Vscode: Insert remaps
    vim.keymap.set("i", "<C-k>", Vscode_insert_line_above)
end

--- Remappings
--# Hops
vim.keymap.set("", "<leader>f", Hop_forward_f_sameline)
vim.keymap.set("", "<leader>F", Hop_backward_f_sameline)
vim.keymap.set("", "<leader>t", Hop_forward_t_sameline)
vim.keymap.set("", "<leader>T", Hop_backward_t_sameline)

--# Code block text object
vim.keymap.set("v", "im", "aBV")
vim.keymap.set("v", "am", "aBVj")
vim.keymap.set("v", "iM", "aBVok")
vim.keymap.set("v", "aM", "aBVjok")
vim.keymap.set("o", "im", function() vim.cmd("normal vaBV") end)
vim.keymap.set("o", "am", function() vim.cmd("normal vaBVj") end)
vim.keymap.set("o", "iM", function() vim.cmd("normal vaBVok") end)
vim.keymap.set("o", "aM", function() vim.cmd("normal vaBVjok") end)

--# Percent sign text object
vim.keymap.set("v", "i%", "T%ot%")
vim.keymap.set("v", "a%", "F%of%")
vim.keymap.set("o", "i%", function() vim.cmd("normal vT%ot%") end)
vim.keymap.set("o", "a%", function() vim.cmd("normal vF%of%") end)

--# Markdown heading text object
vim.keymap.set("v", "ir", "?^#<CR>oNk")
vim.keymap.set("v", "agc", "[/o]/V")
vim.keymap.set("v", "igc", "[/3lo]/2h")
vim.keymap.set("o", "agc", function() vim.cmd("normal v[/o]/V") end)
vim.keymap.set("o", "igc", function() vim.cmd("normal v[/3lo]/2h") end)

--# All remaps
vim.keymap.set("", "ga", "<Plug>(EasyAlign)")
vim.keymap.set("", ";",  ":")
vim.keymap.set("", "'",  '"')
vim.keymap.set("", ":",  ",")
vim.keymap.set("", '"',  ";")
vim.keymap.set("", "gm", "gM")
vim.keymap.set("", "c",  '"_c')
vim.keymap.set("", "C",  '"_C')
vim.keymap.set("", "s",  '"_s')
vim.keymap.set("", "S",  '"_S')

--# Normal remaps
vim.keymap.set("n", "grr", "<Plug>ReplaceWithRegisterLine")
vim.keymap.set("n", "Y", "yg_")
vim.keymap.set("n", "~", "~h")
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("n", "gg", "gg")
vim.keymap.set("n", "G", "G")
vim.keymap.set("n", "*", '*N')
vim.keymap.set("n", "#", '#N')
vim.keymap.set("n", "dp", "ddp")
vim.keymap.set("n", "dP", "ddkP")
vim.keymap.set("n", "gJ", "j0d^kgJ")

--# Visual remaps
vim.keymap.set("v", "*",         'y/\\V<C-r>"<CR>N')
vim.keymap.set("v", "#",         'y?\\V<C-r>"<CR>N')
vim.keymap.set("v", "u",         "<Esc>u")
vim.keymap.set("v", "U",         "<Esc>u")
vim.keymap.set("v", "<leader>q", multiply_selection)

--# Insert remaps
vim.keymap.set("i", "<C-l>", "<C-x><C-l>")
vim.keymap.set("i", "<C-u>", '<Esc>"_S')
vim.keymap.set("i", "<C-h>", '<C-o>"_S<Esc><C-o>gI<BS>')

--# Operator pending remaps
vim.keymap.set("o", "{", "V{")
vim.keymap.set("o", "}", "V}")

--# Control remaps
vim.keymap.set("", "<C-f>", "20jzz")
vim.keymap.set("", "<C-b>", "20kzz")
vim.keymap.set("", "<C-d>", "12jzz")
vim.keymap.set("", "<C-u>", "12kzz")
vim.keymap.set("", "<C-r>", "<C-r><C-o>")

--# Leader remaps
vim.keymap.set("", "<leader>/", function() vim.cmd("noh") end)
vim.keymap.set("", "<leader>`", "'")
vim.keymap.set("", "<leader>y", function() vim.cmd("set hlsearch!") end)
vim.keymap.set("n", "<leader>q", multiply_current_character)
vim.keymap.set("n", "<leader>di", "ddddp>iBvaB<Esc>")
vim.keymap.set("n", "<leader>dd", "dddd")
vim.keymap.set("n", "<leader>pi", "p>iB")
vim.keymap.set("n", "<leader>bi", "vaBo<Esc>s=> <Esc>Jjdd")
vim.keymap.set("n", "<leader>ba", "^f(%f=c3l{<CR><Esc>o}<Esc>")
vim.keymap.set("n", "<leader>,", "mrA,<Esc>`r")
vim.keymap.set("n", "<leader>;", "mrA;<Esc>`r")

--# Register remaps: all modes
vim.keymap.set("", "'w", '"0')
vim.keymap.set("", "'i", '"_')
vim.keymap.set("", "'e", '"-')
vim.keymap.set("", "'q", '"+')
vim.keymap.set("", "'r", '".')
vim.keymap.set("", "';", '":')

--# Register remaps: insert + command mode
vim.keymap.set("!", "<C-r>w", "<C-r><C-o>0")
vim.keymap.set("!", "<C-r>e", "<C-r><C-o>-")
vim.keymap.set("!", "<C-r>q", "<C-r><C-o>+")
vim.keymap.set("!", "<C-r>r", '<C-r><C-o>"')
vim.keymap.set("!", "<C-r>;", "<C-r><C-o>:")

--# Vertical movement
vim.keymap.set("v", "_", "-")
vim.keymap.set("n", "_", "-")

print("nvim loaded")