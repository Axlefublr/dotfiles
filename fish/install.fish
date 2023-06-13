#!/usr/bin/env fish

command -q git || sudo apt install git
git config --global user.email 101342105+Axlefublr@users.noreply.github.com
git config --global user.name Axlefublr
git config --global init.defaultBranch main
git config --global credential.helper store
git config --global credential.helper '/mnt/c/Program\ Files/Git/mingw64/libexec/git-core/git-credential-wincred.exe'

command -q pip || sudo apt install pip
command -q exrex || pip install exrex
command -q termdown || pip install termdown

command -q tree || sudo apt install tree
command -q fzf || sudo apt install fzf
command -q batcat || sudo apt install bat
command -q neofetch || sudo apt install neofetch
command -q ncdu || sudo apt install ncdu
command -q cmatrix || sudo apt install cmatrix
command -q lolcat || sudo apt install lolcat
command -q cowsay || sudo apt install cowsay

mkdir -p ~/.config/nvim
ln -s /mnt/c/Programming/dotfiles/init.lua ~/.config/nvim/init.lua

command -q fisher || curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

command -q tide || fisher install IlanCosman/tide@v5

set -l target /mnt/c/Programming/tide-functions
set -l symlink ~/.config/fish/functions
cd $symlink
mv -f *_tide* $target
cd $target
for file in (ls *)
    set -l source_path (realpath $file)
    set -l dest_path "$symlink/$file"
    ln -s $source_path $dest_path
end
ln -sf $target/fish_prompt.fish $symlink/fish_prompt.fish

command -q tgpt || curl -sSL https://raw.githubusercontent.com/aandrew-me/tgpt/main/install | bash -s /usr/local/bin

command -q cargo || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
