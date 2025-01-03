#!/usr/bin/env fish

cargo build --release
read -P 'press enter to continue' -ln1 the
rsync ./target/release/wks ~/prog/binaries/wks/$argv[1]
