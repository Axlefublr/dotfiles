#!/usr/bin/env fish

#----------------------------------------------------rust----------------------------------------------------

function rust-release
    if not set -q argv[1]
        echo 'set the version'
        return 1
    end
    set -l taggedVersion $argv[1]

    if not test (git rev-parse --show-toplevel 2> /dev/null) = $PWD
        echo "you're not in repo root"
        return 1
    end

    if not test -f README.md
        echo 'no readme'
        return 1
    end
    if not test -s README.md
        echo 'readme is empty'
        return 1
    end

    if not test -f release-notes.txt
        echo 'no release notes'
        return 1
    end
    if not test -s release-notes.txt
        echo 'release notes empty'
        return 1
    end

    if rg -q '^description \= ""$' Cargo.toml
        echo 'no description in Cargo.toml'
        return 1
    end

    echo 'did you update the README?'
    echo 'did you update --help?'
    echo 'your ci pipeline is going to get updated if necessary'
    read -p rdp -ln 1 should_continue
    if not test $should_continue
        return 1
    end

    if not rg -q "^version = \"$taggedVersion\"" Cargo.toml
        echo "you didn't update the version in Cargo.toml"
        return 1
    end

    rust-ci
    indeed -u .gitignore release-notes.txt
    cargo +nightly fmt

    git add . &&
        git commit -m $taggedVersion &&
        git push &&
        git tag $taggedVersion -F release-notes.txt &&
        git push origin $taggedVersion
    truncate -s 0 release-notes.txt
    cargo publish
end
funcsave rust-release >/dev/null

function rust-publish
    if not test (git rev-parse --show-toplevel 2> /dev/null) = $PWD
        echo "you're not in repo root"
        return 1
    end
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
    if not test (git rev-parse --show-toplevel 2> /dev/null) = $PWD
        echo "you're not in repo root"
        return 1
    end
    cp -f ~/prog/dotfiles/defconf/rustfmt.toml ./.rustfmt.toml &&
        cargo +nightly fmt
end
funcsave rust-fmt >/dev/null

function rust-ci --description 'Bring in on tag push github action'
    if not test (git rev-parse --show-toplevel 2> /dev/null) = $PWD
        echo "you're not in repo root"
        return 1
    end
    mkdir -p ./.github/workflows &&
        cp -f ~/prog/dotfiles/defconf/gh-action-rust.yml ./.github/workflows/ci.yml &&
        sd your-project-name (basename $PWD) ./.github/workflows/ci.yml
end
funcsave rust-ci >/dev/null

function rust-bin
    if not test (git rev-parse --show-toplevel 2> /dev/null) = $PWD
        echo "you're not in repo root"
        return 1
    end
    set -l name (basename $PWD)
    cargo build -r &&
        cp -f ./target/release/$name ~/prog/binaries
    if set -q argv[1]
        set -l newVersion $argv[1]
        set -l prevdir (pwd)
        cd ~/prog/binaries
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
    touch release-notes.txt
    touch project.txt
    indeed -u .gitignore release-notes.txt project.txt
    rust-ci
    git add . &&
        git commit -m "first commit"
end
funcsave rust-init >/dev/null

#---------------------------------------------------python---------------------------------------------------

function py-project
    cd (git rev-parse --show-toplevel)
    cp -f ~/prog/dotfiles/defconf/pyproject.toml .
end
funcsave py-project >/dev/null
