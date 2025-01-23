#!/usr/bin/env fish

set -gx FZF_DEFAULT_OPTS '--tiebreak=chunk --cycle --keep-right --scroll-off=999 --hscroll-off=999 --height=-1 --layout=reverse --padding=0 --margin=0 --info=inline-right --no-scrollbar --prompt="󱕅 " --marker="󰏢" --ellipsis=… --tabstop=3 --preview-window=border-sharp --preview-window=down,wrap --color=hl:#e49641:bold,hl+:#e49641,bg+:#5f472d,fg+:#d4be98:regular,gutter:#292828,info:#d4be98,prompt:#ffd75f,pointer:#e49641,marker:#d3ad5c,spinner:#d3ad5c --bind=f2:accept-or-print-query,alt-d:clear-screen,alt-q:jump,alt-\;:replace-query,alt-,:beginning-of-line,alt-.:end-of-line,alt-i:first,alt-o:last'
set -gx BROWSER firefox
set -gx EDITOR helix
set -gx VISUAL helix
set -gx MANPAGER cat

zoxide init fish | source

if status is-interactive
    for file in ~/prog/dotfiles/fish/abbreviations/*.fish
        source $file
    end
end
