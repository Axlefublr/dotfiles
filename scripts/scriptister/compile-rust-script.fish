#!/usr/bin/env fish

cargo build --release
and rsync ./target/release/wks ~/prog/binaries/wks/$argv[1]
read -P 'press enter to continue' -ln1 the
