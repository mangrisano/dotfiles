# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Michele Angrisano's Zsh configuration file. 2022

ZSH_DISABLE_COMPFIX=true

# Path of the shell
export ZSH="$HOME/.oh-my-zsh"

# Set the theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable the git plugin
plugins=(
         git
         copyfile
         web-search
        )

# Load the script in the current shell
source $ZSH/oh-my-zsh.sh

# Alias
alias tmux="tmux attach"
alias updatebrew="brew update && brew upgrade"
alias uni="~/Library/Mobile\ Documents/com~apple~CloudDocs/Università"
alias asd="~/Library/Mobile\ Documents/com~apple~CloudDocs/Università/Anno\ II/Algoritmi\ e\ Strutture\ Dati/"
alias irssi="screen -S irssi irssi"

# Setup of the global variables
export EDITOR=vim

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
