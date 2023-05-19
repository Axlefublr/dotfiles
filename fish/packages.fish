#!usr/bin/fish
command -q git || sudo apt install git
git config --global user.email 101342105+Axlefublr@users.noreply.github.com
git config --global user.name Axlefublr
git config --global init.defaultBranch main
git config --global credential.helper store
git config --global credential.helper '/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe'

command -q pip || sudo apt install pip
command -q termdown || sudo apt install termdown
command -q fzf || sudo apt install fzf