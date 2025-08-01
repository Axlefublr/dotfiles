#!/usr/bin/env -S nu -n --no-std-lib --stdin

# This is initially written by @Bahex, I adapted it for myself a lil bit
# Big thanks :3

# `nu-highlight` with default colors
#
# Custom themes can produce a lot more ansi color codes and make the output
# exceed discord's character limits
def nu-highlight-default [] {
    let IN = $in
    $env.config.color_config = {}
    $IN | nu-highlight
}

# Copy the current commandline, add syntax highlighting, wrap it in a
# markdown code block, copy that to the system clipboard.
#
# Perfect for sharing code snippets on discord
def main [] {
    nu-highlight-default
    | [
        '```ansi'
        $in
        '```'
    ]
    | to text
    | wl-copy -n
}
