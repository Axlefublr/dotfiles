#!/usr/bin/env fish

#---------------------------rust---------------------------

function rs
    not test "$argv" && return 121
    switch $argv[1]
        case c create
            not test "$argv[2..]" && return 121
            _repo_create $argv[2]
            _rust_init $argv[3..]
        case f fmt
            _rust_fmt
        case ci
            _rust_ci
    end
end
funcsave rs >/dev/null

function _repo_create
    echo 'cd ~/r/proj' >&2
    cd ~/r/proj
    echo "repo name is: $argv[1]" >&2
    read -P 'repo description (leave empty for none):' -l repo_description || return 130
    test "$repo_description" && set -l description_flag -d "$repo_description"
    begin
        echo 'we are relying on the gh fool to:'
        echo '1. clone the repo we create'
        echo '2. set the license'
        echo '3. zoxide into it'
        echo 'however, we set --public, as well as (optionally) description ourselves'
    end >&2
    confirm.rs continue? [j]es [k]o | read -l response
    test "$response" = j || return 130
    # specifying name last is significant here, as it's what makes zoxiding work
    gh repo create --public $description_flag $argv[1]
end
funcsave _repo_create >/dev/null

function _rust_init -d 'Add starting pieces of a rust project in the current directory'
    confirm.rs "you're supposed to be in repo root. you're in $(path basename $PWD)" [j]k '[k]h fuck!' | read -l response
    test "$response" = j || return 130
    cargo init
    echo 'copying default Cargo.toml here' >&2
    cp -f ~/r/dot/defconf/rs/cargo.toml ./Cargo.toml
    echo "replacing templatings with cwd's basename" >&2
    sd '%project_name%' (path basename $PWD) Cargo.toml
    echo 'creating readme, project.txt, curtag.txt' >&2
    touch README.md
    touch curtag.txt
    touch project.txt
    confirm.rs 'want formatting config?' [j]es [k]o | read -l response
    test "$response" = j && _rust_fmt
    confirm.rs 'want ci config?' [j]es [k]o | read -l response
    test "$response" = j && _rust_ci
    git add . &&
        git commit -m 'first commit'
end
funcsave _rust_init >/dev/null

function _rust_fmt --description 'Bring in format config and format with it'
    gq || return 1
    lnkj ~/r/dot/defconf/rs/rustfmt.toml ./.rustfmt.toml
    rustup run nightly rustfmt
end
funcsave _rust_fmt >/dev/null

function _rust_ci --description 'Bring in on tag push github action'
    gq || return 1
    mkdir -p ./.github/workflows &&
        cp -f ~/r/dot/defconf/rs/ghaction.yml ./.github/workflows/ci.yml &&
        sd your-project-name (basename $PWD) ./.github/workflows/ci.yml
end
funcsave _rust_ci >/dev/null

function rust-release
    gq || return 1

    if not test -f README.md
        echo 'no readme'
        return 1
    end
    if not test -s README.md
        echo 'readme is empty'
        return 1
    end

    if not test -f curtag.txt
        echo 'no tag notes'
        return 1
    end
    if not test -s curtag.txt
        echo 'tag notes empty'
        return 1
    end

    if rg -q '^description \= ""$' Cargo.toml
        echo 'no description in Cargo.toml'
        return 1
    end

    set -l tagged_version (rg '^version = ' Cargo.toml | string match -gr 'version = "(.*?)"')
    confirm.rs "release $tagged_version?" '[j]es' '[k]o' | read -l response
    test "$response" = j || return 1

    echo '1. update README'
    echo '2. update --help'
    echo '3. ci will get updated'
    confirm.rs 'proceed?' '[j]es' '[k]o' | read -l response
    test "$response" = j || return 1

    rust-fmt
    rust-ci

    git add . &&
        git commit -m $tagged_version &&
        git push &&
        git tag $tagged_version -F curtag.txt &&
        git push origin $tagged_version
    truncate -s 0 curtag.txt
    cargo publish
end
funcsave rust-release >/dev/null

function rust-publish
    gq || return 1
    if rg -q '^description \= ""$' Cargo.toml
        echo 'no description in Cargo.toml'
        return 1
    end
    if test (git status -s | count) -ge 1
        echo 'you have unstaged changes'
        return 1
    end
    cargo publish
end
funcsave rust-publish >/dev/null

function rust-bin -a message other_name
    not set -q message && return 121
    gq || return 1
    if test $other_name
        set -f name $other_name
    else
        set -f name (basename $PWD)
    end
    cargo build -r
    and cp -f ./target/release/$name ~/r/binaries/$name
    git -C ~/r/binaries add $name && git -C ~/r/binaries commit -m "$name: $message"
end
funcsave rust-bin >/dev/null

#---------------------------------------------------python---------------------------------------------------

function py-init
    gq || return 1
    lnkj ~/r/dot/defconf/pyproject.toml ./pyproject.toml
end
funcsave py-init >/dev/null
