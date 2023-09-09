abbr -a gd     'git diff'
abbr -a giti   'git init'
abbr -a gss    'git status'
abbr -a gs     'git status -s'
abbr -a gsh    'git show'
abbr -a gl     'git log'
abbr -a glo    'git log --oneline'
abbr -a ga     'git add'
abbr -a gap    'git add -p'
abbr -a gm     'git commit'
abbr -a gma    'git commit --amend'
abbr -a gmap   'git commit --amend && git push'
abbr -a gman   'git commit --amend --no-edit'
abbr -a gmanp  'git commit --amend --no-edit && git push'
abbr -a gmp    'git commit && git push'
abbr -a gam    'git add . && git commit -a'
abbr -a gamp   'git add . && git commit -a && git push'
abbr -a gamap  'git add . && git commit -a --amend && git push'
abbr -a gamanp 'git add . && git commit -a --amend --no-edit && git push'
abbr -a gaman  'git add . && git commit -a --amend --no-edit'
abbr -a gp     'git push'
abbr -a gcr    'git add . && git commit -m "first commit" && git push -u origin main'
abbr -a grs    'git reset'
abbr -a grsH   'git reset HEAD'
abbr -a grsh   'git reset --hard'
abbr -a grshH  'git reset --hard HEAD'
abbr -a gst    'git stash'
abbr -a grt    'git restore'
abbr -a grts   'git restore --staged'
abbr -a gch    'git checkout'
abbr -a gb     'git branch'
abbr -a gme    'git merge'
abbr -a gre    'git remote'
abbr -a gcl    'git clean -id'

abbr -a dn   'dotnet'
abbr -a dnn  'dotnet new'
abbr -a dnnl 'dotnet new list'
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

abbr -a ca    'cargo'
abbr -a can   'cargo new'
abbr -a canf  'echo "hard_tabs = true" > rustfmt.toml ; cargo fmt'
abbr -a cai   'cargo init'
abbr -a car   'cargo run'
abbr -a carr  'cargo run -r'
abbr -a carq  'cargo run -q'
abbr -a carrq 'cargo run -rq'
abbr -a cab   'cargo build'
abbr -a cabr  'cargo build -r'
abbr -a cach  'cargo clippy'
abbr -a caf   'cargo fmt'
abbr -a caa   'cargo add'
abbr -a cain  'cargo binstall -y'
abbr -a cate  'cargo test'
abbr -a cap   'cargo publish'
abbr -a cass  'cargo build -r && cp -f ./target/release/(basename $PWD) ~/prog/binaries'

abbr -a ghr     'gh repo'
abbr -a ghrd    'gh repo delete --yes'
abbr -a ghrl    'gh repo list -L 1000'
abbr -a ghrcl   'gh repo clone'
abbr -a ghrf    'gh repo fork'
abbr -a ghrcu   'gh repo create --public'
abbr -a ghrcuM  'gh repo create --public --license MIT'
abbr -a ghrcp   'gh repo create --private'
abbr -a ghrcpM  'gh repo create --private --license MIT'
abbr -a ghrccu  'gh repo create --clone --public'
abbr -a ghrccuM 'gh repo create --clone --public --license MIT'
abbr -a ghrccp  'gh repo create --clone --private'
abbr -a ghrccpM 'gh repo create --clone --private --license MIT'

abbr -a gafsn 'gaf stage new'
abbr -a gafsd 'gaf stage deleted'
abbr -a gafsm 'gaf stage modified'
abbr -a gafua 'gaf unstage added'
abbr -a gafud 'gaf unstage deleted'
abbr -a gafum 'gaf unstage modified'
abbr -a gafur 'gaf unstage renamed'

abbr -a cls 'clear'
abbr -a clx 'clear -x'

abbr -a ff  'ffmpeg'
abbr -a ffi 'ffmpeg -i'

abbr -a rm  'trash-put'
abbr -a rmf 'rm -fr'
abbr -a trr 'trash-restore'

abbr -a ls  'ls -A'
abbr -a lsw 'ls -A -w 1'
abbr -a lg  'ls -gAh'

abbr -a wpcc 'warp-cli connect'
abbr -a wpcd 'warp-cli disconnect'
abbr -a wpcs 'warp-cli status'

abbr -a u 'z -'
abbr -a v 'nvim'
abbr -a vf 'commandline "nvim "(fzf) ; commandline -f execute'
abbr -a fp 'fish -P'
abbr -a x 'exit'
abbr -a bacon 'bacon -j clippy'
abbr -a wec 'watchexec -c clear'
abbr -a ch 'ChoreTracker'
abbr -a xcp 'xclip -r -selection clipboard'
abbr -a jf 'source ~/.config/fish/config.fish'
abbr -a md 'mkdir'
abbr -a to 'touch'
abbr -a gsts 'git stash save'
abbr -a gsta 'git stash apply'
abbr -a gstl 'git stash list'
abbr -a gamn 'git add . && git commit -a --no-edit'
abbr -a ghg 'gh gist'
abbr -a ghgc 'gh gist create'
abbr -a ghal 'gh auth login'
abbr -a fb 'floral_barrel'
abbr -a gamanpf 'git add . && git commit -a --amend --no-edit && git push -f'
abbr -a emoji 'nvim ~/prog/noties/unicode.jsonc'
abbr -a at 'alien_temple'
