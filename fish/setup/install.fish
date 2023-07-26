#!/usr/bin/env fish

command -q git || sudo apt install -y git
git config --global user.email 101342105+Axlefublr@users.noreply.github.com
git config --global user.name Axlefublr
git config --global init.defaultBranch main
git config --global credential.helper store
git config --global push.autoSetupRemote true
git config --global interactive.singleKey true
git config --global pull.ff only

command -q pip || sudo apt install -y pip
command -q pipx || sudo apt install -y pipx
command -q exrex || pipx install exrex
command -q termdown || pipx install termdown

command -q tgpt || curl -sSL https://raw.githubusercontent.com/aandrew-me/tgpt/main/install | bash -s /usr/local/bin

command -q tree || sudo apt install -y tree
command -q fzf || sudo apt install -y fzf
command -q batcat || sudo apt install -y bat
command -q neofetch || sudo apt install -y neofetch
command -q ncdu || sudo apt install -y ncdu
command -q cmatrix || sudo apt install -y cmatrix
command -q lolcat || sudo apt install -y lolcat
command -q cowsay || sudo apt install -y cowsay
sudo apt install -y libssl-dev