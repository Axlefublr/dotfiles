#!/usr/bin/env fish

# This file is meant to be a mirror of my abbreviations
# so that in case they don't work in some non-interactive environment,
# I could still use what I'm used to

#------------------------core------------------------
alias --save rm trash-put >/dev/null
alias --save trr trash-restore >/dev/null
alias --save mkd 'mkdir -p' >/dev/null
alias --save real realpath >/dev/null
alias --save chx 'chmod +x' >/dev/null

# no abbreviation equivalents because the expansion is too wordy
alias --save copy 'xclip -r -selection clipboard' >/dev/null
alias --save copyn 'xclip -selection clipboard' >/dev/null
alias --save ypoc 'xclip -selection clipboard -o' >/dev/null

alias --save h 'z ~ && clx' >/dev/null
alias --save u 'z - && clx' >/dev/null
alias --save x 'kitten @ close-window' >/dev/null
alias --save X exit >/dev/null

alias --save hime 'history merge' >/dev/null
alias --save jf 'clx && exec fish' >/dev/null

alias --save p lazygit >/dev/null
alias --save L yazi >/dev/null
alias --save e helix >/dev/null

alias --save ate 'loago list -m eat' >/dev/null

#------------------------other------------------------
alias --save gs 'clx ; git status -s' >/dev/null
alias --save ga 'git add' >/dev/null
alias --save gm 'git commit' >/dev/null
alias --save gp 'git push' >/dev/null
alias --save gt 'git tag' >/dev/null
alias --save gd 'git diff' >/dev/null
alias --save grf git_search_file >/dev/null
alias --save grf git_search_file >/dev/null

alias --save py python >/dev/null
alias --save car 'RUST_LOG=trace cargo run' >/dev/null
alias --save carr 'RUST_LOG=warn cargo run -r' >/dev/null
alias --save cab 'cargo build' >/dev/null
alias --save caf 'cargo +nightly fmt' >/dev/null

alias --save ff ffmpeg >/dev/null
alias --save ffi 'ffmpeg -i' >/dev/null

alias --save bl bluetoothctl >/dev/null
alias --save tm toggle_media >/dev/null
alias --save sv set_volume >/dev/null
alias --save smv set_mic_volume >/dev/null
alias --save xk 'xdotool key' >/dev/null
alias --save xt 'xdotool type' >/dev/null
alias --save ntf notify-send >/dev/null
alias --save awm awesome-client >/dev/null

alias --save gz glaza >/dev/null
alias --save gx 'glaza --git' >/dev/null
alias --save at alien_temple >/dev/null

alias --save ls 'ez -a'
alias --save lg 'ez -al'
alias --save lt 'ez -Ta'

alias --save hrtrack httrack >/dev/nul
alias --save tg 'clx && ni | tgpt' >/dev/null # is an alias only because it's too wordy
