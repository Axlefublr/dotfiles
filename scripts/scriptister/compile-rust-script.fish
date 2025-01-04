#!/usr/bin/env fish

pueue add -g c -- 'cargo build --release'
trash-put ~/prog/binaries/wks/$argv[1]
rsync ./target/release/wks ~/prog/binaries/wks/$argv[1]
