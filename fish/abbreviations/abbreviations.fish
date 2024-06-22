abbr -a g git
abbr -a gd 'git diff'
abbr -a giti 'git init'
abbr -a gss 'clx ; git status'
abbr -a gs 'clx ; git status -s'
abbr -a gsh 'git show'
abbr -a gsho 'git show --oneline'
abbr -a gshos 'git show --oneline -s'
abbr -a gl 'git log'
abbr -a glo 'git log --oneline'
abbr -a ga 'git add'
abbr -a gap 'clx && git add -p'
abbr -a gm 'git commit'
abbr -a gmu 'git commit -a && clx'
abbr -a gmup 'git commit -a && git push && clx'
abbr -a gma 'git commit --amend && clx'
abbr -a gmn 'git commit --no-edit && clx'
abbr -a gman 'git commit --amend --no-edit && clx'
abbr -a grs 'git reset'
abbr -a grsH 'git reset HEAD'
abbr -a grsh 'git reset --hard'
abbr -a grshH 'git reset --hard HEAD'
abbr -a gst 'git stash'
abbr -a gsts 'git stash push -q'
abbr -a gstp 'git stash pop -q'
abbr -a gsta 'git stash apply -q'
abbr -a gstl 'git stash list'
abbr -a gstd 'git stash drop'
abbr -a gstc 'git stash clear'
abbr -a grt 'git restore'
abbr -a grts 'git restore --staged'
abbr -a gch 'git checkout'
abbr -a gchq 'git checkout -q'
abbr -a gb 'git branch'
abbr -a gme 'git merge'
abbr -a gre 'git remote'
abbr -a gcl 'git clean -id'
abbr -a gclf 'git clean -df'
abbr -a gcf 'git config'
abbr -a gcfg 'git config --global'
abbr -a gsw 'git switch'
abbr -a gf 'git fetch'
abbr -a gpu 'git pull'
abbr -a grm 'git rm'
abbr -a gri 'git rebase'
abbr -a gric 'git rebase --continue'
abbr -a grp 'git rev-parse'
abbr -a gui 'git update-index'

abbr -a gmap 'git commit --amend &&
	git push &&
	clx'
abbr -a gmanp 'git commit --amend --no-edit &&
	git push &&
	clx'
abbr -a gmp 'git commit &&
	git push &&
	clx'
abbr -a gam 'git add . &&
	git commit -a &&
	clx'
abbr -a gamn 'git add . &&
	git commit -a --no-edit &&
	clx'
abbr -a gamp 'git add . &&
	git commit -a &&
	git push &&
	clx'
abbr -a gamap 'git add . &&
	git commit -a --amend &&
	git push &&
	clx'
abbr -a gamanp 'git add . &&
	git commit -a --amend --no-edit &&
	git push &&
	clx'
abbr -a gamanpf 'git add . &&
	git commit -a --amend --no-edit &&
	git push -f &&
	clx'
abbr -a gaman 'git add . &&
	git commit -a --amend --no-edit &&
	clx'
abbr -a gcr 'git add . &&
	git commit -m "first commit" &&
	git push -u origin main &&
	clx'

abbr -a dn dotnet
abbr -a dnn 'dotnet new'
abbr -a dnnl 'dotnet new list'
abbr -a dnns 'dotnet new sln'
abbr -a dnng 'dotnet new gitignore'
abbr -a dns 'dotnet sln *.sln'
abbr -a dnsa 'dotnet sln *.sln add **/*.csproj'
abbr -a dnr 'dotnet run --'
abbr -a dnb 'dotnet build'
abbr -a dna 'dotnet add'
abbr -a dnap 'dotnet add package'
abbr -a dnf 'dotnet format'
abbr -a dnp 'dotnet publish'
abbr -a dnt 'dotnet test'

abbr -a can 'cargo new'
abbr -a cai 'cargo init'
abbr -a car 'cargo run --'
abbr -a carr 'cargo run -r --'
abbr -a carq 'cargo run -q --'
abbr -a carrq 'cargo run -rq --'
abbr -a cab 'cargo build'
abbr -a cabr 'cargo build -r'
abbr -a cach 'cargo clippy'
abbr -a caf 'cargo +nightly fmt'
abbr -a caa 'cargo add'
abbr -a cain 'cargo binstall -y'
abbr -a caun 'cargo uninstall'
abbr -a cate 'cargo test'
abbr -a capu 'cargo publish'
abbr -a cad 'cargo doc'
abbr -a cado 'cargo doc --open'
abbr -a caser 'cargo search'

