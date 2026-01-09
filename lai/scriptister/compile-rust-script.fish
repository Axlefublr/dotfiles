#!/usr/bin/env fish

pueue add -w ~/.cache/wks/$argv[1] -- "cargo build --release ; rsync ./target/release/wks ~/fes/eva/wks/$argv[1]"
