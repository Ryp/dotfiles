source ~/.zshrc_grml

# export EDITOR="kate"
# export PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"

source $HOME/.profile
source $HOME/.aliases

alias edit_rc='$EDITOR ~/.zshrc'
alias reload='source ~/.zshrc'

autoload -U colors && colors
autoload -Uz promptinit && promptinit
prompt grml
zstyle ':prompt:grml:*:items:host' pre  "%{$fg_bold[yellow]%}"
zstyle ':prompt:grml:*:items:host' post "%{$reset_color%}"

zsh_stats () {
	fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

unsetopt prompt_cr

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

