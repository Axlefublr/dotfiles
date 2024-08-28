#!/usr/bin/env fish

#-------------------------------------------------overrides-------------------------------------------------
set -gx BROWSER /usr/bin/vivaldi
set -gx FZF_DEFAULT_OPTS '--tiebreak=chunk --cycle --keep-right --scroll-off=999 --hscroll-off=999 --height=~100% --layout=reverse --padding=0 --margin=0 --info=inline-right --no-scrollbar --prompt="󱕅 " --pointer="▶" --marker="󰏢" --ellipsis=… --tabstop=3 --color=hl:#ffd75f:bold,hl+:#ffd75f,bg+:#1a1919,fg+:#d4be98:regular,gutter:#292828,info:#d4be98,prompt:#ffd75f,pointer:#ffd75f,marker:#ffafd7,spinner:#ffd75f --bind=f2:accept-or-print-query,alt-d:clear-screen,alt-q:jump,alt-\;:replace-query'
set -gx EDITOR helix
set -gx VISUAL helix

zoxide init fish | source

if status is-interactive
    for file in ~/prog/dotfiles/fish/abbreviations/*.fish
        source $file
    end

    function bind_both
        bind -M insert $argv
        bind -M insert $argv
    end

    #------------------------------------------------vim mode------------------------------------------------
    bind -M default daw forward-single-char forward-single-char backward-word kill-word delete-char
    bind -M default daW forward-single-char forward-single-char backward-bigword kill-bigword delete-char

    bind -M default -m insert caw forward-single-char forward-single-char backward-word kill-word delete-char repaint-mode
    bind -M default -m insert caW forward-single-char forward-single-char backward-bigword kill-bigword delete-char repaint-mode

    bind -M default X delete-char forward-single-char backward-char
    bind -M default x begin-selection kill-selection end-selection repaint-mode

    bind -M default -m insert cie 'commandline ""'
    bind -M default die 'commandline ""'
    bind -M default Y 'commandline | xclip -r -selection clipboard'

    bind -M default v edit_command_buffer
    bind -M default : repeat-jump-reverse
    bind -M default \; repeat-jump

    bind K exit

    #--------------------------------------------------core--------------------------------------------------
    bind_both \el l # believe it or not, this is yazi
    bind_both \ep lazygit

    #-------------------------------------------------other-------------------------------------------------
    bind_both \eo expand-abbr
    bind -M insert / expand-abbr self-insert

    bind -M insert \e\r expand-abbr insert-line-under
    bind -M insert -k f4 'commandline ""' # is ctrl+alt+u

    bind_both -k f5 forward-word # is shift+alt+;
    bind_both \e\; accept-autosuggestion

    bind_both \ed clear-screen repaint
    bind_both \eu 'for cmd in sudo doas please; if command -q $cmd; fish_commandline_prepend $cmd; break; end; end'
end
