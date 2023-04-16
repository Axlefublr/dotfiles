# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH="/mnt/c/Programming/bin:/mnt/c/Programming/shell:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="%y/%m/%d %T"

export HISTSIZE=10000
export SAVEHIST=10000

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(copypath copybuffer)

source $ZSH/oh-my-zsh.sh
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh
export FZF_DEFAULT_OPTS="--layout=default --height=100%"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"

HISTCONTROL=ignoreboth

export EDITOR='nvim'
export VISUAL='nvim'

export NVM_DIR="$HOME/.nvm"
[ -s '$NVM_DIR/nvm.sh' ] && \. '$NVM_DIR/nvm.sh'  # This loads nvm
[ -s '$NVM_DIR/bash_completion' ] && \. '$NVM_DIR/bash_completion'  # This loads nvm bash_completion

# Disable 'correct blank to blank? [nyae]'
setopt nocorrectall

bindkey -v
export KEYTIMEOUT=1

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} == '' ]] ||
        [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select

zle-line-init() {
  zle -K viins
  echo -ne '\e[5 q'
}
zle -N zle-line-init

echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

# Following code is written by Martin Frost and improved by noahdotpy: https://dev.to/frost/fish-style-abbreviations-in-zsh-40aa
# It adds abbreviations from fish into zsh

# declare a list of expandable aliases to fill up later
typeset -a ealiases
ealiases=()

# write a function for adding an alias to the list mentioned above
function abbrev-alias() {
    alias $1
    export $1
    ealiases+=(${1%%\=*})
}

# expand any aliases in the current line buffer
function expand-ealias() {
    if [[ $LBUFFER =~ "\<(${(j:|:)ealiases})\$" ]] && [[ "$LBUFFER" != "\\"* ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle magic-space
}
zle -N expand-ealias

# Bind the space key to the expand-alias function above, so that space will expand any expandable aliases
bindkey ' '        expand-ealias
bindkey -M isearch ' '      magic-space     # normal space during searches

# A function for expanding any aliases before accepting the line as is and executing the entered commanad
expand-alias-and-accept-line() {
    expand-ealias
    zle .backward-delete-char
    zle .accept-line
}
zle -N accept-line expand-alias-and-accept-line

# Aliases

unalias ll
unalias l
unalias lsa

alias grep='grep --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

abbrev-alias gh='gh.exe'
abbrev-alias dotnet='dotnet.exe'
abbrev-alias exp='explorer.exe'
abbrev-alias clip='clip.exe'
abbrev-alias code='code-insiders'

abbrev-alias bat='batcat'
abbrev-alias v='nvim'
abbrev-alias rm='rm -fr'
abbrev-alias ff='ffmpeg -i'

abbrev-alias egrep='grep -E'
abbrev-alias rgrep='grep -Ern'
abbrev-alias agrep='grep --color=always -E'
abbrev-alias argrep='grep --color=always -Ern'

abbrev-alias la='ls -A'
abbrev-alias lg='ls -g'
abbrev-alias lag='ls -Ag'
abbrev-alias lA='ls --color=always -A'
abbrev-alias lG='ls --color=always -g'
abbrev-alias lAG='ls --color=always -Ag'

abbrev-alias src='source'
abbrev-alias srcz='source ~/.zshrc'

abbrev-alias g='git'
abbrev-alias gs='git status'
abbrev-alias gl='git log'
abbrev-alias ga='git add'
abbrev-alias gaa='git add .'
abbrev-alias gm='git commit'
abbrev-alias gmp='git commit && git push'
abbrev-alias gam='git add . && git commit'
abbrev-alias gamp='git add . && git commit && git push'
abbrev-alias gp='git push'
abbrev-alias gpu='git push -u origin main'
abbrev-alias gcr='git add . && git commit -m "first commit" && git push -u origin main'
abbrev-alias gr='git reset'
abbrev-alias gst='git stash'
abbrev-alias grb='git rebase'

abbrev-alias dn='dotnet.exe'
abbrev-alias dnn='dotnet.exe new'
abbrev-alias dnnc='dotnet.exe new console -n'
abbrev-alias dnns='dotnet.exe new sln'
abbrev-alias dnng='dotnet.exe new gitignore'
abbrev-alias dns='dotnet.exe sln *.sln'
abbrev-alias dnsa='dotnet.exe sln *.sln add **/*.csproj'
abbrev-alias dnr='dotnet.exe run'
abbrev-alias dnrp='dotnet.exe run --project'
abbrev-alias dnb='dotnet.exe build'
abbrev-alias dna='dotnet.exe add'

abbrev-alias ghr='gh.exe repo'
abbrev-alias ghrc='gh.exe repo create --public'
abbrev-alias ghrcc='gh.exe repo create --clone --public'
abbrev-alias ghrd='gh.exe repo delete --confirm'

# Functions

dlist() {
    for arg in "$@"
    do
        find $arg \( -name .git -o -name .npm -o -name .vscode -o -name obj -o -name bin \) -prune -o -type d -print
    done
}

flist() {
    for arg in "$@"
    do
        find $arg \( -name .git -o -name .npm -o -name .vscode -o -name obj -o -name bin \) -prune -o -type f -print
    done
}

dpick() {
    dlist "$@" | fzf -m
}

fpick() {
    flist "$@" | fzf -m
}

_get_important_dir() {
    RBUFFER="$(dpick /mnt/c/Programming /mnt/c/Users/serge/Documents/AutoHotkey/Lib /mnt/c/Pictures /mnt/c/Audio | tr '\n' ' ')"
    zle end-of-line
}

_get_important_file() {
    RBUFFER="$(fpick /mnt/c/Programming /mnt/c/Users/serge/Documents/AutoHotkey/Lib /mnt/c/Pictures /mnt/c/Audio | tr '\n' ' ')"
    zle end-of-line
}

_get_current_dir() {
    RBUFFER="$(dpick . | tr '\n' ' ')"
    zle end-of-line
}

_get_current_file() {
    RBUFFER="$(fpick . | tr '\n' ' ')"
    zle end-of-line
}

_history_left() {
    LBUFFER="$(history | tac | awk '{print substr($0, index($0, $4))}' | sed -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf --query=$LBUFFER)"
}

_history_right() {
    RBUFFER="$(history | tac | awk '{print substr($0, index($0, $4))}' | sed -e 's/[[:space:]]*$//' | awk '!a[$0]++' | fzf)"
    zle end-of-line
}

# Hotkeys

zle -N _history_left
bindkey '^r' _history_left

zle -N _history_right
bindkey '^t' _history_right

zle -N _get_important_dir
bindkey '^g' _get_important_dir

zle -N _get_important_file
bindkey '^f' _get_important_file

zle -N _get_current_dir
bindkey '^s' _get_current_dir

zle -N _get_current_file
bindkey '^a' _get_current_file