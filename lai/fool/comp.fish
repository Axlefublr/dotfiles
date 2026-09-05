#!/usr/bin/env fish

# theoretically I just slap the completion generator here and not care whether the program is still installed
# I will still have this command in the program's dode, I just also want it to be updated daily
# I'm probably not gonna bother maintaining this list: when I install something, it's now here forever, and I don't care further on
# [[sort on]]
eww shell-completions -s fish >~/.config/fish/completions/eww.fish
ewwii shell-completions -s fish >~/.config/fish/completions/ewwii.fish
kondo --completions fish >~/.config/fish/completions/kondo.fish
niri completions fish >~/.config/fish/completions/niri.fish
ov --completion fish >~/.config/fish/completions/ov.fish
qrtool --generate-completion fish >~/.config/fish/completions/qrtool.fish
rustup completions fish >~/.config/fish/completions/rustup.fish
sk --shell fish >~/.config/fish/completions/sk.fish
