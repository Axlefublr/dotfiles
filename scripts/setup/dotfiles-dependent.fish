#!/usr/bin/env fish

# X
ln -sf ~/prog/dotfiles/x11/xresources ~/.Xresources
ln -sf ~/prog/dotfiles/x11/.XCompose ~/.XCompose

# Paru
mkdir -p ~/.config/paru
ln -sf ~/prog/dotfiles/paru.conf ~/.config/paru/paru.conf

# Xremap
sudo usermod -aG input $USER
sudo usermod -aG video $USER
echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-uinput.rules

# Neovim
trash-put ~/.config/nvim
ln -sf ~/prog/dotfiles/astro ~/.config/nvim

# Fish shell
chsh -s /usr/bin/fish
mkdir -p ~/.config/fish
ln -sf ~/prog/dotfiles/fish/config.fish ~/.config/fish/config.fish

# Alacritty
mkdir -p ~/.config/alacritty
ln -sf ~/prog/dotfiles/alacritty.toml ~/.config/alacritty.toml

# Kitty terminal
mkdir -p ~/.config/kitty
ln -sf ~/prog/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/prog/dotfiles/kitty/theme.conf ~/.config/kitty/current-theme.conf

# Vscode
# mkdir -p ~/.config/Code/User
# ln -sf ~/prog/dotfiles/vscode/settings.jsonc ~/.config/Code/User/settings.json
# ln -sf ~/prog/dotfiles/vscode/keybindings.jsonc ~/.config/Code/User/keybindings.json
# Needed for the CSS & JS extension
# sudo chown -R $(whoami) $(which code)
# sudo chown -R $(whoami) /opt/visual-studio-code

# Awesome wm
mkdir -p ~/.config/awesome
ln -sf ~/prog/dotfiles/awesome/awesome.lua ~/.config/awesome/rc.lua
ln -sf ~/prog/dotfiles/awesome/* ~/.config/awesome

# Picom
mkdir -p ~/.config/picom
ln -sf ~/prog/dotfiles/picom.conf ~/.config/picom/picom.conf

# Gromit-mpx
ln -sf ~/prog/dotfiles/gromit.cfg ~/.config/gromit-mpx.cfg
sudo ln -sf ~/prog/dotfiles/desktop/gromit-mpx.desktop /usr/share/applications/net.christianbeier.Gromit-MPX.desktop

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

# Twemoji
sudo ln -sf /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/75-twemoji.conf

# Mpv
mkdir -p ~/.config/mpv
ln -sf ~/prog/dotfiles/mpv/* ~/.config/mpv
xdg-mime default mpv.desktop video/webm
xdg-mime default mpv.desktop video/mp4
xdg-mime default mpv.desktop video/x-matroska

# Rofi
mkdir -p ~/.config/rofi
ln -sf ~/prog/dotfiles/rofi.rasi ~/.config/rofi/config.rasi
sudo ln -sf /usr/bin/rofi /usr/bin/dmenu

# Screenkey
sudo ln -sf ~/prog/dotfiles/desktop/screenkey.desktop /usr/share/applications

# Tsoding/boomer
cd ~/prog
git clone https://github.com/tsoding/boomer
cd boomer
nimble build
ln -sf ~/prog/dotfiles/boomer.conf ~/.config/boomer/config

# Zathura
mkdir -p ~/.config/zathura
ln -sf ~/prog/dotfiles/zathura ~/.config/zathura/zathurarc

# Clipster
mkdir -p ~/.config/clipster
ln -sf ~/prog/dotfiles/clipster.ini ~/.config/clipster/clipster.ini

# Display
ln -sf ~/prog/dotfiles/desktop/display.desktop ~/.local/share/applications/display.desktop
xdg-mime default display.desktop image/svg+xml
xdg-mime default display.desktop image/png
xdg-mime default display.desktop image/jpeg
xdg-mime default display.desktop image/gif

# Postgresql
ln -sf ~/prog/dotfiles/psqlrc ~/.psqlrc
sudo -iu postgres initdb -D /var/lib/postgres/data
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
psql -U postgres -c "ALTER USER postgres PASSWORD '$(read -sP 'enter your password: ')'"
cd ~/Documents
curl -O https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
unzip dvdrental.zip
rm -fr dvdrental.zip
psql -U postgres -c 'CREATE DATABASE dvdrental;'
pg_restore -U postgres --dbname=dvdrental --verbose dvdrental.tar
rm -fr dvdrental.tar
psql -U postgres -d dvdrental -c 'SELECT count(*) FROM film;' -c 'SELECT version();'