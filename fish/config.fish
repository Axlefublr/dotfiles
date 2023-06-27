#!/usr/bin/env fish

set -gx LS_COLORS "$LS_COLORS:ow=1;34:tw=1;34:"
set -gx EDITOR 'nvim'
set -gx VISUAL 'nvim'
set -gx PATH "$HOME/.cargo/bin" "$HOME/.cargo/env" "$HOME/.local/bin" "/mnt/c/Programming/dotfiles/fish" "/mnt/c/Programming/dotfiles/fish/fun" "/mnt/c/Programming/dotfiles/fish/setup" $PATH
set -gx BROWSER 'browser.exe'
set -gx HISTSIZE 10000
set -gx FZF_DEFAULT_OPTS '--layout=default --height=100%'
set -gx SAVEHIST 10000
set -g fish_escape_delay_ms 10

set -l prog /mnt/c/Programming
set -l pic /mnt/c/Pictures
set -l lib /mnt/c/Users/axlefublr/Documents/AutoHotkey/Lib
set -l audio /mnt/c/Audio

set -g important_directories $prog \
	$lib \
	$pic \
	$audio/ \
	~/.config/fish \
	$prog/rust \
	$prog/csproj \

set -g git_directories $prog/dotfiles \
	$prog/info \
	$prog/main \
	$prog/music \
	$prog/binaries \
	$lib \
	$pic/Tree \
	$pic/Tools

set -g color_pink        FFAFD7
set -g color_purple      AF87FF
set -g color_grey        878787
set -g color_yellow      FFD75F
set -g color_green       87FF5F
set -g color_cyan        00D7FF
set -g color_red         FF005F
set -g color_orange      FF8700
set -g color_redder_pink FF8787
set -g color_white       D4BE98

set -g color_gruvbox_white  D4BE98
set -g color_gruvbox_green  A9B665
set -g color_gruvbox_purple D3869B
set -g color_gruvbox_orange E78A4E
set -g color_gruvbox_yellow D8A657
set -g color_gruvbox_red    EA6962
set -g color_gruvbox_sea    89B482
set -g color_gruvbox_grey   928374
set -g color_gruvbox_cyan   7DAEA3

set -g fish_lazy_load_completions 'true'
set -g fish_lazy_load_functions 'true'

set -g fish_color_normal $color_gruvbox_white
set -g fish_color_command $color_gruvbox_green
set -g fish_color_quote $color_gruvbox_yellow
set -g fish_color_redirection $color_gruvbox_orange
set -g fish_color_end $color_gruvbox_orange
set -g fish_color_error $color_gruvbox_red
set -g fish_color_param $color_gruvbox_sea
set -g fish_color_comment $color_gruvbox_grey
set -g fish_color_match $color_gruvbox_purple
set -g fish_color_operator $color_gruvbox_purple
set -g fish_color_escape $color_gruvbox_grey
set -g fish_color_autosuggestion $color_gruvbox_grey

set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

## abbreviations

abbr -a @hl  --position anywhere -- '--help &| tee /tmp/pagie &| less'
abbr -a @h   --position anywhere -- '--help'
abbr -a @l   --position anywhere -- '&| tee /tmp/pagie &| less'
abbr -a @ca  --position anywhere -- '--color=always'
abbr -a @dn  --position anywhere -- '> /dev/null'
abbr -a @en  --position anywhere -- '2> /dev/null'
abbr -a @bn  --position anywhere -- '&> /dev/null'
abbr -a @c   --position anywhere -- '| clip.exe'
abbr -a @tt  --position anywhere -- '| tee /dev/tty |'
abbr -a @ttc --position anywhere -- '| tee /dev/tty | clip.exe'
abbr -a @x   --position anywhere -- '&& exit'

abbr -a exp  'explorer.exe'
abbr -a clip 'clip.exe'
abbr -a ch   'ChoreTracker.exe'
abbr -a we   'Welde.exe'
abbr -a ff   'ffmpeg.exe'
abbr -a ffi  'ffmpeg.exe -i'

