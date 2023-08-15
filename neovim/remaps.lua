local better_half_page_down = "6j"
Map("", "<C-d>", better_half_page_down)

local better_half_page_up = "6k"
Map("", "<C-u>", better_half_page_up)

local command_mode_remap = ":"
Map("", ";", command_mode_remap)

local register_access_remap = '"'
Map("", "'", register_access_remap)

local redo_seek_motion_backwards = ","
Map("", ":", redo_seek_motion_backwards)

local redo_seek_motion_forwards = ";"
Map("", '"', redo_seek_motion_forwards)

local goto_middle_of_line = "gM"
Map("", "gm", goto_middle_of_line)

local capital_yank_doesnt_consume_newline = "yg_"
Map("n", "Y", capital_yank_doesnt_consume_newline)

local switch_case_stays_in_place = "~h"
Map("n", "~", switch_case_stays_in_place)

local space_action = ""
Map("n", "<Space>", space_action)

local backspace_action = ""
Map("n", "<BS>", backspace_action)

local disable_u_visual = "<Esc>u"
Map("v", "u", disable_u_visual)

local complete_line = "<C-x><C-l>"
Map("i", "<C-l>", complete_line)

local insert_blank_line_up_insert = "<C-o>O"
Map("i", "<C-k>", insert_blank_line_up_insert)

local insert_blank_line_down_insert = "<C-o>o"
-- Map("i", "<C-j>", insert_blank_line_down_insert)

local previous_blank_line_operator = "V{"
Map("o", "{", previous_blank_line_operator)

local next_blank_line_operator = "V}"
Map("o", "}", next_blank_line_operator)

local better_page_down = "12jzz"
Map("", "<C-f>", better_page_down)

local better_page_up = "12kzz"
Map("", "<C-b>", better_page_up)

local insert_blank_line_up = "O<Esc>"
Map("n", "<C-k>", insert_blank_line_up)

local insert_blank_line_down = "o<Esc>"
Map("n", "<C-j>", insert_blank_line_down)

local repeat_replace_goes_next = "n&"
Map("n", "&", repeat_replace_goes_next)

local captal_R_records_macro = 'q'
Map("n", "R", captal_R_records_macro)

local dig_into_docs = "K"
Map("n", "gK", dig_into_docs)

local copy_current_character = 'yl'
Map("n", "X", copy_current_character)
