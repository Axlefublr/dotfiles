#!/usr/bin/env fish

set -Ux LS_COLORS "$LS_COLORS:ow=1;34:tw=1;34:"
set -Ux PAGER /usr/bin/less
set -Ux HISTSIZE 100000
set -Ux SAVEHIST 100000
set -Ux _ZO_FZF_OPTS '--layout default --height 100%'
set -Ux DOTNET_CLI_TELEMETRY_OPTOUT true
set -Ux LESSKEYIN /opt/lesskey
set -Ux XMODIFIERS @im=none
set -Ux QT_QPA_PLATFORMTHEME gtk3
set -Ux NEOVIDE_FORK false
set -Ux PGDATABASE dvdrental
set -Ux PGUSER postgres
set -Ux PYTHONSTARTUP ~/prog/dotfiles/pyrc.py
set -Ux TELOXIDE_TOKEN (cat ~/prog/info/pswds/axleizer-api)
set -Ux XDG_CONFIG_HOME ~/.config
set -Ux _ZO_MAXAGE 30000
set -Ux http_proxy http://(cat ~/.local/share/magazine/p)[1]
set -Ux https_proxy http://(cat ~/.local/share/magazine/p)[1]

set -Ux fish_lsp_enabled_handlers formatting complete hover rename definition references diagnostics signatureHelp codeAction index
# set -Ux fish_lsp_disabled_handlers
set -Ux fish_lsp_format_tabsize 4
set -Ux fish_lsp_all_indexed_paths ~/prog/dotfiles/fish/fun ~/.config/fish /usr/share/fish
# set -Ux fish_lsp_modifiable_paths
# 2003 is "universal variable defined not in interactive session"
# 2001 is something about single quotes being used for an expandable thing
# 2002 is "alias used, prefer functions instead" like WOW that is one of the stupidest lints I have ever seen
set -Ux fish_lsp_diagnostic_disable_error_codes 2003 2001 2002
set -Ux fish_lsp_show_client_popups false

set -U fish_lazy_load_completions true
set -U fish_lazy_load_functions true
set -U fish_escape_delay_ms 10
set -U fish_handle_reflow 1
set -U fish_user_paths "$HOME/prog/binaries" "$HOME/prog/dotfiles/fish" "$HOME/prog/dotfiles/fish/fun" "$HOME/prog/dotfiles/scripts" "$HOME/prog/dotfiles/scripts/trenchcoat" "$HOME/prog/dotfiles/scripts/assassin" "$HOME/.local/bin" "$HOME/Apps" "$HOME/go/bin" "$HOME/.dotnet/tools" "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.local/share/gem/ruby/3.3.0/bin" "$HOME/.nimble/bin"
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
set -U fish_color_selection -b 5f472d

set -U fish_cursor_default block
set -U fish_cursor_insert line
set -U fish_cursor_replace_one underscore
set -U fish_cursor_visual block

set -U small_threshold 46
set -U head F8:5C:7D:3E:67:1F
set -U ear 68:D6:ED:18:9A:56
set -U speaker F8:5C:7E:09:29:AD
set -U controller 80:D2:1D:F3:A5:38
