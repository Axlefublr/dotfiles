#!/usr/bin/env fish

alias inst-aichat 'sudo pacman -S --noconfirm aichat'

function inst-alacritty
    sudo pacman -S alacritty
    mkdir -p ~/.config/alacritty
    ln -sf ~/prog/dotfiles/alacritty.toml ~/.config/alacritty.toml
end

alias inst-ascii-image-converter 'paru -Sa --noconfirm ascii-image-converter-bin'

function inst-awm
    sudo pacman -S awesome
    mkdir -p ~/.config/awesome
    rm -fr ~/.config/awesome
    ln -sf ~/prog/dotfiles/awesome ~/.config/
    ln -sf ~/prog/dotfiles/awesome/awesome.lua ~/.config/awesome/rc.lua
end

function inst-bat
    sudo pacman -S --noconfirm bat
    set -Ux BAT_THEME ansi
    set -Ux BAT_STYLE plain
end

function inst-brillo
    sudo pacman -S --noconfirm brillo
    begin
        echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", RUN+="/bin/chgrp video /sys/class/backlight/%k/brightness"'
        echo 'ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", RUN+="/bin/chmod g+w /sys/class/backlight/%k/brightness"'
    end | sudo tee /etc/udev/rules.d/backlight.rules
end

function inst-boomer
    cd ~/prog/forks
    git clone https://github.com/Axlefublr/boomer
    cd boomer
    nimble build
    ln -sf ~/prog/dotfiles/boomer.conf ~/.config/boomer/config
end

function inst-bottom
    sudo pacman -S --noconfirm bottom
    ln -sf ~/prog/dotfiles/bottom.toml ~/.config/bottom/bottom.toml
end

function inst-bubbly
    curl https://raw.githubusercontent.com/siduck/bubbly/buttons/install.sh | sh
end
function uninst-bubbly
    rm -fr ~/.local/share/bubbly
    rm -fr ~/.config/bubbly
    rm -fr ~/.local/share/applications/bubbly.desktop
end

function inst-calcure
    paru -Sa --noconfirm calcure
    mkdir -p ~/.config/calcure
    ln -sf ~/prog/dotfiles/calcure.ini ~/.config/calcure/config.ini
    cp -fr ~/auto/calcure.csv ~/.config/calcure/events.csv
end

alias inst-cargo-script 'cargo binstall -y cargo-script'
function uninst-cargo-script
    rm -fr ~/.cargo/binary_cache
    rm -fr ~/.cargo/script_cache
end

function inst-copyq
    sudo pacman -S --noconfirm copyq
    pipx install git+https://github.com/cjbassi/rofi-copyq
end

function inst-display
    ln -sf ~/prog/dotfiles/desktop/display.desktop ~/.local/share/applications/display.desktop
    xdg-mime default display.desktop image/svg+xml
    xdg-mime default display.desktop image/png
    xdg-mime default display.desktop image/jpeg
    xdg-mime default display.desktop image/gif
    xdg-mime default display.desktop image/webp
end

function inst-dns
    begin
        echo 'nameserver 1.1.1.1' # cloudflare DNS server
        echo 'nameserver 8.8.8.8' # google DNS server
        sudo cat /etc/resolv.conf
    end | sponge | sudo tee /etc/resolv.conf

    # keep lowering this until it's okay
    ping -c 4 -M do -s 1472 google.com
    sudo ip link set dev wlan0 mtu $optimal_value
end

alias inst-exrex 'pipx install exrex'

function inst-eww
    cd ~/prog/stored
    git clone https://github.com/elkowar/eww
    cd eww
    cargo build --release --no-default-features --features x11
    ln $PWD/target/release/eww ~/prog/binaries
    mkdir -p ~/.config/eww
    touch ~/.config/eww/eww.yuck
end
function uninst-eww
    rm -fr ~/prog/stored/eww
    rm -fr ~/.config/eww
    rm -fr ~/prog/binaries/eww
end

function inst-fifc
    fisher install gazorby/fifc
    set -Ux fifc_editor helix
    # set -Ux fifc_fd_opts -u
    set -Ux fifc_keybinding \ej
end

function inst-firefox
    sudo pacman -S firefox
    # version 133.0
    # /etc/pacman.conf
    # IgnorePkg=firefox
    # widget.use-xdg-desktop-portal.file-picker 1
