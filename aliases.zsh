# Programs
alias gh="gh.exe"
alias dotnet="dotnet.exe"
alias exp="explorer.exe"
alias lua="lua.exe"
alias ffmpeg="ffmpeg.exe"
alias v="nvim"

# Commands
alias prog="cd /mnt/c/Programming"
alias libv2="cd /mnt/c/Users/serge/Documents/AutoHotkey/Lib"
alias del="rm -rf"

# Aliases
alias gitcreate="git add . && git commit -m \"first commit\" && git push -u origin main"

importDotfiles() {
   cp /mnt/c/Programming/dotfiles/aliases.zsh $ZSH/custom/aliases.zsh
   cp /mnt/c/Programming/dotfiles/init.lua ~/.config/nvim/init.lua
}

# Files
alias m="importDotfiles && nvim ~/.config/nvim/init.lua"
alias alis="importDotfiles && nvim $ZSH/custom/aliases.zsh"
alias zshConf="nvim ~/.zshrc"
alias p10kConf="nvim ~/.p10k.zsh"
