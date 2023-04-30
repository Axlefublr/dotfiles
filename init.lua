--- Options
vim.opt.number            = true
vim.opt.relativenumber    = true
vim.opt.tabstop           = 3
vim.opt.smartindent       = true
vim.opt.mouse             = "a"
vim.opt.ignorecase        = true
vim.opt.smartcase         = true
vim.opt.hlsearch          = true
vim.g.mapleader           = ","
vim.opt.syntax            = "enable"
vim.opt.termguicolors     = true
vim.opt.background        = "dark"
vim.g.camelcasemotion_key = "<leader>"
vim.g.targets_nl          = "nh"
vim.cmd("colorscheme tender")
local hop = require("hop")
local directions = require("hop.hint").HintDirection

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

vim.g.clipboard = {
    name = "wslclipboard",
    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf"
    },
    cache_enabled = true
}

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
vim.keymap.set("n", "<leader>mq", "mq")
vim.keymap.set("n", "<leader>mw", "mw")
vim.keymap.set("n", "<leader>me", "me")
vim.keymap.set("n", "<leader>mr", "mr")
vim.keymap.set("n", "<leader>mt", "mt")
vim.keymap.set("n", "<leader>my", "my")
vim.keymap.set("n", "<leader>mu", "mu")
vim.keymap.set("n", "<leader>mi", "mi")
vim.keymap.set("n", "<leader>mo", "mo")
vim.keymap.set("n", "<leader>mp", "mp")
vim.keymap.set("n", "<leader>ma", "ma")
vim.keymap.set("n", "<leader>ms", "ms")
vim.keymap.set("n", "<leader>md", "md")
vim.keymap.set("n", "<leader>mf", "mf")
vim.keymap.set("n", "<leader>mg", "mg")
vim.keymap.set("n", "<leader>mh", "mh")
vim.keymap.set("n", "<leader>mj", "mj")
vim.keymap.set("n", "<leader>mk", "mk")
vim.keymap.set("n", "<leader>ml", "ml")
vim.keymap.set("n", "<leader>mz", "mz")
vim.keymap.set("n", "<leader>mx", "mx")
vim.keymap.set("n", "<leader>mc", "mc")
vim.keymap.set("n", "<leader>mv", "mv")
vim.keymap.set("n", "<leader>mb", "mb")
vim.keymap.set("n", "<leader>mn", "mn")
vim.keymap.set("n", "<leader>mm", "mm")
vim.keymap.set("n", "<leader>`q", "`q")
vim.keymap.set("n", "<leader>`w", "`w")
vim.keymap.set("n", "<leader>`e", "`e")
vim.keymap.set("n", "<leader>`r", "`r")
vim.keymap.set("n", "<leader>`t", "`t")
vim.keymap.set("n", "<leader>`y", "`y")
vim.keymap.set("n", "<leader>`u", "`u")
vim.keymap.set("n", "<leader>`i", "`i")
vim.keymap.set("n", "<leader>`o", "`o")
vim.keymap.set("n", "<leader>`p", "`p")
vim.keymap.set("n", "<leader>`a", "`a")
vim.keymap.set("n", "<leader>`s", "`s")
vim.keymap.set("n", "<leader>`d", "`d")
vim.keymap.set("n", "<leader>`f", "`f")
vim.keymap.set("n", "<leader>`g", "`g")
vim.keymap.set("n", "<leader>`h", "`h")
vim.keymap.set("n", "<leader>`j", "`j")
vim.keymap.set("n", "<leader>`k", "`k")
vim.keymap.set("n", "<leader>`l", "`l")
vim.keymap.set("n", "<leader>`z", "`z")
vim.keymap.set("n", "<leader>`x", "`x")
vim.keymap.set("n", "<leader>`c", "`c")
vim.keymap.set("n", "<leader>`v", "`v")
vim.keymap.set("n", "<leader>`b", "`b")
vim.keymap.set("n", "<leader>`n", "`n")
vim.keymap.set("n", "<leader>`m", "`m")

function FeedKeysCorrectly(keys)
    local feedableKeys = vim.api.nvim_replace_termcodes(keys, true, false, true)
    vim.api.nvim_feedkeys(feedableKeys, "n", true)
end

function CenterScreen() vim.cmd("call <SNR>4_reveal('center', 0)") end
function TopScreen() vim.cmd("call <SNR>4_reveal('top', 0)") end
function BottomScreen() vim.cmd("call <SNR>4_reveal('bottom', 0)") end

