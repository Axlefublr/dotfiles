#!/usr/bin/env fish

# This file is meant to be a mirror of my abbreviations
# so that in case they don't work in some non-interactive environment,
# I could still use what I'm used to

#------------------------core------------------------
alias --save trr trash-restore >/dev/null
alias --save mkd 'mkdir -p' >/dev/null
alias --save chx 'chmod +x' >/dev/null
alias --save p jobs >/dev/null
alias --save u pueue >/dev/null

# no abbreviation equivalents because the expansion is too wordy
alias --save copy 'wl-copy -n' >/dev/null
function copyi
    wl-copy -t image/png <$argv[1]
end
funcsave copyi >/dev/null
function copyl
    for filepath in $argv
        echo file://(path resolve $filepath)
    end | wl-copy -t text/uri-list
end
funcsave copyl >/dev/null
alias --save copyn wl-copy >/dev/null
alias --save ypoc 'wl-paste -n' >/dev/null
alias --save s copy >/dev/null
alias --save si copyi >/dev/null
alias --save sl copyl >/dev/null
alias --save sn copyn >/dev/null
alias --save o ypoc >/dev/null

alias --save h 'z ~ && clx' >/dev/null
alias --save X 'kitten @ close-window' >/dev/null

alias --save hime 'history merge' >/dev/null
alias --save jf 'clx && exec fish' >/dev/null

alias --save e helix >/dev/null
alias --save j jj >/dev/null

#----------------------------------------------------silly----------------------------------------------------
alias --save ඞ suspend >/dev/null

#------------------------other------------------------
alias --save gs 'clx ; git status -s' >/dev/null
alias --save ga 'git add' >/dev/null
alias --save gm 'git commit' >/dev/null
alias --save gp 'git push' >/dev/null
alias --save gt 'git tag' >/dev/null
alias --save gd 'git diff' >/dev/null
alias --save grf git-search-file >/dev/null
alias --save grf git-search-file >/dev/null

alias --save py python >/dev/null
alias --save ca cargo >/dev/null

alias --save ff ffmpeg >/dev/null
alias --save ffi 'ffmpeg -i' >/dev/null

alias --save bl bluetoothctl >/dev/null
alias --save tm toggle_media >/dev/null
alias --save sv set_volume >/dev/null
alias --save smv set_mic_volume >/dev/null

alias --save gz glaza >/dev/null
alias --save gx 'glaza --git' >/dev/null
alias --save at alien_temple >/dev/null

alias --save hrtrack httrack >/dev/null
alias --save q qalc >/dev/null
