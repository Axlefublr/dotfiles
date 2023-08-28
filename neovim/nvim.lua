Cmd("colorscheme gruvbox-material")

local function closeEditor()
	Cmd("x")
end
Map("n", "K", closeEditor)
Map("i", "<C-]>", closeEditor)

local function close_without_saving()
	Cmd("q!")
end
Map("n", ",K", close_without_saving)

local function save_vim() Cmd("w") end
Map("", "U", save_vim)
Map("", "<Space>", save_vim)

local move_to_bottom_screen__center_screen = 'Lzz'
Map("", "L", move_to_bottom_screen__center_screen)

local move_to_top_screen__center_screen = 'Hzz'
Map("", "H", move_to_top_screen__center_screen)