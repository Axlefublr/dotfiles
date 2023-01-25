# Configuration
function fish_greeting
end
function fish_user_key_bindings
end
set -gx EDITOR nvim
set LSCOLORS gxfxbeaeBxxEhEhBaDaCaD
set fish_vi_force_cursor
set fish_cursor_selection_mode 'inclusive'
set fish_cursor_default 'block'
set fish_cursor_insert 'line'
set fish_cursor_replace_one 'underscore'
set fish_cursor_visual 'block'

# Autoflagging
alias egrep='grep -nE --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias fgrep='grep -nF --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias grep='grep -nE --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias ls='ls --color=auto -A'
alias l='ls --color=auto -gAh'

# Directories
set prog     '/mnt/c/Programming'
set libv2    '/mnt/c/Users/serge/Documents/AutoHotkey/Lib'
set pictures '/mnt/c/Pictures'
set csproj   '/mnt/c/Programming/csproj'
set audio    '/mnt/c/Audio'

# Programs
abbr gh     'gh.exe'
abbr dotnet 'dotnet.exe'
abbr exp    'explorer.exe'
abbr lua    'lua.exe'
abbr clip   'clip.exe'
abbr v      'nvim'

# Aliases
abbr gcr 'git add . && git commit -m \"first commit\" && git push -u origin main'
abbr gcm 'git add . && git commit && git push'
