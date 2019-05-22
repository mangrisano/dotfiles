# Path of the shell
export ZSH="/Users/darksun/.oh-my-zsh"

# Set the theme
ZSH_THEME="garyblessington"

# Enable the git plugin
plugins=(git)

# Load the script in the current shell
source $ZSH/oh-my-zsh.sh

# Alias
alias batt="pmset -g batt | awk '/InternalBattery/ { print \$5, \$6 }'"

# Setup of the global variables
export EDITOR=vim
export LSCOLORS=Cxfxcxdxbxegedabagacad
