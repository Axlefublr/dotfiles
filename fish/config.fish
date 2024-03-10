#!/usr/bin/env fish

set -gx LS_COLORS "$LS_COLORS:ow=1;34:tw=1;34:"
set -gx EDITOR 'nvim'
set -gx VISUAL 'nvim'
set -gx PAGER '/usr/bin/less'
set -gx BROWSER '/usr/bin/vivaldi-stable'
set -gx HISTSIZE 10000
set -gx FZF_DEFAULT_OPTS '--layout=default --height=100%'
set -gx _ZO_FZF_OPTS '--layout default --height 100%'
set -gx SAVEHIST 10000
set -gx DOTNET_CLI_TELEMETRY_OPTOUT true
set -gx RANGER_LOAD_DEFAULT_RC true
set -gx MANPAGER 'nvim +Man!'
set -gx LESSKEYIN '/opt/lesskey'
set -gx CARGO_MOMMYS_MOODS 'chill/thirsty'
set -gx XMODIFIERS @im=none
set -gx QT_QPA_PLATFORMTHEME gtk3

set -g color_pink        FFAFD7
set -g color_purple      AF87FF
set -g color_grey        878787
set -g color_yellow      FFD75F
set -g color_green       87FF5F
set -g color_cyan        00D7FF
set -g color_red         ff2930
set -g color_orange      ff9f1a
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

set -g fish_color_normal $color_gruvbox_white
set -g fish_color_command $color_gruvbox_green
set -g fish_color_quote $color_gruvbox_yellow
set -g fish_color_redirection $color_gruvbox_orange
set -g fish_color_end $color_gruvbox_orange
set -g fish_color_error $color_gruvbox_red
set -g fish_color_param $color_gruvbox_cyan
set -g fish_color_comment $color_gruvbox_grey
set -g fish_color_match $color_gruvbox_purple
set -g fish_color_operator $color_gruvbox_purple
set -g fish_color_escape $color_gruvbox_grey
set -g fish_color_autosuggestion $color_gruvbox_grey

set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

set -g small_threshold 46
set -g head F8:5C:7D:3E:67:1F
set -g ear 68:D6:ED:18:9A:56

zoxide init fish | source
for file in ~/prog/dotfiles/fish/abbreviations/*.fish
	source $file
end

bind -M default daw forward-single-char forward-single-char backward-word kill-word delete-char
bind -M default daW forward-single-char forward-single-char backward-bigword kill-bigword delete-char

bind -M default -m insert caw forward-single-char forward-single-char backward-word kill-word delete-char repaint-mode
bind -M default -m insert caW forward-single-char forward-single-char backward-bigword kill-bigword delete-char repaint-mode

bind -M default X delete-char forward-single-char backward-char
bind -M default x begin-selection kill-selection end-selection repaint-mode

bind -M default -m insert cie 'commandline ""'
bind -M default die 'commandline ""'
bind -M default yie 'commandline | xclip -r -selection clipboard'

bind -M insert \c] execute
bind -M default K execute

bind -M default v edit_command_buffer
bind -M default : repeat-jump-reverse
bind -M default \; repeat-jump

bind -M insert -k f1 'commandline -f expand-abbr ; commandline -a " && clx" ; commandline -f execute'
bind -M insert -k f2 expand-abbr insert-line-under
bind -M insert -k f3 accept-autosuggestion execute
bind -M insert -k f4 'commandline ""'

bind -M insert \ed 'clear -x'
bind -M insert \ep 'commandline -i (pwd | string replace -r $HOME \'~\')'
bind -M insert \eu list_current_token
bind -M insert -k f5 forward-word
bind -M insert \e\; accept-autosuggestion
bind -M default -k f5 forward-word
bind -M default \e\; accept-autosuggestion