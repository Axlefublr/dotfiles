#!/usr/bin/env fish
set -g color_pink FFAFD7
set -g color_purple AF87FF
set -g color_grey 878787
set -g color_yellow FFD75F
set -g color_green 87FF5F
set -g color_cyan 00D7FF
set -g color_red FF005F
set -g color_orange FF8700
set -g color_redder_pink FF8787

set -g color_gruvbox_white D4BE98
set -g color_gruvbox_green A9B665
set -g color_gruvbox_purple D3869B
set -g color_gruvbox_orange E78A4E
set -g color_gruvbox_yellow D8A657
set -g color_gruvbox_red EA6962
set -g color_gruvbox_sea 89B482
set -g color_gruvbox_grey 928374
set -g color_gruvbox_cyan 7DAEA3

set -gx LS_COLORS "$LS_COLORS:ow=1;34:tw=1;34:"
set -gx EDITOR 'nvim'
set -gx VISUAL 'nvim'
set -gx PATH "$HOME/.cargo/bin" "$HOME/.cargo/env" "$HOME/.local/bin" "/mnt/c/Programming/dotfiles/fish" $PATH
set -gx HISTSIZE 10000
set -gx FZF_DEFAULT_OPTS '--layout=default --height=100%'
set -gx SAVEHIST 10000
set -g fish_lazy_load_completions 'true'
set -g fish_lazy_load_functions 'true'

set -g fish_color_normal $color_gruvbox_white
set -g fish_color_command $color_gruvbox_green
set -g fish_color_quote $color_gruvbox_yellow
set -g fish_color_redirection $color_gruvbox_purple
set -g fish_color_end $color_gruvbox_orange
set -g fish_color_error $color_gruvbox_red
set -g fish_color_param $color_gruvbox_sea
set -g fish_color_comment $color_gruvbox_grey
set -g fish_color_match $color_gruvbox_purple
set -g fish_color_operator $color_gruvbox_orange
set -g fish_color_escape $color_gruvbox_grey
set -g fish_color_autosuggestion $color_gruvbox_grey

set -g tide_prompt_add_line_before false
set -g tide_left_prompt_suffix
set -g tide_prompt_min_cols 50
set -g tide_left_prompt_items private_mode pwd context shlvl jobs git status newline character
set -g tide_right_prompt_items

set -g tide_character_color $color_yellow
set -g tide_character_color_failure $color_yellow
set -g tide_character_icon '>>>'
set -g tide_character_vi_icon_default '>>>'
set -g tide_character_vi_icon_replace '>>>'
set -g tide_character_vi_icon_visual '>>>'

set -g tide_cmd_duration_color $color_grey
set -g tide_cmd_duration_decimals 4
set -g tide_cmd_duration_threshold 0

set -g tide_context_color_root $color_red
set -g tide_context_color_ssh $color_orange
set -g tide_git_color_branch $color_purple
set -g tide_git_color_conflicted $color_red
set -g tide_git_color_dirty $color_pink
set -g tide_git_color_staged $color_green
set -g tide_git_color_stash $color_orange
set -g tide_git_color_untracked $color_cyan
set -g tide_git_color_upstream $color_yellow

set -g tide_jobs_color $color_yellow

set -g tide_pwd_color_anchors $color_pink
set -g tide_pwd_color_dirs $color_pink
set -g tide_pwd_color_truncated_dirs $color_redder_pink

set -g tide_shlvl_color $color_yellow
set -g tide_shlvl_threshold 1

set -g tide_status_color $color_red
set -g tide_status_color_failure $color_red

set -g tide_time_color $color_purple
set -g tide_time_format '%H:%M'

set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

abbr -a exp 'explorer.exe'
abbr -a clip 'clip.exe'
abbr -a ch 'ChoreTracker.exe'
abbr -a we 'Welde.exe'
abbr -a ff 'ffmpeg.exe'

abbr -a bat 'batcat'
abbr -a v 'nvim'
abbr -a rm 'rm -fr'
abbr -a tree 'tree -C | less'
abbr -a clock 'termdown -z'
abbr -a xcode 'xargs code-insiders'

