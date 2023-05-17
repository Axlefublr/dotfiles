# fish_vi_key_bindings

set -g color_pink FFAFD7
set -g color_purple AF87FF
set -g color_grey 878787
set -g color_yellow FFD75F
set -g color_green 87FF5F
set -g color_cyan 00D7FF
set -g color_red FF005F
set -g color_orange FF8700

set -g fish_lazy_load_completions 'true'
set -g fish_lazy_load_functions 'true'

set -g tide_left_prompt_items pwd context shlvl jobs git status cmd_duration newline time character
set -g tide_right_prompt_items

set -g tide_character_color $color_pink
set -g tide_character_color_failure $color_pink
set -g tide_character_icon '>>>'
set -g tide_character_vi_icon_default '$$$'
set -g tide_character_vi_icon_replace '$$$'
set -g tide_character_vi_icon_visual 'OOO'

set -g tide_time_format '%H:%M'

set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

set -g fish_prompt_vim_symbol
