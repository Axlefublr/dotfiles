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

abbr -a exp 'explorer.exe'
abbr -a clip 'clip.exe'
abbr -a ch 'ChoreTracker.exe'
abbr -a we 'Welde.exe'

abbr -a bat 'batcat'
abbr -a v 'nvim'
abbr -a rm 'rm -fr'
abbr -a ff 'ffmpeg.exe'
abbr -a tree 'tree -C | less'
abbr -a clock 'termdown -z'

abbr -a grep 'grep -E'
abbr -a rgrep 'grep -Ern'
abbr -a agrep 'grep --color=always -E'
abbr -a argrep 'grep --color=always -Ern'

abbr -a ls 'ls -A'
abbr -a lg 'ls -Ag'
abbr -a lsa 'ls --color=always -A'
abbr -a lsg 'ls --color=always -Ag'

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

function dlist
	for arg in $argv
		find $arg \( -name .git -o -name .npm -o -name .vscode -o -name obj \) -prune -o -type d -print
	end
end

function flist
	for arg in $argv
		find $arg \( -name .git -o -name .npm -o -name .vscode -o -name obj \) -prune -o -type f -print
	end
end

function dpick
	dlist $argv | fzf -m --cycle | sed 's/^/\'/; s/$/\'/'
end

function fpick
	flist $argv | fzf -m --cycle | sed 's/^/\'/; s/$/\'/'
end

function smush
	tr '\n' ' ' | sed 's/[[:space:]]*$//'
end

function cut
	ffmpeg.exe -i $argv[1] -ss $argv[3] -to $argv[4] -c:a copy $argv[2]
end

function compress
	ffmpeg.exe -i $argv[1] -c:v libx264 -crf 28 -preset veryslow -c:a aac -b:a 64k -movflags +faststart $argv[2]
end

function combine
	ffmpeg.exe -i $argv[1] -c copy -bsf:v h264_mp4toannexb -f mpegts input1.ts
	ffmpeg.exe -i $argv[2] -c copy -bsf:v h264_mp4toannexb -f mpegts input2.ts
	echo "file 'input1.ts'
	file 'input2.ts'" > inputs.txt
	ffmpeg.exe -f concat -safe 0 -i inputs.txt -c copy $argv[3]
	rm inputs.txt input1.ts input2.ts
end

function cutout
	ffmpeg.exe -i $argv[1] -to $argv[3] -c:a copy input1.mp4
	ffmpeg.exe -i $argv[1] -ss $argv[4] -c:a copy input2.mp4
	combine input1.mp4 input2.mp4 $argv[2]
	rm input1.mp4 input2.mp4
end

function timer
	termdown $argv && Ting.exe
end

function gpa
	set -l prevDir (pwd)
	cd /mnt/c/Programming/dotfiles
	git push
	cd ../info
	git push
	cd ../main
	git push
	cd ../music
	git push
   cd ../fish
   git push
	cd /mnt/c/Users/axlefublr/Documents/Autohotkey/Lib
	git push
	cd /mnt/c/Pictures/Tree
	git push
	cd ../Tools
	git push
	cd $prevDir
end

function _get_important_dir
	commandline -i (dpick /mnt/c/Programming /mnt/c/Users/axlefublr/Documents/AutoHotkey/Lib /mnt/c/Pictures /mnt/c/Audio | smush)
end
bind -M insert \cD _get_important_dir

function _get_important_file
	commandline -i (fpick /mnt/c/Programming /mnt/c/Users/axlefublr/Documents/AutoHotkey/Lib /mnt/c/Pictures /mnt/c/Audio | smush)
end
bind -M insert \cF _get_important_file

function _get_current_dir
	commandline -i (dpick . | smush)
end
bind -M insert \cS _get_current_dir

function _get_current_file
	commandline -i (fpick . | smush)
end
bind -M insert \cA _get_current_file

# _history_replace() {
# 	BUFFER="$(history | tac | awk '{print substr($0, index($0, $argv[4]))}' | sed -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf --tiebreak=index --query=$BUFFER)"
# 	zle end-of-line
# }

# _history_right() {
# 	BUFFER="$LBUFFER$(history | tac | awk '{print substr($0, index($0, $argv[4]))}' | sed -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf --tiebreak=index --query=$RBUFFER)"
# 	zle end-of-line
# }

# _paste_clipboard() {
# 	BUFFER="$LBUFFER$(win32yank.exe -o)$RBUFFER"
# 	zle end-of-line
# }
