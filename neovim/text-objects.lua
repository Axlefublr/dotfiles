local block_text_object_self_sameline = "aBV"
Map("v", "im", block_text_object_self_sameline)

local block_text_object_extra_sameline = "aBVj"
Map("v", "am", block_text_object_extra_sameline)

local block_text_object_self_diffline = "aBVok"
Map("v", "iM", block_text_object_self_diffline)

local block_text_object_extra_diffline = "aBVjok"
Map("v", "aM", block_text_object_extra_diffline)

local function block_text_object_self_sameline_operator()
	Cmd("normal vaBV")
end
Map("o", "im", block_text_object_self_sameline_operator)

local function block_text_object_extra_sameline_operator()
	Cmd("normal vaBVj")
end
Map("o", "am", block_text_object_extra_sameline_operator)

local function block_text_object_self_diffline_operator()
	Cmd("normal vaBVok")
end
Map("o", "iM", block_text_object_self_diffline_operator)

local function block_text_object_extra_diffline_operator()
	Cmd("normal vaBVjok")
end
Map("o", "aM", block_text_object_extra_diffline_operator)

local percent_sign_text_object_self_visual = "T%ot%"
Map("v", "i%", percent_sign_text_object_self_visual)

local percent_sign_text_object_extra_visual = "F%of%"
Map("v", "a%", percent_sign_text_object_extra_visual)

local function percent_sign_text_object_self_operator()
	Cmd("normal vT%ot%")
end
Map("o", "i%", percent_sign_text_object_self_operator)

local function percent_sign_text_object_extra_operator()
	Cmd("normal vF%of%")
end
Map("o", "a%", percent_sign_text_object_extra_operator)

local markdown_heading_text_object_self_sameline_visual = "?^#<cr>oNk"
Map("v", "ir", markdown_heading_text_object_self_sameline_visual)

local markdown_heading_text_object_self_diffline_visual = "?^#<cr>koNk"
Map("v", "iR", markdown_heading_text_object_self_diffline_visual)

local inclusive_next_blankie = "}k"
Map("n", "<leader>}", inclusive_next_blankie)
Map("v", "<leader>}", inclusive_next_blankie)

local inclusive_prev_blankie = "{j"
Map("n", "<leader>{", inclusive_prev_blankie)
Map("v", "<leader>{", inclusive_prev_blankie)

local function inclusive_next_blankie_visual() Cmd("normal V}k") end
Map("o", "<leader>}", inclusive_next_blankie_visual)

local function inclusive_prev_blankie_visual() Cmd("normal V{j") end
Map("o", "<leader>{", inclusive_prev_blankie_visual)
