#!/usr/bin/env fish

# [[sort on]]
set -g fish_features qmark-noglob remove-percent-self
set -g fish_lazy_load_completions true
set -g fish_lazy_load_functions true
set -g in (cat ~/.cache/mine/blammo 2>/dev/null)
set -gx BROWSER firefox
set -gx EDITOR helix
set -gx HISTSIZE 100000
set -gx LS_COLORS "$LS_COLORS:ow=1;34:tw=1;34:"
set -gx MANPAGER ov
set -gx MOZ_ENABLE_WAYLAND 1
set -gx QT_QPA_PLATFORMTHEME gtk3
set -gx SAVEHIST 100000
set -gx SKIM_DEFAULT_OPTIONS --reverse
set -gx TELOXIDE_TOKEN (cat ~/fes/uviw/lvia/axleizer)
set -gx VISUAL helix
set -gx XDG_CONFIG_HOME ~/.config
set -gx _ZO_FZF_OPTS $FZF_DEFAULT_OPTS
# [[sort off]]

set -gx FZF_DEFAULT_OPTS \
    --scheme=path \
    --tiebreak=pathname,index \
    --walker=file,dir,follow,hidden \
    --cycle --keep-right \
    --scroll-off=999 --hscroll-off=999 \
    --height=-1 --layout=reverse --padding=0 --margin=0 \
    --info=inline-right --no-scrollbar \
    '--prompt="> "' --marker="" --ellipsis=… \
    --tabstop=3 \
    --preview-window=border-sharp --preview-window=down,wrap \
    '--gutter=" "' \
    --color=hl:#e49641:bold,hl+:#e49641,bg+:#5f472d,fg+:#d4be98:regular,info:#d4be98,prompt:#ffd75f,pointer:#e49641,marker:#b58cc6,spinner:#d3ad5c \
    --bind=f11:accept-or-print-query,shift-right:replace-query,ctrl-home:first,ctrl-end:last

zoxide init fish | source
function __zoxide_hook
end
function __zoxide_z
    set -l argc (builtin count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
        command zoxide add -- (__zoxide_pwd)
    else if test $argc -eq 2 -a $argv[1] = --
        __zoxide_cd -- $argv[2]
        command zoxide add -- (__zoxide_pwd)
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
        and command zoxide add -- (__zoxide_pwd)
    end
end

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
set -g fish_escape_delay_ms 10
set -g fish_handle_reflow 1
set -g fish_key_bindings fish_default_key_bindings
set -g fish_pager_color_completion normal
set -g fish_pager_color_description yellow -i
set -g fish_pager_color_prefix normal --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan
set -g fish_pager_color_selected_background -r
set -g small_threshold 46
# [[sort off]]

fish_vi_cursor
abbr -a .. --position anywhere --regex '^\.\.+$' --function multiple_dot
source ~/fes/dot/fish/abbreviations.fish
