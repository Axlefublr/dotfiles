#!/usr/bin/env fish

function wks
    not set -q argv[1] && return 121

    set -l script_path $argv[1]
    set -l script_name (path basename $script_path)

    mkdir -p ~/r/wks/src
    cd ~/r/wks

    if not test -d ~/.cache/wks/$script_name
        mkdir -p ~/.cache/wks/$script_name/{src,target}
        cp -f ~/r/dot/defconf/wks/blank.rs ~/.cache/wks/$script_name/src/main.rs
        sd %% "$script_path" ~/.cache/wks/$script_name/src/main.rs
        cp -f ~/r/dot/defconf/wks/blank.toml ~/.cache/wks/$script_name/Cargo.toml
    end
    if not test -d ~/.cache/wks/$script_name/target
        mkdir -p ~/.cache/wks/$script_name/target
    end

    ln -snf ~/.cache/wks/$script_name/target $PWD/target
    ln -sf ~/.cache/wks/$script_name/src/main.rs $PWD/src/main.rs
    ln -sf ~/.cache/wks/$script_name/Cargo.toml $PWD/Cargo.toml
    ln -sf ~/.cache/wks/$script_name/Cargo.lock $PWD/Cargo.lock
end
funcsave wks >/dev/null

function run-rust-script.rs
    not set -q argv[1] && return 121
    import-rust-script.rs $argv[1]
    set -l script_name (path basename $argv[1])
    env -C ~/.cache/wks/$script_name cargo run -q
end
funcsave run-rust-script.rs >/dev/null
