#!/usr/bin/env fish

# [[sort on]]
set -g fish_features qmark-noglob remove-percent-self
set -gx BROWSER firefox
set -gx EDITOR helix
set -gx GTK_THEME gruvbox-material
set -gx HISTSIZE 100000
set -gx LS_COLORS "$LS_COLORS:ow=1;34:tw=1;34:"
set -gx MANPAGER ov
set -gx MOZ_ENABLE_WAYLAND 1
set -gx QT_QPA_PLATFORMTHEME gtk3
set -gx SAVEHIST 100000
set -gx VISUAL helix
set -gx XDG_CONFIG_HOME ~/.config
# [[sort off]]

set -gx FZF_DEFAULT_OPTS \
    --scheme=path \
    --tiebreak=pathname,index \
    --walker=file,dir,follow \
    --cycle --keep-right \
    --scroll-off=999 --hscroll-off=999 \
    --layout=reverse --padding=0 --margin=0 \
    --info=inline-right --no-scrollbar \
    '--prompt="> "' --marker="" --ellipsis=… \
    --tabstop=3 \
    --preview-window=border-sharp --preview-window=down,wrap \
    '--gutter=" "' \
    --color=hl:#e49641:bold,hl+:#e49641,bg+:#5f472d,fg+:#d4be98:regular,info:#d4be98,prompt:#ffd75f,pointer:#e49641,marker:#b58cc6,spinner:#d3ad5c \
    --bind=f11:accept-or-print-query,shift-right:replace-query,ctrl-home:first,ctrl-end:last
set -gx _ZO_FZF_OPTS $FZF_DEFAULT_OPTS

not status is-interactive && return

# -----------------------interactive-----------------------
# [[sort on]]
set -g fish_color_autosuggestion 928374
set -g fish_color_cancel ffafd7
set -g fish_color_command a9b665
set -g fish_color_comment 928374
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end e49641
set -g fish_color_error ea6962
set -g fish_color_escape 928374
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_host_remote yellow
set -g fish_color_match e491b2
set -g fish_color_normal d4be98
set -g fish_color_operator e491b2
set -g fish_color_param 7daea3
set -g fish_color_quote d3ad5c
set -g fish_color_redirection e49641
set -g fish_color_search_match white --background=brblack
set -g fish_color_selection -b 5f472d
set -g fish_color_status red
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline
set -g fish_cursor_unknown line
set -g fish_pager_color_completion normal
set -g fish_pager_color_description yellow -i
set -g fish_pager_color_prefix normal --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan
set -g fish_pager_color_selected_background -r
set -g in (blammo)
# [[sort off]]

abbr -a .. --position anywhere --regex '^\.\.+$' --function multiple_dot
source ~/fes/dot/fish/abbreviations.fish
