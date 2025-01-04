#!/usr/bin/env fish

pueue add -g c -- "cargo build --release ; rsync ./target/release/wks ~/prog/binaries/wks/$argv[1]"
