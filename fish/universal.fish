#!/usr/bin/env fish

set -Ux LS_COLORS "$LS_COLORS:ow=1;34:tw=1;34:"
set -Ux PAGER /usr/bin/less
set -Ux HISTSIZE 100000
set -Ux SAVEHIST 100000
set -Ux _ZO_FZF_OPTS '--layout default --height 100%'
set -Ux DOTNET_CLI_TELEMETRY_OPTOUT true
set -Ux MANPAGER 'nvim +Man!'
set -Ux LESSKEYIN /opt/lesskey
set -Ux XMODIFIERS @im=none
set -Ux QT_QPA_PLATFORMTHEME gtk3
set -Ux NEOVIDE_FORK false
set -Ux PGDATABASE dvdrental
set -Ux PGUSER postgres
set -Ux PYTHONSTARTUP ~/prog/dotfiles/pyrc.py
set -Ux TELOXIDE_TOKEN (cat ~/prog/info/pswds/axleizer-api)

set -U fish_lazy_load_completions true
set -U fish_lazy_load_functions true
set -U fish_escape_delay_ms 10
set -U fish_handle_reflow 1
set -U fish_user_paths "$HOME/prog/binaries" "$HOME/prog/dotfiles/fish" "$HOME/prog/dotfiles/fish/fun" "$HOME/prog/dotfiles/scripts" "$HOME/prog/dotfiles/scripts/trenchcoat" "$HOME/.local/bin" "$HOME/Apps" "$HOME/go/bin" "$HOME/.dotnet/tools" "$HOME/.local/bin"
set -U fish_features qmark-noglob

set -U fish_color_normal d4be98
set -U fish_color_command a9b665
set -U fish_color_quote d3ad5c
set -U fish_color_redirection e49641
set -U fish_color_end e49641
set -U fish_color_error ea6962
set -U fish_color_param 7daea3
set -U fish_color_comment 928374
set -U fish_color_match e491b2
set -U fish_color_operator e491b2
set -U fish_color_escape 928374
set -U fish_color_autosuggestion 928374
set -U fish_color_cancel ffafd7

set -U fish_cursor_default block
set -U fish_cursor_insert line
set -U fish_cursor_replace_one underscore
set -U fish_cursor_visual block

set -U small_threshold 46
set -U head F8:5C:7D:3E:67:1F
set -U ear 68:D6:ED:18:9A:56
set -U speaker F8:5C:7E:09:29:AD