abbr -a ghr 'gh repo'
abbr -a ghrd 'gh repo delete --yes'
abbr -a ghrl 'gh repo list -L 1000'
abbr -a ghrcl 'gh repo clone'
abbr -a ghrf 'gh repo fork'
abbr -a ghrv 'gh repo view'
abbr -a ghre 'gh repo edit'
abbr -a ghrr 'gh repo rename'
abbr -a ghrc 'gh repo create'
abbr -a ghg 'gh gist'
abbr -a ghgc 'gh gist create'
abbr -a ghgl 'gh gist list -L 1000'
abbr -a ghgv 'gh gist view'
abbr -a ghgd 'gh gist delete'
abbr -a ghi 'gh issue'
abbr -a ghicl 'gh issue close'
abbr -a ghil 'gh issue list'
abbr -a ghiv 'gh issue view'
abbr -a ghal 'gh auth login'
abbr -a ghpr 'gh pr'
abbr -a ghprc 'gh pr create'
abbr -a ghrs 'gh release'
abbr -a ghrsc 'gh release create'
abbr -a ghrsl 'gh release list -L 1000'
abbr -a ghrsv 'gh release view'

abbr -a ff ffmpeg
abbr -a ffi 'ffmpeg -i'

abbr -a rm trash-put
abbr -a rmf 'rm -fr'
abbr -a trr trash-restore

abbr -a st 'kitten @set-window-title'
abbr -a stb 'kitten @set-window-title ""'

abbr -a sl systemctl
abbr -a ssl 'sudo systemctl'
abbr -a slu 'systemctl --user'
abbr -a slur 'systemctl --user daemon-reload'
abbr -a slus 'systemctl --user status'
abbr -a slup 'systemctl --user stop'

abbr -a v nvim

abbr -a ~ 'z ~ && clx'
abbr -a rl realpath
abbr -a u 'z - && clx'
abbr -a fp 'fish -P'
abbr -a x exit
abbr -a bacon 'bacon -j clippy'
abbr -a lo loago
abbr -a xcp 'xclip -r -selection clipboard'
abbr -a xcpi 'xclip -selection clipboard -t image/png'
abbr -a xpc 'xclip -selection clipboard -o'
abbr -a jf 'clx && exec fish'
abbr -a mkd 'mkdir -p'
abbr -a to touch
abbr -a gz glaza
abbr -a gx 'glaza -g'
abbr -a at alien_temple
abbr -a unimatrix 'unimatrix -s 95 -abf'
abbr -a cl clorange
abbr -a hime 'history merge'
abbr -a dsf diff-so-fancy
abbr -a uv 'sudo -E nvim'
abbr -a suv 'sudo -v'
abbr -a ate 'loago list -m eat'
abbr -a parun 'paru --noconfirm -S'
abbr -a ka killall
abbr -a notif notify-send
abbr -a pav pavucontrol
abbr -a mullvad mullvad-vpn
abbr -a ssls 'sudo systemctl status'
abbr -a bl bluetoothctl
abbr -a sv set_volume
abbr -a smv set_mic_volume
abbr -a pik pikaur
abbr -a real realpath
abbr -a blch 'bluetoothctl connect $head'
abbr -a bldh 'bluetoothctl disconnect $head'
abbr -a blce 'bluetoothctl connect $ear'
abbr -a blde 'bluetoothctl disconnect $ear'
abbr -a cls clear
abbr -a clx clx
abbr -a h 'z ~ && clx'
abbr -a ls 'ez --git-ignore'
abbr -a la 'ez -a'
abbr -a lg 'ez -l --git-ignore'
abbr -a li 'ez -al'
abbr -a lt 'ez -T --git-ignore'
abbr -a lr 'ez -aT'
abbr -a read 'read -p rdp'
abbr -a tg 'clx && ni | tgpt'
abbr -a br (path basename $BROWSER)
abbr -a brd (path basename $BROWSER)' ~/docs'
abbr -a py python
abbr -a pyt runner_python
abbr -a gr git_search
abbr -a grf git_search_file
abbr -a gq 'oil'
abbr -a gt 'git tag'
abbr -a cacl 'cargo clean'
abbr -a xk 'xdotool key'
abbr -a tm 'toggle_media'
abbr -a ntf 'notify-send'