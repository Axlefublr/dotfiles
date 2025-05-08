#!/usr/bin/env fish

function rs
    not test "$argv" && return 121
    switch $argv[1]
        case c create
            not test "$argv[2..]" && return 121
            _repo_create $argv[2]
            _rust_init $argv[3..]
        case i init
            _rust_init
        case f fmt
            _rust_fmt
        case ci
            _rust_ci
        case check
            _rust_fmt
            _rust_ci
        case b bin
            not test "$argv[2..]" && return 121
            _rust_bin $argv[2..]
        case r release
            _rust_release $argv[2..]
        case p publish
            _rust_publish $argv[2..]
    end
end
funcsave rs >/dev/null

function _repo_create
    echo 'cd ~/r/proj' >&2
    cd ~/r/proj
    echo "repo name is: $argv[1]" >&2
    read -P 'repo description (leave empty for none):' -l repo_description || return 130
    test "$repo_description" && set -l description_flag -d "$repo_description"
    # we are relying on the gh fool to:
    # 1. clone the repo we create
    # 2. set the license
    # 3. zoxide into it
    # however, we set --public, as well as (optionally) description ourselves
    confirm.rs continue? [j]es [k]o | read -l response
    test "$response" = j || return 130
    # specifying name last is significant here, as it's what makes zoxiding work
    gh repo create --public $description_flag $argv[1]
end
funcsave _repo_create >/dev/null

function _rust_init -d 'Add starting pieces of a rust project in the current directory'
    gq || return 1
    cargo init
    echo 'copying default Cargo.toml here' >&2
    cp -f ~/r/dot/defconf/rs/cargo.toml ./Cargo.toml
    echo "replacing templatings with cwd's basename" >&2
    sd '%project_name%' (path basename $PWD) Cargo.toml
    echo 'creating readme, project.txt, RELEASE.md' >&2
    touch README.md
    touch RELEASE.md
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
    lnkj $argv ~/r/dot/defconf/rs/rustfmt.toml ./.rustfmt.toml
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

function _rust_bin -a message other_name
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
funcsave _rust_bin >/dev/null

function _rust_release
    gq || return 1

    if not test -f README.md
        echo 'no readme' >&2
        return 1
    end
    if not test -s README.md
        echo 'readme is empty' >&2
        return 1
    end

    set -l tagged_version (rg '^version = ' Cargo.toml | string match -gr 'version = "(.*?)"')
    echo "detected version $tagged_version" >&2

    if rg -q '^description \= ""$' Cargo.toml
        echo 'no description in Cargo.toml' >&2
        return 1
    end

    if not test -f RELEASE.md
        echo 'no release notes' >&2
        return 1
    end
    if not test -s RELEASE.md
        echo 'release notes empty' >&2
        return 1
    end
    if not git status --porcelain | rg RELEASE
        confirm.rs 'have you updated RELEASE.md?' [j]es [k]o | read -l response
        test "$response" = j || return 1
    end

    confirm.rs 'updated README and --help?' '[j]es' '[k]o' | read -l response
    test "$response" = j || return 1

    if not test -f .rustfmt.toml
        confirm.rs 'no formatting config. blammo?' [j]es '[k]o need' | read -l response
        if test "$response" = j
            _rust_fmt
        end
    else
        echo 'updating formatting config' >&2
        _rust_fmt -c
    end
    if not test -f .github/workflows/ci.yml
        confirm.rs 'no ci config. blammo?' [j]es '[k]o need' | read -l response
        if test "$response" = j
            _rust_ci
        end
    else
        echo 'updating ci config' >&2
        _rust_ci
    end

    confirm.rs "release?" '[j]es' '[k]o' | read -l response
    test "$response" = j || return 1

    git add .
    and git commit -m $tagged_version
    and git push
    and git tag $tagged_version -F RELEASE.md
    and git push origin $tagged_version
    and cargo publish
    and truncate -s 0 RELEASE.md
end
funcsave _rust_release >/dev/null

function _rust_publish
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
funcsave _rust_publish >/dev/null
