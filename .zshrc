# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "hlissner/zsh-autopair"
plug "MAHcodes/distro-prompt"
plug "zap-zsh/sudo"
plug "ohmyzsh/plugins/copyfile"

# Load and initialise completion system
autoload -Uz compinit
compinit

# Alias
alias fgate="~/Bit4id/4Gate/"
alias cms="~/Bit4id/4Gate/4gate-src/SafeAccess/bit4id-safeaccess-cms"
alias bit="~/Bit4id/"
alias tm="tmux attach -t 0"
alias parser="~/Bit4id/Sources/ParserExcel/parserexcel/parserexcel"
alias boarding="~/Bit4id/Sources/Boarding/boarding_main"
alias offers="~/Bit4id/Sources/OffersPlatform"
alias stuff="~/Bit4id/Sources/Stuff"
