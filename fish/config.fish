#!/usr/bin/env fish

set -g git_repositories ~/prog/info \
	~/prog/dotfiles \
	~/prog/scripts \
	~/prog/binaries \
	~/prog/music \
	~/prog/job \
	~/prog/shows \
	~/Pictures/Tree \
	~/Pictures/Tools

set -gx LS_COLORS "$LS_COLORS:ow=1;34:tw=1;34:"
set -gx EDITOR 'nvim'
set -gx VISUAL 'nvim'
set -gx BROWSER '/usr/bin/firefox'
set -gx HISTSIZE 10000
set -gx FZF_DEFAULT_OPTS '--layout=default --height=100%'
set -gx SAVEHIST 10000
set -gx DOTNET_CLI_TELEMETRY_OPTOUT true
set -gx RANGER_LOAD_DEFAULT_RC true

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
set -g fish_escape_delay_ms 10

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

abbr -a @dn --position anywhere -- '> /dev/null'
abbr -a @en --position anywhere -- '2> /dev/null'
abbr -a @bn --position anywhere -- '&> /dev/null'

abbr -a bat   'bat'
abbr -a v     'nvim'
abbr -a xcode 'xargs code'
abbr -a fp    'fish -P'
abbr -a fi    'fish'
abbr -a x     'exit'
abbr -a bacon 'bacon -j clippy'
abbr -a wec   'watchexec -c clear'
abbr -a sain  'sudo pacman -Syu --noconfirm'
abbr -a sAin  'sudo pacman -R --noconfirm'
abbr -a spin  'paru -S'
abbr -a sPin  'paru -R'
abbr -a ch    'ChoreTracker'

abbr -a cls 'clear'
abbr -a clx 'clear -x'

abbr -a ff   'ffmpeg'
abbr -a ffi  'ffmpeg -i'

abbr -a rm  'trash-put'
abbr -a rmf 'rm -fr'
abbr -a trr 'trash-restore'

abbr -a ls  'ls -A'
abbr -a lsw 'ls -A -w 1'
abbr -a lg  'ls -Agh'

## git

abbr -a gd      'git diff'
abbr -a gss     'git status'
abbr -a gs      'git status -s'
abbr -a gsh     'git show'
abbr -a gl      'git log'
abbr -a glo     'git log --oneline'
abbr -a ga      'git add'
abbr -a gap     'git add -p'
abbr -a gm      'git commit'
abbr -a gma     'git commit --amend'
abbr -a gmap    'git commit --amend && git push'
abbr -a gman    'git commit --amend --no-edit'
abbr -a gmanp   'git commit --amend --no-edit && git push'
abbr -a gmp     'git commit && git push'
abbr -a gam     'git add . && git commit -a'
abbr -a gamp    'git add . && git commit -a && git push'
abbr -a gamap   'git add . && git commit -a --amend && git push'
abbr -a gamanp  'git add . && git commit -a --amend --no-edit && git push'
abbr -a gaman   'git add . && git commit -a --amend --no-edit'
abbr -a gp      'git push'
abbr -a gcr     'git add . && git commit -m "first commit" && git push -u origin main'
abbr -a grs     'git reset'
abbr -a grsH    'git reset HEAD'
abbr -a grsh    'git reset --hard'
abbr -a grshH   'git reset --hard HEAD'
abbr -a gst     'git stash'
abbr -a grt     'git restore'
abbr -a grts    'git restore --staged'
abbr -a gch     'git checkout'
abbr -a gb      'git branch'
abbr -a gme     'git merge'
abbr -a gre     'git remote'
abbr -a gcl     'git clean -id'

## dotnet

abbr -a dn   'dotnet'
abbr -a dnn  'dotnet new'
abbr -a dnnl 'dotnet new list &| tee /tmp/pagie &| less'
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
abbr -a dnp  'dotnet publish'

## rust

abbr -a ca    'cargo'
abbr -a can   'cargo new'
abbr -a canf  'echo "hard_tabs = true" > rustfmt.toml'
abbr -a cai   'cargo init'
abbr -a car   'cargo run'
abbr -a carr  'cargo run --release'
abbr -a carq  'cargo run -q'
abbr -a carrq 'cargo run --release -q'
abbr -a cab   'cargo build'
abbr -a cabr  'cargo build --release'
abbr -a cach  'cargo clippy'
abbr -a caf   'cargo fmt'
abbr -a caa   'cargo add'
abbr -a cain  'cargo binstall -y'
abbr -a cass  'cp -f ./target/release/(basename $PWD) ~/prog/binaries'

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

bind -M insert \cD 'ranger --choosedir /tmp/dickie ; cd (cat /tmp/dickie) ; commandline -f repaint'
bind -M insert \cR 'ranger ; commandline -f repaint'

bind -M default K execute
bind -M insert \c] execute

bind -M default \; accept-autosuggestion
bind -M insert \e\; accept-autosuggestion

bind -M insert \e\cX 'eval $history[1] | string collect | wl-copy -n'
bind -M default v edit_command_buffer
bind -M default : repeat-jump-reverse
bind -M default '"' repeat-jump
bind -M insert \el list_current_token
