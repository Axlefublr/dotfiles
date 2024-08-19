#!/usr/bin/env fish

set -gx BROWSER /usr/bin/vivaldi
set -gx FZF_DEFAULT_OPTS '--tiebreak=chunk --cycle --keep-right --scroll-off=999 --hscroll-off=999 --height=~100% --layout=reverse --padding=0 --margin=0 --info=inline-right --no-scrollbar --prompt="󱕅 " --pointer="▶" --marker="󰏢" --ellipsis=… --tabstop=3 --color=hl:#ffd75f:bold,hl+:#ffd75f,bg+:#1a1919,fg+:#d4be98:regular,gutter:#292828,info:#d4be98,prompt:#ffd75f,pointer:#ffd75f,marker:#ffafd7,spinner:#ffd75f --bind=f2:accept-or-print-query,alt-d:clear-screen,alt-q:jump,alt-\;:replace-query'
set -gx EDITOR helix
set -gx VISUAL helix

zoxide init fish | source

if status is-interactive
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
    bind -M default Y 'commandline | xclip -r -selection clipboard'

    bind -M insert \c] execute
    bind -M default K execute

    bind -M default v edit_command_buffer
    bind -M default : repeat-jump-reverse
    bind -M default \; repeat-jump

    bind -M insert \e\r expand-abbr insert-line-under
    bind -M insert -k f4 'commandline ""'

    bind \eo expand-abbr
    bind -M insert \eo expand-abbr
    bind -M insert / expand-abbr self-insert
    bind dr transpose-words
    bind -M insert \ed clear-screen repaint
    bind -M default \ed clear-screen repaint
    bind -M insert \ep 'commandline -i (pwd | string replace -r $HOME \'~\')'
    bind -M insert \el list_current_token
    bind -M insert -k f5 forward-word
    bind -M insert \e\; accept-autosuggestion
    bind -M default -k f5 forward-word
    bind -M default \e\; accept-autosuggestion
    bind -M insert \eu 'for cmd in sudo doas please; if command -q $cmd; fish_commandline_prepend $cmd; break; end; end'
    bind \e/ exit
    bind -M insert \e/ exit
    bind K exit
end
