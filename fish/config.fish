#!/usr/bin/env fish

set -gx BROWSER '/usr/bin/vivaldi'

zoxide init fish | source
for file in ~/prog/dotfiles/fish/abbreviations/*.fish
	source $file
end

bind -M default daw forward-single-char forward-single-char backward-word kill-word delete-char
bind -M default daW forward-single-char forward-single-char backward-bigword kill-bigword delete-char

bind -M default -m insert caw forward-single-char forward-single-char backward-word kill-word delete-char repaint-mode
bind -M default -m insert caW forward-single-char forward-single-char backward-bigword kill-bigword delete-char repaint-mode

bind -M default X delete-char forward-single-char backward-char
bind -M default x begin-selection kill-selection end-selection repaint-mode

bind -M default -m insert cie 'commandline ""'
bind -M default die 'commandline ""'
bind -M default yie 'commandline | xclip -r -selection clipboard'

bind -M insert \c] execute
bind -M default K execute

bind -M default v edit_commandline
bind -M default : repeat-jump-reverse
bind -M default \; repeat-jump

bind -M insert -k f2 expand-abbr insert-line-under
bind -M insert -k f4 'commandline ""'

bind -M insert \ed clear-screen repaint
bind -M default \ed clear-screen
bind -M insert \ep 'commandline -i (pwd | string replace -r $HOME \'~\')'
bind -M insert \eu list_current_token
bind -M insert -k f5 forward-word
bind -M insert \e\; accept-autosuggestion
bind -M default -k f5 forward-word
bind -M default \e\; accept-autosuggestion