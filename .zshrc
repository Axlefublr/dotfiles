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
plugins=(zsh-autosuggestions copypath copybuffer)

source $ZSH/oh-my-zsh.sh

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

prog='/mnt/c/Programming'
libv2='/mnt/c/Users/serge/Documents/AutoHotkey/Lib'
pictures='/mnt/c/Pictures'
csproj='/mnt/c/Programming/csproj'
audio='/mnt/c/Audio'

abbrev-alias prog='/mnt/c/Programming'
abbrev-alias libv2='/mnt/c/Users/serge/Documents/AutoHotkey/Lib'
abbrev-alias pictures='/mnt/c/Pictures'
abbrev-alias csproj='/mnt/c/Programming/csproj'
abbrev-alias audio='/mnt/c/Audio'

abbrev-alias gh='gh.exe'
abbrev-alias dotnet='dotnet.exe'
abbrev-alias exp='explorer.exe'
abbrev-alias lua='lua.exe'
abbrev-alias clip='clip.exe'

abbrev-alias bat='batcat'
abbrev-alias v='nvim'
abbrev-alias rm='rm -fr'
abbrev-alias hst='history | sort --reverse | less'

abbrev-alias egrep='grep --color=auto -E'
abbrev-alias rgrep='grep --color=auto -Ern'
abbrev-alias agrep='grep --color=always -E'
abbrev-alias argrep='grep --color=always -Ern'

abbrev-alias ls='ls --color=auto -A'
abbrev-alias la='ls --color=auto -gAh'

abbrev-alias src='source'
abbrev-alias srcz='source ~/.zshrc'

abbrev-alias ffind='find -type f -name'
abbrev-alias dfind='find -type d -name'
abbrev-alias nfind='find -name'

abbrev-alias g='git'
abbrev-alias gs='git status'
abbrev-alias gl='git log'
abbrev-alias ga='git add'
abbrev-alias gaa='git add .'
abbrev-alias gcm='git commit'
abbrev-alias gacm='git add . && git commit'
abbrev-alias gcmm='git commit -m "'
abbrev-alias gcmp='git add . && git commit && git push'
abbrev-alias gp='git push'
abbrev-alias gpu='git push -u origin main'
abbrev-alias gcr='git add . && git commit -m "first commit" && git push -u origin main'

abbrev-alias dn='dotnet.exe'
abbrev-alias dnn='dotnet.exe new'
abbrev-alias dnnc='dotnet.exe new console -n'
abbrev-alias dnns='dotnet.exe new sln -n'
abbrev-alias dnng='dotnet.exe new gitignore'
abbrev-alias dns='dotnet.exe sln'
abbrev-alias dnsa='dotnet.exe sln *.sln add **/*.csproj'
abbrev-alias dnr='dotnet.exe run'
abbrev-alias dnrp='dotnet.exe run --project'
abbrev-alias dna='dotnet.exe add'

abbrev-alias ghr='gh.exe repo'
abbrev-alias ghrc='gh.exe repo create --public'
abbrev-alias ghrcc='gh.exe repo create --clone --public'

# Functions

# Instead of searching through history, pass a command name to viewcmd to see all the last times
# you've used that command
# Will display history of the command being used in your preferred PAGER (is "less" by default),
# starting with the most recent use of the command at the top
# You can omit extensions of the command if they have them.
# So, "dotnet" will also match "dotnet.exe"
# But "dotnet.exe" will only match "dotnet.exe", and won't match "dotnet"
# Applies to any file extension
# Only the first command name passed will be considered, any argument after is ignored
# Try this out with "viewcmd echo"
viewcmd() {
    history | command grep --color=always -E "[ *] $1(\.\w+)? " | tac | $PAGER
}