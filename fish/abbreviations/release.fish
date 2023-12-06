#!/usr/bin/env fish

abbr -a ign 'nvim .gitignore'
abbr -a rlnts 'nvim release-notes'


abbr -a rust-fmt 'cp -f ~/prog/dotfiles/rustfmt.toml ./rustfmt.toml ; cargo fmt'

abbr -a rust-ci 'mkdir -p ./.github/workflows &&
	cp -f ~/prog/dotfiles/ghactions/rust.yml ./.github/workflows/ci.yml &&
	sd your-project-name (basename $PWD) ./.github/workflows/ci.yml'