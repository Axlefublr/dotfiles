#!/usr/bin/env fish

#----------------------------------------------------rust----------------------------------------------------

function rust-release
    if not set -q argv[1]
        echo 'set the version'
        return 1
    end
    set -l taggedVersion $argv[1]

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

    echo '1. update README'
    echo '2. update --help'
    echo '3. ci will get updated'
    read -P 'proceed?: ' -ln 1 should_continue
    not test $should_continue && return 1

    if not rg -q "^version = \"$taggedVersion\"" Cargo.toml
        echo "update version in Cargo.toml"
        return 1
    end

    rust-fmt
    rust-ci

    git add . &&
        git commit -m $taggedVersion &&
        git push &&
        git tag $taggedVersion -F curtag.txt &&
        git push origin $taggedVersion
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

function rust-fmt --description 'Bring in format config and format with it'
    gq || return 1
    lnkj ~/prog/dotfiles/defconf/rustfmt.toml ./.rustfmt.toml
    and cargo +nightly fmt
end
funcsave rust-fmt >/dev/null

function rust-ci --description 'Bring in on tag push github action'
    gq || return 1
    mkdir -p ./.github/workflows &&
        cp -f ~/prog/dotfiles/defconf/gh-action-rust.yml ./.github/workflows/ci.yml &&
        sd your-project-name (basename $PWD) ./.github/workflows/ci.yml
end
funcsave rust-ci >/dev/null

# TODO: require commit message
function rust-bin
    gq || return 1
    set -l name (basename $PWD)
    cargo build -r
    and lnkj ./target/release/$name ~/prog/binaries/$name
    if set -q argv[1]
        set -l newVersion $argv[1]
        set -l prevdir (pwd)
        cd ~/prog/binaries # TODO: specify git repo via flag
        git add $name && git commit -m "$name: $newVersion"
        cd $prevdir
    end
end
funcsave rust-bin >/dev/null

function rust-init
    cargo init
    cp -f ~/prog/dotfiles/defconf/rust-metadata.toml ./Cargo.toml
    sd '%project_name%' (basename $PWD) Cargo.toml
    touch README.md
    touch curtag.txt
    touch project.txt
    rust-ci
    git add . &&
        git commit -m 'first commit'
end
funcsave rust-init >/dev/null

#---------------------------------------------------python---------------------------------------------------

function py-init
    gq || return 1
    lnkj ~/prog/dotfiles/defconf/pyproject.toml ./pyproject.toml
end
funcsave py-init >/dev/null
