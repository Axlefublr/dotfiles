#!/usr/bin/env fish

set -gx LS_COLORS "$LS_COLORS:ow=1;34:tw=1;34:"
set -gx EDITOR 'nvim'
set -gx VISUAL 'nvim'
set -gx BROWSER '/usr/bin/vivaldi-stable'
set -gx HISTSIZE 10000
set -gx FZF_DEFAULT_OPTS '--layout=default --height=100%'
set -gx _ZO_FZF_OPTS '--layout default --height 100%'
set -gx SAVEHIST 10000
set -gx DOTNET_CLI_TELEMETRY_OPTOUT true
set -gx RANGER_LOAD_DEFAULT_RC true

set -g color_pink        FFAFD7
set -g color_purple      AF87FF
set -g color_grey        878787
set -g color_yellow      FFD75F
set -g color_green       87FF5F
set -g color_cyan        00D7FF
set -g color_red         FF005F
set -g color_orange      FF8700
set -g color_redder_pink FF8787
set -g color_white       D4BE98

set -g color_gruvbox_white  D4BE98
set -g color_gruvbox_green  A9B665
set -g color_gruvbox_purple D3869B
set -g color_gruvbox_orange E78A4E
set -g color_gruvbox_yellow D8A657
set -g color_gruvbox_red    EA6962
set -g color_gruvbox_sea    89B482
set -g color_gruvbox_grey   928374
set -g color_gruvbox_cyan   7DAEA3

set -g fish_lazy_load_completions 'true'
set -g fish_lazy_load_functions 'true'
set -g fish_escape_delay_ms 10
set -g pisces_only_insert_at_eol 1

set -g fish_color_normal $color_gruvbox_white
set -g fish_color_command $color_gruvbox_green
set -g fish_color_quote $color_gruvbox_yellow
set -g fish_color_redirection $color_gruvbox_orange
set -g fish_color_end $color_gruvbox_orange
set -g fish_color_error $color_gruvbox_red
set -g fish_color_param $color_gruvbox_sea
set -g fish_color_comment $color_gruvbox_grey
set -g fish_color_match $color_gruvbox_purple
set -g fish_color_operator $color_gruvbox_purple
set -g fish_color_escape $color_gruvbox_grey
set -g fish_color_autosuggestion $color_gruvbox_grey

set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

zoxide init fish | source
source ~/prog/dotfiles/fish/abbreviations.fish
source ~/prog/dotfiles/fish/positional.fish
source ~/prog/dotfiles/fish/relative.fish

bind -M default q backward-word forward-single-char forward-word backward-char
bind -M default Q backward-bigword forward-bigword backward-char
bind -M default daw forward-single-char forward-single-char backward-word kill-word delete-char
bind -M default daW forward-single-char forward-single-char backward-bigword kill-bigword delete-char
bind -M default -m insert caw forward-single-char forward-single-char backward-word kill-word delete-char repaint-mode
bind -M default -m insert caW forward-single-char forward-single-char backward-bigword kill-bigword delete-char repaint-mode

bind -M insert \c] execute

bind -M default K execute
bind -M default v edit_command_buffer
bind -M default : repeat-jump-reverse
bind -M default '"' repeat-jump
bind -M default \; accept-autosuggestion

bind -M insert \e\cX 'eval $history[1] | string collect | xclip -r -selection clipboard'

bind -M insert \ed 'clear -x'
bind -M insert \ev 'ranger ; commandline -f repaint'
bind -M insert \ea 'paste_relative_path'
bind -M insert \el list_current_token
bind -M insert \e\; expand-abbr accept-autosuggestion
bind -M insert \e\' forward-word