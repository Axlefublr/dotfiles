abbr -a g     'git'
abbr -a gd    'git diff'
abbr -a giti  'git init'
abbr -a gss   'clear -x ; git status'
abbr -a gs    'clear -x ; git status -s'
abbr -a gsh   'git show'
abbr -a gsho  'git show --oneline'
abbr -a gshos 'git show --oneline -s'
abbr -a gl    'git log'
abbr -a glo   'git log --oneline'
abbr -a ga    'git add'
abbr -a gap   'clear -x && git add -p'
abbr -a gm    'git commit'
abbr -a gmu   'git commit -a && clear -x'
abbr -a gma   'git commit --amend && clear -x'
abbr -a gmn   'git commit --no-edit && clear -x'
abbr -a gman  'git commit --amend --no-edit && clear -x'
abbr -a grs   'git reset'
abbr -a grsH  'git reset HEAD'
abbr -a grsh  'git reset --hard'
abbr -a grshH 'git reset --hard HEAD'
abbr -a gst   'git stash'
abbr -a gsts  'git stash push -q'
abbr -a gstp  'git stash pop -q'
abbr -a gsta  'git stash apply -q'
abbr -a gstl  'git stash list'
abbr -a gstd  'git stash drop'
abbr -a gstc  'git stash clear'
abbr -a grt   'git restore'
abbr -a grts  'git restore --staged'
abbr -a gch   'git checkout'
abbr -a gchq  'git checkout -q'
abbr -a gb    'git branch'
abbr -a gme   'git merge'
abbr -a gre   'git remote'
abbr -a gcl   'git clean -id'
abbr -a gclf  'git clean -df'
abbr -a gcf   'git config'
abbr -a gcfg  'git config --global'
abbr -a gsw   'git switch'
abbr -a gf    'git fetch'
abbr -a gpu   'git pull'
abbr -a grm   'git rm'
abbr -a gri   'git rebase'
abbr -a grp   'git rev-parse'
abbr -a gui   'git update-index'

abbr -a gmap 'git commit --amend &&
	git push &&
	clear -x'
abbr -a gmanp 'git commit --amend --no-edit &&
	git push &&
	clear -x'
abbr -a gmp 'git commit &&
	git push &&
	clear -x'
abbr -a gam 'git add . &&
	git commit -a &&
	clear -x'
abbr -a gamn 'git add . &&
	git commit -a --no-edit &&
	clear -x'
abbr -a gamp 'git add . &&
	git commit -a &&
	git push &&
	clear -x'
abbr -a gamap 'git add . &&
	git commit -a --amend &&
	git push &&
	clear -x'
abbr -a gamanp 'git add . &&
	git commit -a --amend --no-edit &&
	git push &&
	clear -x'
abbr -a gamanpf 'git add . &&
	git commit -a --amend --no-edit &&
	git push -f &&
	clear -x'
abbr -a gaman 'git add . &&
	git commit -a --amend --no-edit &&
	clear -x'
abbr -a gcr 'git add . &&
	git commit -m "first commit" &&
	git push -u origin main &&
	clear -x'

abbr -a dn   'dotnet'
abbr -a dnn  'dotnet new'
abbr -a dnnl 'dotnet new list'
abbr -a dnns 'dotnet new sln'
abbr -a dnng 'dotnet new gitignore'
abbr -a dns  'dotnet sln *.sln'
abbr -a dnsa 'dotnet sln *.sln add **/*.csproj'
abbr -a dnr  'dotnet run --'
abbr -a dnb  'dotnet build'
abbr -a dna  'dotnet add'
abbr -a dnap 'dotnet add package'
abbr -a dnf  'dotnet format'
abbr -a dnp  'dotnet publish'
abbr -a dnt  'dotnet test'

abbr -a can   'cargo new'
abbr -a cai   'cargo init'
abbr -a car   'cargo run --'
abbr -a carr  'cargo run -r --'
abbr -a carq  'cargo run -q --'
abbr -a carrq 'cargo run -rq --'
abbr -a cab   'cargo build'
abbr -a cabr  'cargo build -r'
abbr -a cach  'cargo clippy'
abbr -a caf   'cargo +nightly fmt'
abbr -a caa   'cargo add'
abbr -a cain  'cargo binstall -y'
abbr -a caun  'cargo uninstall'
abbr -a cate  'cargo test'
abbr -a capu  'cargo publish'
abbr -a cad   'cargo doc'
abbr -a cado  'cargo doc --open'
abbr -a caser 'cargo search'