if vim.g.vscode then

    function Toggle_typewriter() vim.fn.VSCodeNotify("toggleTypewriter") end
    vim.keymap.set("", "zy", Toggle_typewriter)

    function Goto_parent_fold() vim.fn.VSCodeNotify("editor.gotoParentFold") end
    vim.keymap.set("", "zp", Goto_parent_fold)

    function Next_folding_section() vim.fn.VSCodeNotify("editor.gotoNextFold") end
    vim.keymap.set("", "]f", Next_folding_section)

    function Prev_folding_section() vim.fn.VSCodeNotify("editor.gotoPreviousFold") end
    vim.keymap.set("", "[f", Prev_folding_section)

    function Trim_trailing_whitespace() vim.fn.VSCodeNotify("editor.action.trimTrailingWhitespace") end
    vim.keymap.set("n", "==", Trim_trailing_whitespace)

    function Save() vim.fn.VSCodeCall("workbench.action.files.save") end

    function Trim_trailing_whitespace__Save()
        Trim_trailing_whitespace()
        Save()
    end
    vim.keymap.set("", "U", Trim_trailing_whitespace__Save)

    function Reveal_definition_aside() vim.fn.VSCodeNotify("editor.action.revealDefinitionAside") end
    vim.keymap.set("n", "gD", Reveal_definition_aside)

    function Toggle_sticky_scroll() vim.fn.VSCodeNotify("editor.action.toggleStickyScroll") end
    vim.keymap.set("n", "<leader>s", Toggle_sticky_scroll)

    function Rename_symbol() vim.fn.VSCodeNotify("editor.action.rename") end
    vim.keymap.set("n", "<leader>r", Rename_symbol)

    function Open_link() vim.fn.VSCodeNotify("editor.action.openLink") end
    vim.keymap.set("n", "gl", Open_link)

    function Outdent()
    ---@diagnostic disable-next-line: unused-local
        for i = 1, vim.v.count1 do
            vim.fn.VSCodeNotify("editor.action.outdentLines")
        end
    end
    vim.keymap.set("n", "<<", Outdent)

    function Indent()
    ---@diagnostic disable-next-line: unused-local
        for i = 1, vim.v.count1 do
            vim.fn.VSCodeNotify("editor.action.indentLines")
        end
    end
    vim.keymap.set("n", ">>", Indent)

    function Comment() vim.fn.VSCodeNotify("editor.action.commentLine") end
    vim.keymap.set("n", "gcc", Comment)

    function Reindent() vim.fn.VSCodeNotify("editor.action.reindentlines") end
    vim.keymap.set("n", "=>", Reindent)

    function Convert_to_spaces() vim.fn.VSCodeNotify("editor.action.indentationToSpaces") end
    vim.keymap.set("n", "=s", Convert_to_spaces)

    function Convert_to_tabs() vim.fn.VSCodeNotify("editor.action.indentationToTabs") end
    vim.keymap.set("n", "=t", Convert_to_tabs)

    function Toggle_fold() vim.fn.VSCodeNotify("editor.toggleFold") end
    vim.keymap.set("n", "za", Toggle_fold)

    function Format_document()
        vim.fn.VSCodeNotify("editor.action.formatDocument")
        Trim_trailing_whitespace()
    end
    vim.keymap.set("n", "=ie", Format_document)

    function Git_stage_file() vim.fn.VSCodeNotify("git.stage") end
    vim.keymap.set("n", "<leader>ga", Git_stage_file)

    function Git_stage_all() vim.fn.VSCodeNotify("git.stageAll") end
    vim.keymap.set("n", "<leader>gA", Git_stage_all)

    function Git_unstage_file() vim.fn.VSCodeNotify("git.unstage") end
    vim.keymap.set("n", "<leader>gu", Git_unstage_file)

    function Git_commit() vim.fn.VSCodeNotify("git.commit") end

    function Trim_trailing_whitespace__Save__Git_commit()
        Trim_trailing_whitespace__Save()
        Git_commit()
    end
    vim.keymap.set("n", "<leader>gm", Trim_trailing_whitespace__Save__Git_commit)

    function Git_commit_amend() vim.fn.VSCodeNotify("git.commitStagedAmend") end
    vim.keymap.set("n", "<leader>gM", Git_commit_amend)

    function Git_push() vim.fn.VSCodeNotify("git.push") end
    vim.keymap.set("n", "<leader>gp", Git_push)

    function Git_push_force() vim.fn.VSCodeNotify("git.pushForce") end
    vim.keymap.set("n", "<leader>gP", Git_push_force)

    function Git_revert_change() vim.fn.VSCodeNotify("git.revertSelectedRanges") end
    vim.keymap.set("n", "<leader>gr", Git_revert_change)

    function Git_stage_change() vim.fn.VSCodeNotify("git.stageSelectedRanges") end
    vim.keymap.set("n", "<leader>gt", Git_stage_change)

    function Git_unstage_change() vim.fn.VSCodeNotify("git.unstageSelectedRanges") end
    vim.keymap.set("n", "<leader>gT", Git_unstage_change)

    function Git_open_changes() vim.fn.VSCodeNotify("git.openChange") end
    vim.keymap.set("n", "<leader>gn", Git_open_changes)

    function Codesnap() vim.fn.VSCodeNotifyVisual("codesnap.start", true) end
    vim.keymap.set("v", "gs", Codesnap)

    function Outdent_vis() vim.fn.VSCodeNotifyVisual("editor.action.outdentLines", false) end
    vim.keymap.set("v", "<", Outdent_vis)

    function Indent_vis() vim.fn.VSCodeNotifyVisual("editor.action.indentLines", false) end
    vim.keymap.set("v", ">", Indent_vis)

    function Comment_vis() vim.fn.VSCodeNotifyVisual("editor.action.commentLine", false) end
    vim.keymap.set("v", "gc", Comment_vis)

