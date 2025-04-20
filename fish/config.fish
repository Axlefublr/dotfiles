#!/usr/bin/env fish

# [[sort on]]
set -g fish_color_autosuggestion 928374
set -g fish_color_cancel ffafd7
set -g fish_color_command a9b665
set -g fish_color_comment 928374
set -g fish_color_end e49641
set -g fish_color_error ea6962
set -g fish_color_escape 928374
set -g fish_color_match e491b2
set -g fish_color_normal d4be98
set -g fish_color_operator e491b2
set -g fish_color_param 7daea3
set -g fish_color_quote d3ad5c
set -g fish_color_redirection e49641
set -g fish_color_selection -b 5f472d
set -g fish_cursor_default line
set -g fish_escape_delay_ms 10
set -g fish_features qmark-noglob
set -g fish_handle_reflow 1
set -g fish_lazy_load_completions true
set -g fish_lazy_load_functions true
set -g small_threshold 46
set -gx BROWSER floorp
set -gx EDITOR helix
set -gx FZF_DEFAULT_OPTS '--tiebreak=chunk --cycle --keep-right --scroll-off=999 --hscroll-off=999 --height=-1 --layout=reverse --padding=0 --margin=0 --info=inline-right --no-scrollbar --prompt="󱕅 " --marker="󰏢" --ellipsis=… --tabstop=3 --preview-window=border-sharp --preview-window=down,wrap --color=hl:#e49641:bold,hl+:#e49641,bg+:#5f472d,fg+:#d4be98:regular,gutter:#292828,info:#d4be98,prompt:#ffd75f,pointer:#e49641,marker:#d3ad5c,spinner:#d3ad5c --bind=f2:accept-or-print-query,alt-d:clear-screen,alt-q:jump,alt-\;:replace-query,alt-,:beginning-of-line,alt-.:end-of-line,alt-i:first,alt-o:last'
set -gx HISTSIZE 100000
set -gx LS_COLORS "$LS_COLORS:ow=1;34:tw=1;34:"
set -gx MANPAGER ov
set -gx QT_QPA_PLATFORMTHEME gtk3
set -gx SAVEHIST 100000
set -gx VISUAL helix
set -gx XDG_CONFIG_HOME ~/.config
# [[sort off]]

# [[sort on]]
set -gx TELOXIDE_TOKEN (cat ~/r/info/pswds/axleizer-api)
set -gx http_proxy http://(cat ~/.local/share/magazine/p)[1]
set -gx https_proxy http://(cat ~/.local/share/magazine/p)[1]
# [[sort off]]

fish_vi_cursor
zoxide init fish | source

if status is-interactive
    source ~/r/dot/fish/abbreviations.fish
end
