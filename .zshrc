# Source the main configuration for zsh
source $HOME/.zshrc_grml

# Load user settings
source $HOME/.profile
source $HOME/.aliases

# Global aliases
alias -g ...=../..
alias -g ....=../../..
alias -g .....=../../../..

# Manage this file
alias edit_rc='$EDITOR ~/.zshrc'
alias reload='source ~/.zshrc'

# Setup theme
autoload -U colors && colors
autoload -Uz promptinit && promptinit
prompt grml
zstyle ':prompt:grml:*:items:host' pre  "%{$fg_bold[yellow]%}"
zstyle ':prompt:grml:*:items:host' post "%{$reset_color%}"

# Find out what commands you use the most
zsh_stats () {
    fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n20
}

# Set up history completion
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search

# Set LS_COLORS
[[ -f ~/.dircolors ]] && eval $(dircolors -b ~/.dircolors)

# colored completion - use my LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Vi mode (oh boy)
# bindkey -v
#
# bindkey '^P' up-history
# bindkey '^N' down-history
# bindkey '^?' backward-delete-char
# bindkey '^h' backward-delete-char
# bindkey '^w' backward-kill-word
# bindkey '^r' history-incremental-search-backward
#
# function zle-line-init zle-keymap-select {
#     VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
#     RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#     zle reset-prompt
# }
#
# zle -N zle-line-init
# zle -N zle-keymap-select
#
# export KEYTIMEOUT=1 # Reduce delay when pressing ESC

# Edit current line with the editor of choice
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Prevent Zsh from appending a '%' to delimit unfinished outputs
unsetopt prompt_cr

# Source local zshrc if any
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