abbr -a bat   'batcat'
abbr -a v     'nvim'
abbr -a rmf   'rm -fr'
abbr -a clock 'termdown -z'
abbr -a xcode 'xargs code-insiders'
abbr -a mvf   'mv -f'
abbr -a pri   'echo $fish_private_mode'

abbr -a fp 'fish -P'
abbr -a fi 'fish'
abbr -a x  'exit'

abbr -a rm  'trash-put'
abbr -a rma 'trash-put *'
abbr -a trr 'trash-restore'

abbr -a grep  'grep -E'
abbr -a rgrep 'grep -Ern'
abbr -a lgrep 'grep -Erl'

abbr -a ls 'ls -A'
abbr -a lsw 'ls -A -w 1'
abbr -a lg 'ls -Agh'
abbr -a lr 'ls --color=always -R &| tee /tmp/pagie &| less'
abbr -a lar 'ls --color=always -AR &| tee /tmp/pagie &| less'

## git

abbr -a g       'git'
abbr -a gd      'git diff'
abbr -a gds     'git diff --staged'
abbr -a gss     'git status'
abbr -a gs      'git status -s'
abbr -a gsh     'git show'
abbr -a gl      'git log'
abbr -a glp     'git log -p'
abbr -a glo     'git log --oneline'
abbr -a ga      'git add'
abbr -a gap     'git add -p'
abbr -a gaa     'git add .'
abbr -a gm      'git commit'
abbr -a gmm     'git commit -m ""'
abbr -a gma     'git commit --amend'
abbr -a gmapf   'git commit --amend && git push -f'
abbr -a gman    'git commit --amend --no-edit'
abbr -a gmanp   'git commit --amend --no-edit && git push 2> /dev/null'
abbr -a gmanpf  'git commit --amend --no-edit && git push -f'
abbr -a gmp     'git commit && git push 2> /dev/null'
abbr -a gmmp    'git commit -m "" && git push 2> /dev/null'
abbr -a gam     'git add . && git commit -a'
abbr -a gamm    'git add . && git commit -am ""'
abbr -a gamp    'git add . && git commit -a && git push 2> /dev/null'
abbr -a gampf   'git add . && git commit -a && git push -f'
abbr -a gammp   'git add . && git commit -am "" && git push 2> /dev/null'
abbr -a gamap   'git add . && git commit -a --amend && git push 2> /dev/null'
abbr -a gamanp  'git add . && git commit -a --amend --no-edit && git push 2> /dev/null'
abbr -a gaman   'git add . && git commit -a --amend --no-edit'
abbr -a gamapf  'git add . && git commit -a --amend && git push -f'
abbr -a gamanpf 'git add . && git commit -a --amend --no-edit && git push -f'
abbr -a gpp     'git push'
abbr -a gp      'git push 2> /dev/null'
abbr -a gpf     'git push -f'
abbr -a gpu     'git push -u origin main'
abbr -a gcr     'git add . && git commit -m "first commit" && git push -u origin main'
abbr -a grs     'git reset'
abbr -a grsH    'git reset HEAD'
abbr -a grss    'git reset --soft'
abbr -a grssH   'git reset --soft HEAD'
abbr -a grssom  'git reset --soft origin/main'
abbr -a grsh    'git reset --hard'
abbr -a grshH   'git reset --hard HEAD'
abbr -a grshom  'git reset --hard origin/main'
abbr -a gst     'git stash'
abbr -a gstp    'git stash push'
abbr -a gsts    'git stash show'
abbr -a gsta    'git stash apply'
abbr -a gsto    'git stash pop'
abbr -a gstd    'git stash drop'
abbr -a gstl    'git stash list'
abbr -a gstc    'git stash clear'
abbr -a grb     'git rebase'
abbr -a grm     'git remote'
abbr -a grt     'git restore'
abbr -a grts    'git restore --staged'
abbr -a grtH    'git restore --source=HEAD --'
abbr -a gch     'git checkout'
abbr -a gchm    'git checkout main'
abbr -a gb      'git branch'
abbr -a gbd     'git branch --delete'
abbr -a gme     'git merge'
abbr -a gre     'git remote'
abbr -a greao   'git remote add origin'
abbr -a greg    'git remote get-url'
abbr -a grego   'git remote get-url origin'
abbr -a gui     'git update-index'
abbr -a guiau   'git update-index --assume-unchanged'
abbr -a guinau  'git update-index --no-assume-unchanged'
abbr -a gcl     'git clean -id'
abbr -a gcf     'git config'
abbr -a gpl     'git pull'
abbr -a grp     'git rev-parse'
abbr -a grpsH   'git rev-parse --short HEAD'
abbr -a grpH    'git rev-parse HEAD'

