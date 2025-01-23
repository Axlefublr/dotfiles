#!/usr/bin/env fish

function pack-man
    sudo pacman -Syyu
    for package_name in (cat ~/.local/share/magazine/Z)
        sudo pacman -S --noconfirm $package_name
    end
    for package_name in (cat ~/.local/share/magazine/X)
        paru --noconfirm -aS $package_name
    end
end

function pack-crystal
    sudo pacman -S --noconfirm crystal shards
end

function pack-dotnet
    set -Ux DOTNET_CLI_TELEMETRY_OPTOUT true
    fish_add_path "$HOME/.dotnet/tools"
end

function pack-eget-pack
    paru -Sa --noconfirm eget-bin
    set -Ux EGET_BIN ~/.local/bin
end

function pack-elixir
    sudo pacman -S --noconfirm elixir
end

function pack-fish
    sudo pacman -S --noconfirm fish
    chsh -s /usr/bin/fish
    mkdir -p ~/.config/fish
    ln -sf ~/prog/dotfiles/fish/config.fish ~/.config/fish/config.fish
    for file in ~/prog/dotfiles/fish/fun/*.fish
        $file
    end
    ~/prog/dotfiles/fish/once.fish
    ~/prog/dotfiles/fish/universal.fish
end
function pack-fish-pack
    sudo pacman -S --noconfirm fisher
end
function pack-fish-lang
    git clone https://github.com/ndonfris/fish-lsp ~/prog/stored/fish-lsp
    cd ~/prog/stored/fish-lsp
    yarn install
    set -Ux fish_lsp_enabled_handlers formatting complete hover rename definition references diagnostics signatureHelp codeAction index
    # set -Ux fish_lsp_disabled_handlers
    set -Ux fish_lsp_format_tabsize 4
    set -Ux fish_lsp_all_indexed_paths ~/prog/dotfiles/fish/fun ~/.config/fish /usr/share/fish
    # set -Ux fish_lsp_modifiable_paths
    # 2003 is "universal variable defined not in interactive session"
    # 2001 is something about single quotes being used for an expandable thing
    # 2002 is "alias used, prefer functions instead" like WOW that is one of the stupidest lints I have ever seen
    set -Ux fish_lsp_diagnostic_disable_error_codes 2003 2001 2002
    set -Ux fish_lsp_show_client_popups false
end

function pack-go
    sudo pacman -S --noconfirm go
    mkdir -p ~/go/bin
    fish_add_path ~/go/bin
end
function pack-go-lang
    sudo pacman -S --noconfirm gopls
end

function pack-java
    sudo pacman -S --noconfirm jdk8-openjdk maven
    paru -Sa --noconfirm intellij-idea-community-edition-jre
end

function pack-kotlin
    sudo pacman -S --noconfirm kotlin jre-openjdk
end

function pack-nim
    curl https://nim-lang.org/choosenim/init.sh -sSf | sh
    fish_add_path "$HOME/.nimble/bin"
end
function pack-nim-lang
    # nimble install nimlangserver
    nimble install nimlsp
end

function pack-ruby
    sudo pacman -S rubocop
    fish_add_path "$HOME/.local/share/gem/ruby/3.3.0/bin"
end
function pack-ruby-lang
    gem install solargraph
    mkdir -p ~/.config/rubocop
    ln -sf ~/prog/dotfiles/.rubocop.yml ~/.config/rubocop/config.yml
end

function pack-rust
    sudo pacman -S --noconfirm rustup
    fish_add_path ~/.cargo/bin
    fish_add_path ~/.cargo/env
    mkdir -p ~/.cargo/{bin,env}
    bash "$HOME/.cargo/env"
    rustup update
    rustup default stable
    rustup toolchain install nightly
    cargo login
    ln -sf ~/prog/dotfiles/cargo.toml ~/.cargo/config.toml
end
function pack-rust-pack
    sudo pacman -S --noconfirm cargo-binstall
    sudo pacman -S --noconfirm cargo-update
    cargo binstall -y cargo-quickinstall
end
function pack-rust-lang
    rustup component add rust-analyzer
    mkdir -p ~/.config/rustfmt
    ln -sf ~/prog/dotfiles/defconf/rustfmt.toml ~/.config/rustfmt/rustfmt.toml
end

function pack-ocaml
    sudo pacman -S dune
    sudo pacman -S opam
    opam init -y
    opam update
    opam upgrade
    eval (opam env)
    opam switch create ocaml-base-compiler
    opam switch set ocaml-base-compiler
    echo 'eval (opam env)' >>~/.config/fish/config.fish
end
function pack-ocaml-lang
    eval (opam env)
    opam install ocaml-lsp-server
    opam install ocamlformat
    opam install utop
end

function pack-python
    sudo pacman -S --noconfirm python3 python-docs
    sudo pacman -S --noconfirm python-toml # helix config generator
    set -Ux PYTHONSTARTUP ~/prog/dotfiles/pyrc.py
end
function pack-python-lang
    paru -Sa --noconfirm basedpyright-git
    sudo pacman -S ruff
    mkdir -p ~/.config/ruff
    ln -sf ~/prog/dotfiles/defconf/pyproject.toml ~/.config/ruff/pyproject.toml
end