abbr -a ghr     'gh repo'
abbr -a ghrd    'gh repo delete --yes'
abbr -a ghrl    'gh repo list -L 1000'
abbr -a ghrcl   'gh repo clone'
abbr -a ghrf    'gh repo fork'
abbr -a ghrv    'gh repo view'
abbr -a ghre    'gh repo edit'
abbr -a ghrev   'gh repo edit --visibility'
abbr -a ghrr    'gh repo rename'
abbr -a ghrcu   'gh repo create --public'
abbr -a ghrcuM  'gh repo create --public --license MIT'
abbr -a ghrcp   'gh repo create --private'
abbr -a ghrcpM  'gh repo create --private --license MIT'
abbr -a ghrccu  'gh repo create --clone --public'
abbr -a ghrccuM 'gh repo create --clone --public --license MIT'
abbr -a ghrccp  'gh repo create --clone --private'
abbr -a ghrccpM 'gh repo create --clone --private --license MIT'
abbr -a ghg     'gh gist'
abbr -a ghgc    'gh gist create'
abbr -a ghgl    'gh gist list -L 1000'
abbr -a ghgv    'gh gist view'
abbr -a ghgd    'gh gist delete'
abbr -a ghi     'gh issue'
abbr -a ghicl   'gh issue close'
abbr -a ghil    'gh issue list'
abbr -a ghiv    'gh issue view'
abbr -a ghal    'gh auth login'
abbr -a ghpr    'gh pr'
abbr -a ghprc   'gh pr create'
abbr -a ghrel   'gh release'
abbr -a ghrell  'gh release list -L 1000'
abbr -a ghrelv  'gh release view'

abbr -a ff  'ffmpeg'
abbr -a ffi 'ffmpeg -i'

abbr -a rm  'trash-put'
abbr -a rmf 'rm -fr'
abbr -a trr 'trash-restore'

abbr -a st  'kitten @set-window-title'
abbr -a stb 'kitten @set-window-title ""'

abbr -a sl   'systemctl'
abbr -a ssl  'sudo systemctl'
abbr -a slu  'systemctl --user'
abbr -a slur 'systemctl --user daemon-reload'
abbr -a slus 'systemctl --user status'
abbr -a slup 'systemctl --user stop'

abbr -a v 'nvim'
abbr -a f 'neovide'

abbr -a ~ 'z ~ && clear -x'
abbr -a rl 'realpath'
abbr -a u 'z - && clear -x'
abbr -a c 'code'
abbr -a fp 'fish -P'
abbr -a x 'exit'
abbr -a bacon 'bacon -j clippy'
abbr -a lo 'loago'
abbr -a xcp 'xclip -r -selection clipboard'
abbr -a xcpi 'xclip -selection clipboard -t image/png'
abbr -a xpc 'xclip -selection clipboard -o'
abbr -a jf 'clear -x && exec fish'
abbr -a mkd 'mkdir -p'
abbr -a to 'touch'
abbr -a gz 'glaza'
abbr -a gx 'glaza --git'
abbr -a at 'alien_temple'
abbr -a unimatrix 'unimatrix -s 95 -abf'
abbr -a cl 'clorange'
abbr -a hime 'history merge'
abbr -a dsf 'diff-so-fancy'
abbr -a psql 'psql -U postgres'
abbr -a uv 'sudo -E nvim'
abbr -a suv 'sudo -v'
abbr -a ate 'loago list -m eat'
abbr -a parun 'paru --noconfirm -S'
abbr -a ka 'killall'
abbr -a notif 'notify-send'
abbr -a pav 'pavucontrol'
abbr -a mullvad 'mullvad-vpn'
abbr -a ssls 'sudo systemctl status'
abbr -a bl 'bluetoothctl'
abbr -a sv 'set_volume'
abbr -a smv 'set_mic_volume'
abbr -a pik 'pikaur'
abbr -a real 'realpath'
abbr -a blch 'bluetoothctl connect $head'
abbr -a bldh 'bluetoothctl disconnect $head'
abbr -a blce 'bluetoothctl connect $ear'
abbr -a blde 'bluetoothctl disconnect $ear'
abbr -a cls 'clear'
abbr -a clx 'clear -x'
abbr -a ` 'z ~ && clear -x'
abbr -a l 'ez --git-ignore'
abbr -a li 'ez -a --git-ignore'
abbr -a lis 'ez -a'
abbr -a lg 'ez -l --git-ignore'
abbr -a lgi 'ez -al --git-ignore'
abbr -a lgis 'ez -al'
abbr -a lt 'ez -T --git-ignore'
abbr -a lti 'ez -aT --git-ignore'
abbr -a ltis 'ez -aT'
abbr -a ls 'echo just use l'