## dotnet

abbr -a dn   'dotnet'
abbr -a dnw  'dotnet watch'
abbr -a dnn  'dotnet new'
abbr -a dnnl 'dotnet new list &| tee /tmp/pagie &| less'
abbr -a dnnc 'dotnet new console -n'
abbr -a dnns 'dotnet new sln'
abbr -a dnng 'dotnet new gitignore'
abbr -a dns  'dotnet sln *.sln'
abbr -a dnsa 'dotnet sln *.sln add **/*.csproj'
abbr -a dnr  'dotnet run'
abbr -a dnrp 'dotnet run --project'
abbr -a dnb  'dotnet build'
abbr -a dna  'dotnet add'
abbr -a dnap 'dotnet add package'
abbr -a dnf  'dotnet format'

## rust

abbr -a ca    'cargo'
abbr -a can   'cargo new'
abbr -a canf  'echo "hard_tabs = true" > rustfmt.toml'
abbr -a canl  'cargo new --lib'
abbr -a cari  'cargo init'
abbr -a car   'cargo run'
abbr -a carr  'cargo run -r'
abbr -a carq  'cargo run -q'
abbr -a carrq 'cargo run -rq'
abbr -a cab   'cargo build'
abbr -a cabr  'cargo build --release'
abbr -a cad   'cargo doc'
abbr -a cacl  'cargo clean'
abbr -a cach  'cargo check'
abbr -a cau   'cargo update'
abbr -a caf   'cargo fmt'
abbr -a cafi  'cargo fix'
abbr -a cai   'cargo init'
abbr -a caa   'cargo add'

abbr -a ru   'rustup'
abbr -a rud  'rustup docs'
abbr -a ruds 'rustup docs --std'
abbr -a rudb 'rustup docs --book'

abbr -a ghr     'gh repo'
abbr -a ghrl    'gh repo list -L 1000'
abbr -a ghrcl   'gh repo clone'
abbr -a ghrcu   'gh repo create --public'
abbr -a ghrcuM  'gh repo create --public --license MIT'
abbr -a ghrcp   'gh repo create --private'
abbr -a ghrcpM  'gh repo create --private --license MIT'
abbr -a ghrccu  'gh repo create --clone --public'
abbr -a ghrccuM 'gh repo create --clone --public --license MIT'
abbr -a ghrccp  'gh repo create --clone --private'
abbr -a ghrccpM 'gh repo create --clone --private --license MIT'
abbr -a ghrd    'gh repo delete --yes'
abbr -a ghg     'gh gist'
abbr -a ghgl    'gh gist list'
abbr -a ghgc    'gh gist create'
abbr -a ghge    'gh gist edit'

bind -M insert \cD paste_important_path
bind -M insert \cF paste_parent_path
bind -M insert \cS paste_relative_path
bind -M insert \cQ 'commandline -i (cat /tmp/pickie)'

bind -M insert  \cR hist_insert
bind -M default R   hist_replace

bind -M insert  \cO "exec fish -C 'clear -x'"
bind -M default \cO "exec fish -C 'clear -x'"

bind -M insert  \cE 'less /tmp/pagie'
bind -M default \cE 'less /tmp/pagie'

bind -M default \; accept-autosuggestion
bind -M default K execute
bind -M default -m insert "'" accept-autosuggestion execute
bind -M default v edit_command_buffer
bind -M default : repeat-jump-reverse
bind -M default '"' repeat-jump