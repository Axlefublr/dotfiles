#!/usr/bin/bash

# Neovim
mkdir -p ~/.config/nvim
ln -sf ~/prog/dotfiles/neovim/init.lua ~/.config/nvim/init.lua
ln -sf ~/prog/dotfiles/neovim ~/.config/nvim/lua
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
	~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Fish shell
chsh -s /usr/bin/fish
mkdir -p ~/.config/fish
ln -sf ~/prog/dotfiles/fish/config.fish ~/.config/fish/config.fish

# Kitty terminal
mkdir -p ~/.config/kitty
ln -sf ~/prog/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/prog/dotfiles/kitty/theme.conf ~/.config/kitty/current-theme.conf

# Ranger file explorer
ranger --copy-config all
ln -sf ~/prog/dotfiles/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sf ~/prog/dotfiles/ranger/rifle.conf ~/.config/ranger/rifle.conf

# Vscode
mkdir -p ~/.config/Code/User
ln -sf ~/prog/dotfiles/vscode/settings.jsonc ~/.config/Code/User/settings.json
ln -sf ~/prog/dotfiles/vscode/keybindings.jsonc ~/.config/Code/User/keybindings.json
# Needed for the CSS & JS extension
sudo chown -R $(whoami) $(which code)
sudo chown -R $(whoami) /opt/visual-studio-code

# Gromit-mpx
ln -sf ~/prog/dotfiles/gromit.cfg ~/.config/gromit-mpx.cfg

# Rust formatting
mkdir -p ~/.config/rustfmt
ln -sf ~/prog/dotfiles/rustfmt.toml ~/.config/rustfmt/rustfmt.toml

# Bacon
mkdir -p ~/.config/bacon
ln -sf ~/prog/dotfiles/bacon/prefs.toml ~/.config/bacon/prefs.toml

# Yt-dlp
ln -sf ~/prog/dotfiles/yt-dlp.conf ~/yt-dlp.conf

# Crontab
crontab -e
# @monthly ~/prog/dotfiles/scripts/crontab/monthly.fish

# Less
ln -sf ~/prog/dotfiles/lesskey ~/.config/lesskey

# Paru
ln -sf ~/prog/dotfiles/paru.conf ~/.config/paru/paru.conf