abbr -a grep 'grep -E'
abbr -a rgrep 'grep -Ern'
abbr -a agrep 'grep --color=always -E'
abbr -a argrep 'grep --color=always -Ern'

abbr -a ls 'ls -A'
abbr -a lg 'ls -Agh'
abbr -a lsa 'ls --color=always -A'
abbr -a lsg 'ls --color=always -Agh'

abbr -a g       'git'
abbr -a gd      'git diff'
abbr -a gds     'git diff --staged'
abbr -a gs      'git status'
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
abbr -a gmanp   'git commit --amend --no-edit && git push'
abbr -a gmanpf  'git commit --amend --no-edit && git push -f'
abbr -a gmp     'git commit && git push'
abbr -a gmmp    'git commit -m "" && git push'
abbr -a gam     'git add . && git commit -a'
abbr -a gamm    'git add . && git commit -am ""'
abbr -a gamp    'git add . && git commit -a && git push'
abbr -a gampf   'git add . && git commit -a && git push -f'
abbr -a gammp   'git add . && git commit -am "" && git push'
abbr -a gamap   'git add . && git commit -a --amend && git push'
abbr -a gamanp  'git add . && git commit -a --amend --no-edit && git push'
abbr -a gaman   'git add . && git commit -a --amend --no-edit'
abbr -a gamapf  'git add . && git commit -a --amend && git push -f'
abbr -a gamanpf 'git add . && git commit -a --amend --no-edit && git push -f'
abbr -a gp      'git push'
abbr -a gpf     'git push -f'
abbr -a gpu     'git push -u origin main'
abbr -a gcr     'git add . && git commit -m "first commit" && git push -u origin main'
abbr -a grs     'git reset'
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
abbr -a gme     'git merge'
abbr -a gre     'git remote'
abbr -a gui     'git update-index'
abbr -a guiau   'git update-index --assume-unchanged'
abbr -a guinau  'git update-index --no-assume-unchanged'
abbr -a gcl     'git clean -f'
abbr -a gcf     'git config'
abbr -a gpl     'git pull'

abbr -a dn   'dotnet'
abbr -a dnw  'dotnet watch'
abbr -a dncr 'dotnet new gitignore && dotnet sln *.sln add **/*.csproj && git add . && git commit -m "first commit" && git push -u origin main'
abbr -a dnn  'dotnet new'
abbr -a dnnc 'dotnet new console -n'
abbr -a dnns 'dotnet new sln'
abbr -a dnng 'dotnet new gitignore'
abbr -a dns  'dotnet sln *.sln'
abbr -a dnsa 'dotnet sln *.sln add **/*.csproj'
abbr -a dnr  'dotnet run'
abbr -a dnrp 'dotnet run --project'
abbr -a dnb  'dotnet build'
abbr -a dna  'dotnet add'
abbr -a dnf  'dotnet format'

abbr -a ghr   'gh repo'
abbr -a ghrl  'gh repo list -L 1000'
abbr -a ghrcl 'gh repo clone'
abbr -a ghrc  'gh repo create --public'
abbr -a ghrcc 'gh repo create --clone --public'
abbr -a ghrd  'gh repo delete --yes'
abbr -a ghg   'gh gist'
abbr -a ghgl  'gh gist list'
abbr -a ghgc  'gh gist create'
abbr -a ghge  'gh gist edit'

bind -M insert  \cG _get_important_dir
bind -M default \cG _get_important_dir

bind -M insert  \cF _get_important_file
bind -M default \cF _get_important_file

bind -M insert  \cS _get_current_dir
bind -M default \cS _get_current_dir

bind -M insert  \cA _get_current_file
bind -M default \cA _get_current_file

bind -M insert  \cR _history_replace
bind -M default \cR _history_replace

bind -M insert  \cT _history_insert
bind -M default \cT _history_insert

bind -M insert  \cO _copy_command_buffer
bind -M default \cO _copy_command_buffer

bind -M insert  \cD 'exit'
bind -M default \cD 'exit'
bind -M visual  \cD 'exit'

bind -M default V edit_command_buffer
bind -M default : repeat-jump-reverse
bind -M default \" repeat-jump