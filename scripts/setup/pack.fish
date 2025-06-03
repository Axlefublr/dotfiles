#!/usr/bin/env fish

# ----------------main----------------
sudo pacman -Syu
for package_name in (cat ~/.local/share/magazine/Z)
    sudo pacman -S --needed --noconfirm --disable-download-timeout $package_name
end
for package_name in (cat ~/.local/share/magazine/X)
    paru -Sa --needed --noconfirm --disable-download-timeout $package_name
end

#--------------------crystal--------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout crystal shards

#--------------------dotnet--------------------
set -Ux DOTNET_CLI_TELEMETRY_OPTOUT true
fish_add_path "$HOME/.dotnet/tools"

#----------------------eget----------------------
paru -Sa --needed --noconfirm --disable-download-timeout eget-bin
set -Ux EGET_BIN ~/.local/bin

#--------------------elixir--------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout elixir

#--------------------fish--------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout fish
chsh -s /usr/bin/fish
mkdir -p ~/.config/fish
ln -sf ~/fes/dot/fish/config.fish ~/.config/fish/config.fish
for file in ~/fes/dot/fish/fun/*.fish
    $file
end

sudo pacman -S --needed --noconfirm --disable-download-timeout fisher

git clone https://github.com/ndonfris/fish-lsp ~/fes/ork/fish-lsp
cd ~/fes/ork/fish-lsp
yarn install
set -Ux fish_lsp_enabled_handlers formatting complete hover rename definition references diagnostics signatureHelp codeAction index
# set -Ux fish_lsp_disabled_handlers
set -Ux fish_lsp_format_tabsize 4
set -Ux fish_lsp_all_indexed_paths ~/fes/dot/fish/fun ~/.config/fish /usr/share/fish
# set -Ux fish_lsp_modifiable_paths
# 2003 is "universal variable defined not in interactive session"
# 2001 is something about single quotes being used for an expandable thing
# 2002 is "alias used, prefer functions instead" like WOW that is one of the stupidest lints I have ever seen
set -Ux fish_lsp_diagnostic_disable_error_codes 2003 2001 2002
set -Ux fish_lsp_show_client_popups false

#--------------------flatpack--------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout flatpak
flatpak install flathub

#--------------------go--------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout go
mkdir -p ~/go/bin
fish_add_path ~/go/bin

sudo pacman -S --needed --noconfirm --disable-download-timeout gopls

#--------------------java--------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout jdk8-openjdk maven
paru -Sa --needed --noconfirm --disable-download-timeout intellij-idea-community-edition-jre

#--------------------julia--------------------
julia # to then execute things in the repl
import Pkg
Pkg.add("LanguageServer")
Pkg.add("SymbolServer")

#--------------------kotlin--------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout kotlin jre-openjdk

#--------------------nim--------------------
curl https://nim-lang.org/choosenim/init.sh -sSf | sh
fish_add_path "$HOME/.nimble/bin"

# nimble install nimlangserver
nimble install nimlsp

#--------------------nushell--------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout nushell

#--------------------ruby--------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout ruby rubocop
fish_add_path "$HOME/.local/share/gem/ruby/3.3.0/bin"

gem install solargraph
mkdir -p ~/.config/rubocop
ln -sf ~/fes/dot/.rubocop.yml ~/.config/rubocop/config.yml

#--------------------rust--------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout rustup
mkdir -p ~/.cargo/{bin,env}
fish_add_path ~/.cargo/bin
fish_add_path ~/.cargo/env
bash "$HOME/.cargo/env"
rustup update
rustup default stable
rustup toolchain install nightly
cargo login
ln -sf ~/fes/dot/cargo.toml ~/.cargo/config.toml

sudo pacman -S --needed --noconfirm --disable-download-timeout cargo-binstall
sudo pacman -S --needed --noconfirm --disable-download-timeout cargo-update
cargo binstall -y cargo-quickinstall

rustup component add rust-analyzer
mkdir -p ~/.config/rustfmt
ln -sf ~/fes/dot/defconf/rustfmt.toml ~/.config/rustfmt/rustfmt.toml

#----------------------stew----------------------
paru -Sa --needed --disable-download-timeout stew-bin

#--------------------ocaml--------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout dune opam
opam init -y
opam update
opam upgrade
eval (opam env)
opam switch create ocaml-base-compiler
opam switch set ocaml-base-compiler
echo 'eval (opam env)' >>~/.config/fish/config.fish

eval (opam env)
opam install ocaml-lsp-server
opam install ocamlformat
opam install utop

#--------------------python--------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout python3 python-docs
set -Ux PYTHONSTARTUP ~/fes/dot/pyrc.py

paru -Sa --needed --noconfirm --disable-download-timeout basedpyright-git
sudo pacman -S ruff
mkdir -p ~/.config/ruff
ln -sf ~/fes/dot/defconf/pyproject.toml ~/.config/ruff/pyproject.toml

#---------------------uv---------------------
sudo pacman -S --needed --noconfirm --disable-download-timeout uv