else
    function Save_vim() vim.cmd("w") end
    vim.keymap.set("", "U", Save_vim)
end

local EasyAlignMapping = "<Plug>(EasyAlign)"
vim.keymap.set("", "ga", EasyAlignMapping)

local ReplaceWithRegisterMapping = "<Plug>ReplaceWithRegisterLine"
vim.keymap.set("n", "grr", ReplaceWithRegisterMapping)

function Hop_forward_f_sameline()
    hop.hint_char1({
        direction = directions.AFTER_CURSOR,
        current_line_only = true
    })
end
vim.keymap.set("", "<leader>f", Hop_forward_f_sameline)

function Hop_backward_f_sameline() hop.hint_char1({
    direction = directions.BEFORE_CURSOR,
    current_line_only = true
})
end
vim.keymap.set("", "<leader>F", Hop_backward_f_sameline)

function Hop_forward_t_sameline() hop.hint_char1({
    direction = directions.AFTER_CURSOR,
    current_line_only = true,
    hint_offset = -1,
})
end
vim.keymap.set("", "<leader>t", Hop_forward_t_sameline)

function Hop_backward_t_sameline() hop.hint_char1({
    direction = directions.BEFORE_CURSOR,
    current_line_only = true,
    hint_offset = 1,
})
end
vim.keymap.set("", "<leader>T", Hop_backward_t_sameline)

local Block_text_object_self_sameline = "aBV"
vim.keymap.set("v", "im", Block_text_object_self_sameline)

local Block_text_object_extra_sameline = "aBVj"
vim.keymap.set("v", "am", Block_text_object_extra_sameline)

local Block_text_object_self_diffline = "aBVok"
vim.keymap.set("v", "iM", Block_text_object_self_diffline)

local Block_text_object_extra_diffline = "aBVjok"
vim.keymap.set("v", "aM", Block_text_object_extra_diffline)

function Block_text_object_self_sameline_operator() vim.cmd("normal vaBV") end
vim.keymap.set("o", "im", Block_text_object_self_sameline_operator)

function Block_text_object_extra_sameline_operator() vim.cmd("normal vaBVj") end
vim.keymap.set("o", "am", Block_text_object_extra_sameline_operator)

function Block_text_object_self_diffline_operator() vim.cmd("normal vaBVok") end
vim.keymap.set("o", "iM", Block_text_object_self_diffline_operator)

function Block_text_object_extra_diffline_operator() vim.cmd("normal vaBVjok") end
vim.keymap.set("o", "aM", Block_text_object_extra_diffline_operator)

local Percent_sign_text_object_self_visual = "T%ot%"
vim.keymap.set("v", "i%", Percent_sign_text_object_self_visual)

local Percent_sign_text_object_extra_visual = "F%of%"
vim.keymap.set("v", "a%", Percent_sign_text_object_extra_visual)

function Percent_sign_text_object_self_operator() vim.cmd("normal vT%ot%") end
vim.keymap.set("o", "i%", Percent_sign_text_object_self_operator)

function Percent_sign_text_object_extra_operator() vim.cmd("normal vF%of%") end
vim.keymap.set("o", "a%", Percent_sign_text_object_extra_operator)

local Markdown_heading_text_object_self_sameline_visual = "?^#<CR>oNk"
vim.keymap.set("v", "ir", Markdown_heading_text_object_self_sameline_visual)

local Markdown_heading_text_object_self_diffline_visual = "?^#<CR>koNk"
vim.keymap.set("v", "iR", Markdown_heading_text_object_self_diffline_visual)

local Comment_text_object_self_visual = "[/3lo]/2h"
vim.keymap.set("v", "igc", Comment_text_object_self_visual)

local Comment_text_object_extra_visual = "[/o]/V"
vim.keymap.set("v", "agc", Comment_text_object_extra_visual)

function Comment_text_object_extra_operator() vim.cmd("normal v[/o]/V") end
vim.keymap.set("o", "agc", Comment_text_object_extra_operator)

