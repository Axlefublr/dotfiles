#!/usr/bin/env na

def main [section: string] {
    open ~/.local/share/harp/harp.jsonc
    | from json
    | get $section
    | transpose register command
    | compact -e command
    | update cells -c [command] { |the| $the.0 | str trim }
    | compact -e command
    | table -i false
}
