#!/usr/bin/env fish

cp -f config.toml wrap-off.toml
# yes, really
sd "editor\\.whitespace\\.render]\\nnewline = 'all'" "editor.whitespace.render]\nnewline = 'none'" wrap-off.toml
sd 'editor\\.soft-wrap]\\nenable = true' 'editor.soft-wrap]\nenable = false' wrap-off.toml
