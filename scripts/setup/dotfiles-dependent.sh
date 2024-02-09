#!/usr/bin/bash

# X
cp -f ~/prog/dotfiles/x11/.Xresources ~/.Xresources
ln -sf ~/prog/dotfiles/x11/.xinitrc ~/.xinitrc

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
ln -sf ~/prog/dotfiles/ranger/ranger.conf ~/.config/ranger/rc.conf
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
ln -sf ~/prog/dotfiles/rust/rustfmt.toml ~/.config/rustfmt/rustfmt.toml

# Bacon
mkdir -p ~/.config/bacon
ln -sf ~/prog/dotfiles/bacon/prefs.toml ~/.config/bacon/prefs.toml

# Yt-dlp
ln -sf ~/prog/dotfiles/yt-dlp.conf ~/yt-dlp.conf

# Less
sudo ln -sf ~/prog/dotfiles/lesskey /opt/lesskey

# Paru
mkdir -p ~/.config/paru
ln -sf ~/prog/dotfiles/paru.conf ~/.config/paru/paru.conf

# Custom compose
ln -sf ~/prog/dotfiles/compose.txt ~/.XCompose

# Xremap
sudo usermod -aG input $USER
sudo usermod -aG video $USER
echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-uinput.rules

# Awesome wm
mkdir -p ~/.config/awesome
ln -sf ~/prog/dotfiles/awesome/awesome.lua ~/.config/awesome/rc.lua
ln -sf ~/prog/dotfiles/awesome/theme.lua ~/.config/awesome/theme.lua

# Postgresql
sudo -iu postgres 'initdb -D /var/lib/postgres/data'
sudo systemctl start postgresql
sudo systemctl enable postgresql
sudo usermod -aG postgres $USER
sudo setfacl -R -m u:axlefublr:rwx /var/lib/postgres/data
nvim /var/lib/postgres/data/postgresql.conf # listen_addresses = '*'
sudo sed -i '/^host/s/ident/md5/' /var/lib/postgres/data/pg_hba.conf
sudo sed -i '/^local/s/peer/trust/' /var/lib/postgres/data/pg_hba.conf
echo "host all all 0.0.0.0/0 md5" | sudo tee -a /var/lib/postgres/data/pg_hba.conf
sudo setfacl -R -x u:axlefublr /var/lib/postgres/data
sudo systemctl restart postgresql
sudo ufw allow 5432/tcp
sudo touch /var/lib/postgres/.psql_history
sudo chown postgres:postgres /var/lib/postgres/.psql_history
psql -U postgres
# ALTER USER postgres PASSWORD 'password';
# \pset null 󰟢
# \q
cd ~/Documents
curl -O https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
unzip dvdrental.zip
rm -fr dvdrental.zip
psql -U postgres
# create database dvdrental;
# \q
pg_restore -U postgres --dbname=dvdrental --verbose dvdrental.tar
rm -fr dvdrental.tar
psql -U postgres
# \c dvdrental
# select count(*) from film;
# select version();