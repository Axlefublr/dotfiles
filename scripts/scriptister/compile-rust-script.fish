#!/usr/bin/env fish

pueue add -w ~/.cache/wks/$argv[1] -g c -- "cargo build --release ; rsync ./target/release/wks ~/r/binaries/wks/$argv[1]"
