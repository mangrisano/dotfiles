# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Michele Angrisano's Zsh configuration file. 2019

ZSH_DISABLE_COMPFIX=true

# Path of the shell
export ZSH="$HOME/.oh-my-zsh"

# Set the theme
ZSH_THEME="dracula"

# Enable the git plugin
plugins=(
         git
         copyfile
         web-search
         zsh-autosuggestions
         zsh-syntax-highlighting
         sudo
         zsh-ssh
        )


# Load the script in the current shell
source $ZSH/oh-my-zsh.sh

# Alias
alias antirez="cd ~/coding/antirez/"
alias batt="pmset -g batt | awk '/InternalBattery/ { print \$5, \$6 }'"
alias tm="tmux attach"
alias updatebrew="brew update && brew upgrade"

# Setup of the global variables
export EDITOR=vim

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export LC_ALL=it_IT.UTF-8
export LANG=it_IT.UTF-8
source /Users/mangrisano/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
