#!/usr/bin/env fish

set -Ux LS_COLORS "$LS_COLORS:ow=1;34:tw=1;34:"
set -Ux PAGER '/usr/bin/less'
set -Ux HISTSIZE 10000
set -Ux SAVEHIST 10000
set -Ux _ZO_FZF_OPTS '--layout default --height 100%'
set -Ux DOTNET_CLI_TELEMETRY_OPTOUT true
set -Ux MANPAGER 'nvim +Man!'
set -Ux LESSKEYIN '/opt/lesskey'
set -Ux XMODIFIERS @im=none
set -Ux QT_QPA_PLATFORMTHEME gtk3
set -Ux NEOVIDE_FORK false
set -Ux PGDATABASE dvdrental
set -Ux PGUSER postgres

set -U color_pink        FFAFD7
set -U color_purple      AF87FF
set -U color_grey        878787
set -U color_yellow      FFD75F
set -U color_green       87FF5F
set -U color_cyan        00D7FF
set -U color_red         ff2930
set -U color_orange      ff9f1a
set -U color_redder_pink FF8787
set -U color_white       D4BE98

set -U color_gruvbox_white  D4BE98
set -U color_gruvbox_green  A9B665
set -U color_gruvbox_purple D3869B
set -U color_gruvbox_orange E78A4E
set -U color_gruvbox_yellow D8A657
set -U color_gruvbox_red    EA6962
set -U color_gruvbox_sea    89B482
set -U color_gruvbox_grey   928374
set -U color_gruvbox_cyan   7DAEA3

set -U fish_lazy_load_completions 'true'
set -U fish_lazy_load_functions 'true'
set -U fish_escape_delay_ms 10
set -U fish_handle_reflow 1
set -U fish_user_paths "$HOME/prog/binaries" "$HOME/prog/dotfiles/fish" "$HOME/prog/dotfiles/fish/fun" "$HOME/prog/dotfiles/scripts" "$HOME/.local/bin" "$HOME/Apps" "$HOME/go/bin" "$HOME/.dotnet/tools" "$HOME/.local/bin"

set -U fish_color_normal $color_gruvbox_white
set -U fish_color_command $color_gruvbox_green
set -U fish_color_quote $color_gruvbox_yellow
set -U fish_color_redirection $color_gruvbox_orange
set -U fish_color_end $color_gruvbox_orange
set -U fish_color_error $color_gruvbox_red
set -U fish_color_param $color_gruvbox_cyan
set -U fish_color_comment $color_gruvbox_grey
set -U fish_color_match $color_gruvbox_purple
set -U fish_color_operator $color_gruvbox_purple
set -U fish_color_escape $color_gruvbox_grey
set -U fish_color_autosuggestion $color_gruvbox_grey

set -U fish_cursor_default block
set -U fish_cursor_insert line
set -U fish_cursor_replace_one underscore
set -U fish_cursor_visual block

set -U small_threshold 46
set -U head F8:5C:7D:3E:67:1F
set -U ear 68:D6:ED:18:9A:56
set -U speaker F8:5C:7E:09:29:AD
