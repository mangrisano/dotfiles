# Michele Angrisano's Zsh configuration file. 2019

ZSH_DISABLE_COMPFIX=true

# Path of the shell
export ZSH="$HOME/.oh-my-zsh"

# Set the theme
ZSH_THEME="mangrisano"

# Enable the git plugin
plugins=(git)

# Load the script in the current shell
source $ZSH/oh-my-zsh.sh

# Alias
alias batt="pmset -g batt | awk '/InternalBattery/ { print \$5, \$6 }'"
alias tmux="tmux attach"
alias updatebrew="brew update && brew upgrade"
alias uni="~/Library/Mobile\ Documents/com~apple~CloudDocs/Università"
alias asd="~/Library/Mobile\ Documents/com~apple~CloudDocs/Università/Anno\ II/Algoritmi\ e\ Strutture\ Dati/"
alias irssi="screen -S irssi irssi"

# Setup of the global variables
export EDITOR=vim

# Green directory
export LSCOLORS=Cxfxcxdxbxegedabagacad

# Default terminal color scheme
export LSCOLORS=xxfxcxdxbxegedabagacad
export PATH="/usr/local/opt/python@3.10/bin:$PATH"

alias python="/usr/local/opt/python@3.10/bin/python3.10"


source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