function Comment_text_object_self_operator() vim.cmd("normal v[/3lo]/2h") end
vim.keymap.set("o", "igc", Comment_text_object_self_operator)

function Goto_end_of_prev_line() FeedKeysCorrectly(vim.v.count1 .. "k$") end
vim.keymap.set("", "_", Goto_end_of_prev_line)

local Command_mode_remap = ":"
vim.keymap.set("", ";", Command_mode_remap)

local Register_access_remap = '"'
vim.keymap.set("", "'", Register_access_remap)

local Redo_seek_motion_backwards = ","
vim.keymap.set("", ":", Redo_seek_motion_backwards)

local Redo_seek_motion_forwards = ";"
vim.keymap.set("", '"', Redo_seek_motion_forwards)

local Goto_middle_of_line = "gM"
vim.keymap.set("", "gm", Goto_middle_of_line)

local Small_substitute_doesnt_consume_register = '"_s'
vim.keymap.set("", "s", Small_substitute_doesnt_consume_register)

local Big_substitute_doesnt_consume_register = '"_S'
vim.keymap.set("", "S", Big_substitute_doesnt_consume_register)

local Capital_yank_doesnt_consume_newline = "yg_"
vim.keymap.set("n", "Y", Capital_yank_doesnt_consume_newline)

local Switch_case_stays_in_place = "~h"
vim.keymap.set("n", "~", Switch_case_stays_in_place)

local Capital_q_executes_m_register = "@m"
vim.keymap.set("n", "Q", Capital_q_executes_m_register)

vim.keymap.set("n", "dp", "ddp")

vim.keymap.set("n", "dP", "ddkP")

vim.keymap.set("n", "yp", "yyp")

vim.keymap.set("n", "yP", "yyP")

vim.keymap.set("n", "gJ", "j0d^kgJ")

vim.keymap.set("n", "<Space>", "i <Esc>")

vim.keymap.set("v", "*", 'y/\\V<C-r>"<CR>')

vim.keymap.set("v", "#", 'y?\\V<C-r>"<CR>')

vim.keymap.set("v", "u", "<Esc>u")

vim.keymap.set("v", "<leader>q", function() FeedKeysCorrectly("ygv<Esc>" .. vim.v.count1 .. "p") end)

vim.keymap.set("i", "<C-l>", "<C-x><C-l>")

vim.keymap.set("i", "<C-i>", '<Esc>"_S')

vim.keymap.set("i", "<C-h>", '<C-o>"_S<Esc><C-o>gI<BS>')

vim.keymap.set("i", "<C-k>", "<C-o>O")

vim.keymap.set("i", "<C-j>", "<C-o>o")

vim.keymap.set("o", "{", "V{")

vim.keymap.set("o", "}", "V}")

vim.keymap.set("", "<C-f>", "20jzz")

vim.keymap.set("", "<C-b>", "20kzz")

vim.keymap.set("", "<C-d>", "12jzz")

vim.keymap.set("", "<C-u>", "12kzz")

vim.keymap.set("", "<C-r>", "<C-r><C-p>")

vim.keymap.set("n", "<C-k>", "O<Esc>")

vim.keymap.set("n", "<C-j>", "o<Esc>")

vim.keymap.set("n", "<CR>", "i<CR><Esc>")

vim.keymap.set("", "<leader>/", function() vim.cmd("noh") end)

vim.keymap.set("", "<leader>m", function() vim.cmd("set hlsearch!") end)

vim.keymap.set("n", "<leader>q", function() FeedKeysCorrectly("yl" .. vim.v.count1 .. "p") end)

vim.keymap.set("n", "<leader>di", '"_ddddpvaB<Esc>')

vim.keymap.set("n", "<leader>bi", "vaBo<Esc>s=> <Esc>Jjdd")

vim.keymap.set("n", "<leader>ba", "^f(%f=c3l{<CR><Esc>o}<Esc>")

vim.keymap.set("n", "<leader>,", "mrA,<Esc>`r")

vim.keymap.set("n", "<leader>;", "mrA;<Esc>`r")

vim.keymap.set("n", "<leader>in", "mRggO#Include <")

vim.keymap.set("", "'q", '"+')

vim.keymap.set("", "'w", '"0')

vim.keymap.set("", "'i", '"_')

vim.keymap.set("", "';", '":')

local PasteSystemClipboard = "<C-r><C-p>+"
vim.keymap.set("!", "<C-v>", PasteSystemClipboard)

vim.keymap.set("!", "<C-r>w", "<C-r><C-p>0")

vim.keymap.set("!", "<C-r>;", "<C-r><C-p>:")

vim.keymap.set("!", "<C-b>",  '<C-r><C-p>"')

print("nvim loaded")