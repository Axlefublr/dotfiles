Map("", "<C-d>", "6j")
Map("", "<C-u>", "6k")
Map("", ";", ":")
Map("", "'", '"')
Map("", ":", ",")
Map("", '"', ";")
Map("", "<C-f>", "12jzz")
Map("", "<C-b>", "12kzz")
Map("", "/", "/\\V")
Map("", "?", "?\\V")
Map("", "]r", "/\\v")
Map("", "[r", "?\\v")
Map("", "q", "ge")
Map("", "Q", "gE")
Map("", "X", '"_x')
Map("", "zp", "]p")
Map("", "zP", "]P")

Map({"n", "v"}, '`', '@')
Map({"n", "v"}, '``', '@@')

Map("v", "u", "<Esc>u")
Map("v", "s", ":s`\\V")

Map("i", "<C-l>", "<C-x><C-l>")
Map("i", "<C-k>", "<C-o>O")
-- Map("i", "<C-j>", "<C-o>o")

Map("o", "{", "V{")
Map("o", "}", "V}")
Map("o", "+", "v+")
Map("o", "-", "v-")

Map("n", "<C-k>", "O<Esc>")
Map("n", "<C-j>", "o<Esc>")
Map("n", "R", "q")
Map("n", "gK", "K")
Map("n", "Y", "yg_")
Map("n", "~", "~h")
Map("n", "dp", "ddp")
Map("n", "dP", "ddkP")
Map("n", "yp", "yyp")
Map("n", "yP", "yyP")
Map("n", "&", ":%s`\\V")
Map("n", "@", "R")