end

function inst-fstab
    # automounting setup
    sudo blkid # take UUIDs for the partitions here
    sudo -E helix /etc/fstab
    id -u # user_id
    id -g # group_id
    # UUID=the_uuid /mnt/usb ext4 defaults 0 2
    # UUID=the_uuid /mnt/fatusb exfat defaults,uid=user_id,gid=group_id,dmask=0222,fmask=0111 0 0
end

function pack-fuck
    sudo pacman -Rns --noconfirm eos-update-notifier
    sudo pacman -Rns --noconfirm nano-syntax-highlighting
    sudo pacman -Rns --noconfirm htop
    sudo pacman -Rns --noconfirm meld
end

function inst-gh
    sudo pacman -S --noconfirm github-cli
    gh auth login
    gh auth refresh -h github.com -s delete_repo
end

function inst-ghostty
    cd ~/prog/stored
    git clone --depth=1 https://github.com/ghostty-org/ghostty
    cd ghostty
    zig build -p $HOME/.local -Doptimize=ReleaseFast -Dapp-runtime=gtk
    mkdir -p ~/.config/ghostty
    ln -sf ~/prog/dotfiles/ghostty.conf ~/.config/ghostty/config
end

function inst-git
    sudo pacman -Syyu git
    # [[sort on]]
    git config --global branch.sort -committerdate
    git config --global checkout.defaultRemote origin
    git config --global commit.verbose true
    git config --global core.editor helix
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
    git config --global credential.helper store
    git config --global diff.colormoved default
    git config --global diff.colormovedws allow-indentation-change
    git config --global init.defaultBranch main
    git config --global interactive.singleKey true
    git config --global pull.ff only
    git config --global push.autoSetupRemote true
    git config --global rebase.updateRefs true
    git config --global rerere.enabled false
    git config --global user.email 101342105+Axlefublr@users.noreply.github.com
    git config --global user.name Axlefublr
    # [[sort off]]
end

function inst-gromit-mpx
    sudo pacman -S --noconfirm gromit-mpx
    ln -sf ~/prog/dotfiles/gromit.cfg ~/.config/gromit-mpx.cfg
    sudo ln -sf ~/prog/dotfiles/desktop/gromit-mpx.desktop /usr/share/applications/net.christianbeier.Gromit-MPX.desktop
end

function inst-gtk-theme
    # Lighted Pixel Butter — https://www.gnome-look.org/p/2103612
    sudo pacman -S --noconfirm gtk3-demo
    sudo ln -sf ~/prog/proj/gruvbox-material-gtk-theme /usr/share/themes/gruvbox-material
end

function inst-helix
    cd ~/prog/forks
    git clone --depth=1 https://github.com/Axlefublr/helix
    cd ~/prog/forks/helix
    cargo install --path helix-term --locked
    ln -sf ~/prog/dotfiles/helix ~/.config
    mkdir -p ~/.cargo/bin
    rm -fr ~/.cargo/bin/runtime
    ln -sf ~/prog/forks/helix/runtime ~/.cargo/bin
end

function inst-jj
    sudo pacman -S --noconfirm jj lazyjj
    jj util completion fish | source
    ln -sf ~/prog/dotfiles/jj.toml ~/.config/jj/config.toml
end

function inst-kitty
    sudo pacman -S kitty
    mkdir -p ~/.config/kitty
    ln -sf ~/prog/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
    ln -sf ~/prog/dotfiles/kitty/theme.conf ~/.config/kitty/current-theme.conf
end

function inst-kondo
    sudo pacman -S --noconfirm kondo
    kondo --completions fish
end

function inst-krita
    mkdir -p ~/.local/share/color-schemes
    ln -f ~/prog/dotfiles/krita/gruvbox.colors ~/.local/share/krita/color-schemes
end

function inst-lazygit
    sudo pacman -S lazygit
    mkdir -p ~/.config/lazygit
    ln -sf ~/prog/dotfiles/lazygit.yml ~/.config/lazygit/config.yml
end

function inst-less
    sudo ln -sf ~/prog/dotfiles/lesskey /opt/lesskey
end

