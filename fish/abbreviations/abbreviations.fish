#-------------------------core-------------------------
abbr -a rm trash-put
abbr -a trr trash-restore
abbr -a mkd 'mkdir -p'
abbr -a real realpath
abbr -a chx 'chmod +x'

abbr -a h 'z ~ && clx'
abbr -a u 'z - && clx'

abbr -a hime 'history merge'
abbr -a jf 'clx && exec fish'

abbr -a p lazygit
abbr -a L yazi
abbr -a e helix

#------------------------other------------------------
abbr -a gs 'clx ; git status -s'
abbr -a ga 'git add'
abbr -a gm 'git commit'
abbr -a gp 'git push'
abbr -a gt 'git tag'
abbr -a gd 'git diff'
abbr -a grf git_search_file
abbr -a grf git_search_file

abbr -a py python
abbr -a car 'RUST_LOG=trace cargo run'
abbr -a carr 'RUST_LOG=warn cargo run -r'
abbr -a cab 'cargo build'
abbr -a caf 'cargo +nightly fmt'

abbr -a ff ffmpeg
abbr -a ffi 'ffmpeg -i'

abbr -a bl bluetoothctl
abbr -a tm toggle_media
abbr -a sv set_volume
abbr -a smv set_mic_volume
abbr -a xk 'xdotool key'
abbr -a xt 'xdotool type'
abbr -a awm awesome-client
abbr -a ntf notify-send

abbr -a gz glaza
abbr -a gx 'glaza -g'
abbr -a at alien_temple

abbr -a ls 'ez -a'
abbr -a lg 'ez -al'
abbr -a lt 'ez -Ta'

abbr -a read 'read -p rdp' # can only be an abbreviation because `read` is a builtin
abbr -a ttyper 'ttyper -l uclanr -w 25' # should be an alias
