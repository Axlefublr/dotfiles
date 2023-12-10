#!/usr/bin/bash

mkdir -p ~/.config/nvim
ln -sf ~/prog/dotfiles/neovim/init.lua ~/.config/nvim/init.lua
ln -sf ~/prog/dotfiles/neovim ~/.config/nvim/lua
# packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
	~/.local/share/nvim/site/pack/packer/start/packer.nvim

chsh -s /usr/bin/fish
mkdir -p ~/.config/fish
ln -sf ~/prog/dotfiles/fish/config.fish ~/.config/fish/config.fish

mkdir -p ~/.config/kitty
ln -sf ~/prog/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/prog/dotfiles/kitty/theme.conf ~/.config/kitty/current-theme.conf

ranger --copy-config all
ln -sf ~/prog/dotfiles/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sf ~/prog/dotfiles/ranger/rifle.conf ~/.config/ranger/rifle.conf

gh auth login

ln -sf ~/prog/dotfiles/vscode/keybindings.jsonc ~/.config/Code/User/keybindings.json
ln -sf ~/prog/dotfiles/vscode/settings.jsonc ~/.config/Code/User/settings.json
# Needed for the CSS & JS extension
sudo chown -R $(whoami) $(which code)
sudo chown -R $(whoami) /opt/visual-studio-code