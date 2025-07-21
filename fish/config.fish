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
set -g fish_escape_delay_ms 10
set -g fish_features qmark-noglob
set -g fish_handle_reflow 1
set -g fish_lazy_load_completions true
set -g fish_lazy_load_functions true
set -g small_threshold 46
set -gx BROWSER floorp
set -gx EDITOR helix
set -gx FZF_DEFAULT_OPTS '--tiebreak=chunk --cycle --keep-right --scroll-off=999 --hscroll-off=999 --height=-1 --layout=reverse --padding=0 --margin=0 --info=inline-right --no-scrollbar --prompt="󱕅 " --marker="󰏢" --ellipsis=… --tabstop=3 --preview-window=border-sharp --preview-window=down,wrap --color=hl:#e49641:bold,hl+:#e49641,bg+:#5f472d,fg+:#d4be98:regular,gutter:-1,info:#d4be98,prompt:#ffd75f,pointer:#e49641,marker:#d3ad5c,spinner:#d3ad5c --bind=f11:accept-or-print-query,shift-right:replace-query,alt-i:first,alt-o:last'
set -gx HISTSIZE 100000
set -gx LS_COLORS "$LS_COLORS:ow=1;34:tw=1;34:"
set -gx MANPAGER ov
set -gx QT_QPA_PLATFORMTHEME gtk3
set -gx SAVEHIST 100000
set -gx VISUAL helix
set -gx XDG_CONFIG_HOME ~/.config
set -gx _ZO_FZF_OPTS $FZF_DEFAULT_OPTS
set -gx fish_cursor_unknown line
# [[sort off]]

# [[sort on]]
set -gx TELOXIDE_TOKEN (cat ~/fes/ack/llr/axleizer)
# [[sort off]]

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

if status is-interactive
    fish_vi_cursor
    source ~/fes/dot/fish/abbreviations.fish
end
