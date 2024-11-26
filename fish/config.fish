#!/usr/bin/env fish

#-------------------------------------------------overrides-------------------------------------------------
set -gx BROWSER firefox
set -gx FZF_DEFAULT_OPTS '--tiebreak=chunk --cycle --keep-right --scroll-off=999 --hscroll-off=999 --height=~100% --layout=reverse --padding=0 --margin=0 --info=inline-right --no-scrollbar --prompt="󱕅 " --pointer="▶" --marker="󰏢" --ellipsis=… --tabstop=3 --color=hl:#ffd75f:bold,hl+:#ffd75f,bg+:#1a1919,fg+:#d4be98:regular,gutter:#292828,info:#d4be98,prompt:#ffd75f,pointer:#ffd75f,marker:#ffafd7,spinner:#ffd75f --bind=f2:accept-or-print-query,alt-d:clear-screen,alt-q:jump,alt-\;:replace-query'
set -gx EDITOR helix
set -gx VISUAL helix
set -gx MANPAGER cat

zoxide init fish | source
eval (opam env)

if status is-interactive
    for file in ~/prog/dotfiles/fish/abbreviations/*.fish
        source $file
    end
end