function inst-mpv
    sudo pacman -S mpv
    sudo pacman -S mpv-mpris
    mkdir -p ~/.config/mpv
    ln -sf ~/prog/dotfiles/mpv/* ~/.config/mpv
    xdg-mime default mpv.desktop video/webm
    xdg-mime default mpv.desktop video/mp4
    xdg-mime default mpv.desktop video/x-matroska
end

function inst-neovide
    sudo pacman -S --noconfirm neovide
    set -Ux NEOVIDE_FORK false
end

function inst-nom
    # paru -Sa --noconfirm nom
    eget https://github.com/guyfedwards/nom
    mkdir -p ~/.config/nom
    ln -sf ~/prog/dotfiles/nom.yml ~/.config/nom/config.yml
    ln -sf ~/auto/nom.db ~/.config/nom/nom.db
end

function inst-nvim
    sudo pacman -S neovim luarocks
    trash-put ~/.config/nvim
    mkdir -p ~/.config/nvim
    for file in ~/prog/dotfiles/!nvim/*
        ln -sf $file ~/.config/nvim
    end
    for file in ~/prog/dotfiles/!nvim/.*
        ln -sf $file ~/.config/nvim
    end
end

function inst-other
    sudo loginctl enable-linger $USER
    sudo systemctl enable --now sddm
    sudo systemctl enable --now bluetooth.service
    sudo systemctl enable --now paccache.timer
end

function inst-ov
    # paru -Sa --noconfirm ov-bin
    cd ~/prog/forks
    gh repo clonef Axlefublr/ov
    make
    sudo install ov ~/.local/bin
    ov --completion fish >~/.config/fish/completions/ov.fish
    mkdir -p ~/.config/ov
    ln -sf ~/prog/dotfiles/ov.yaml ~/.config/ov/config.yaml
end

function inst-paru
    sudo pacman -S --noconfirm paru
    mkdir -p ~/.config/paru
    ln -sf ~/prog/dotfiles/paru.conf ~/.config/paru/paru.conf
end

function inst-picom
    sudo pacman -S --noconfirm picom
    mkdir -p ~/.config/picom
    ln -sf ~/prog/dotfiles/picom.conf ~/.config/picom/picom.conf
end

function inst-postgresql
    sudo pacman -S postgresql
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
    # set -Ux PGDATABASE dvdrental
    # set -Ux PGUSER postgres
end
function uninst-postgresql
    sudo systemctl disable postgresql
end

function inst-pueue
    sudo pacman -S --noconfirm pueue
    systemctl --user start pueued
    systemctl --user enable pueued
    systemctl --user status pueued
    ln -sf ~/prog/dotfiles/pueue.yml ~/.config/pueue/pueue.yml
    pueue group add k
    pueue group add K
    pueue group add i
    pueue group add c
    pueue group add s
    pueue parallel -g s 99
end

function inst-qalc
    sudo pacman -S libqalculate
    # set vspace off
    # set curconv off
    # set update exchange rates 1
end

function inst-qrtool
    sudo pacman -S --noconfirm qrtool
    qrtool --generate-completion
    qrtool --generate-completion fish >~/.config/fish/completions/qrtool.fish
end

function inst-repgrep
    # sudo pacman -S --noconfirm repgrep
    # you forked this
end

function inst-rofi
    sudo pacman -S rofi
    mkdir -p ~/.config/rofi
    ln -sf ~/prog/dotfiles/rofi.rasi ~/.config/rofi/config.rasi
    sudo ln -sf /usr/bin/rofi /usr/bin/dmenu
end

alias inst-rofi-calc 'sudo pacman -S --noconfirm rofi-calc'
function uninst-rofi-calc
    sudo pacman -Rns rofi-calc
    rm -fr ~/.local/share/rofi/rofi_calc_history
end

alias inst-scriptisto 'cargo binstall -y scriptisto'

function inst-serpl
    sudo pacman -S --noconfirm serpl
    paru -Sa --noconfirm ast-grep-bin
    mkdir -p ~/.config/serpl
    ln -sf ~/prog/dotfiles/serpl.yml ~/.config/serpl/serpl.yml
end

function inst-screenkey
    sudo pacman -S screenkey
    sudo ln -sf ~/prog/dotfiles/desktop/screenkey.desktop /usr/share/applications
end

function inst-steam
    sudo pacman -S --noconfirm steam
end

function inst-termfilechooser
    sudo pacman -S xdg-desktop-portal-gtk
    paru -Sa --noconfirm xdg-desktop-portal-termfilechooser-git
    fish_add_path /usr/lib
    set -Ux TERMCMD kitty
    set -Ux GDK_DEBUG portals
    set -Ux GTK_USE_PORTAL 1
    mkdir -p ~/.config/xdg-desktop-portal-termfilechooser
    ln -sf ~/prog/dotfiles/termfilechooser/config ~/.config/xdg-desktop-portal-termfilechooser/config
    sudo mkdir -p /usr/local/share/xdg-desktop-portal-termfilechooser
    sudo ln -sf ~/prog/dotfiles/termfilechooser/yazi-wrapper.sh /usr/local/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    mkdir -p ~/.config/xdg-desktop-portal
    ln -sf ~/prog/dotfiles/termfilechooser/portals.conf ~/.config/xdg-desktop-portal/portals.conf
    systemctl --user restart xdg-desktop-portal.service
    systemctl --user restart xdg-desktop-portal-termfilechooser.service
end

alias inst-tiptop 'pipx install tiptop'

function inst-tridactyl
    # :nativeinstall
    # to copy the command to execute
    mkdir -p ~/.config/tridactyl
    ln -f ~/prog/dotfiles/tridactyl ~/.config/tridactyl/tridactylrc
end

function inst-ttyper
    sudo pacman -S ttyper
    ln -sf ~/.local/share/magazine/U ~/.config/ttyper/language/uclanr
end

alias inst-tuisky 'cargo binstall -y tuisky'

function inst-twemoji
    paru -Sa --noconfirm ttf-twemoji
    sudo ln -sf /usr/share/fontconfig/conf.avail/75-twemoji.conf /etc/fonts/conf.d/75-twemoji.conf
end

alias inst-tz 'paru -Sa --noconfirm tz'

function inst-vscode
    mkdir -p ~/.config/Code/User
    ln -sf ~/prog/dotfiles/vscode/settings.jsonc ~/.config/Code/User/settings.json
    ln -sf ~/prog/dotfiles/vscode/keybindings.jsonc ~/.config/Code/User/keybindings.json
    Needed for the CSS & JS extension
    sudo chown -R $(whoami) $(which code)
    sudo chown -R $(whoami) /opt/visual-studio-code
end

function inst-x
    ln -sf ~/prog/dotfiles/x11/xresources ~/.Xresources
    ln -sf ~/prog/dotfiles/x11/.XCompose ~/.XCompose
    set -Ux XMODIFIERS @im=none
end

function inst-xremap
    sudo pacman -S --noconfirm xremap-x11-bin
    sudo usermod -aG input $USER
    sudo usermod -aG video $USER
    echo 'KERNEL=="uinput", GROUP="input", MODE="0660"' | sudo tee /etc/udev/rules.d/99-uinput.rules
end

function inst-yazi
    sudo pacman -S yazi
    rm -fr ~/.config/yazi
    ln -s ~/prog/dotfiles/yazi ~/.config
    ya pack -a yazi-rs/plugins:hide-preview
    ya pack -a yazi-rs/plugins:jump-to-char
    ya pack -a Ape/open-with-cmd
    ya pack -a KKV9/compress
end

function inst-ydotool
    sudo pacman -S --noconfirm ydotool
    pueue add -g s ydotoold
end

function inst-yt-dlp
    sudo pacman -S yt-dlp
    mkdir -p ~/.config/yt-dlp
    ln -sf ~/prog/dotfiles/yt-dlp.conf ~/.config/yt-dlp/config
end

function inst-zathura
    sudo pacman -S zathura
    sudo pacman -S zathura-pdf-mupdf
    mkdir -p ~/.config/zathura
    ln -sf ~/prog/dotfiles/zathura ~/.config/zathura/zathurarc
    xdg-mime default org.pwmt.zathura.desktop application/pdf
end

function inst-zola
    sudo pacman -S --noconfirm zola
end

function inst-zoxide
    sudo pacman -S --noconfirm zoxide
    set -Ux _ZO_FZF_OPTS '--layout default --height 100%'
    set -Ux _ZO_MAXAGE 30000
end
