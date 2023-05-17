# fish_vi_key_bindings

set -g color_pink FFAFD7
set -g color_purple AF87FF
set -g color_grey 878787
set -g color_yellow FFD75F
set -g color_green 87FF5F
set -g color_cyan 00D7FF
set -g color_red FF005F
set -g color_orange FF8700
set -g color_redder_pink FF8787

set -g fish_lazy_load_completions 'true'
set -g fish_lazy_load_functions 'true'

set -g tide_left_prompt_items pwd context shlvl jobs git status cmd_duration newline time character
set -g tide_right_prompt_items

set -g tide_character_color $color_pink
set -g tide_character_color_failure $color_pink
set -g tide_character_icon '>>>'
set -g tide_character_vi_icon_default '$$$'
set -g tide_character_vi_icon_replace '$$$'
set -g tide_character_vi_icon_visual 'OOO'

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
set -g tide_shlvl_threshold 2

set -g tide_status_color_failure $color_red

set -g tide_time_color $color_purple
set -g tide_time_format '%H:%M'

set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual block

set -g fish_prompt_vim_symbol

abbr -a exp explorer.exe
abbr -a clip clip.exe
abbr -a ch ChoreTracker.exe
abbr -a we Welde.exe

abbr -a bat batcat
abbr -a v nvim
abbr -a rm rm -fr
abbr -a ff ffmpeg.exe
abbr -a tree tree -C | less
abbr -a clock termdown -z

abbr -a grep grep -E
abbr -a rgrep grep -Ern
abbr -a agrep grep --color=always -E
abbr -a argrep grep --color=always -Ern

abbr -a ls ls -A
abbr -a lg ls -Ag
abbr -a lsa ls --color=always -A
abbr -a lsg ls --color=always -Ag

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
abbr -a gr      'git reset'
abbr -a grs     'git reset --soft'
abbr -a grh     'git reset --hard'
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
abbr -a grs     'git restore'
abbr -a grss    'git restore --staged'
abbr -a grsH    'git restore --source=HEAD --'
abbr -a gch     'git checkout'
abbr -a gchm    'git checkout main'
abbr -a gb      'git branch'
abbr -a gme     'git merge'
abbr -a gre     'git remote'