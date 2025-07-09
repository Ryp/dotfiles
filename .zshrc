# Profiling
ZSH_PROFILE_RC=1 # Set so that GRML doesn't fail
# Uncomment to profile zsh startup
#zmodload zsh/zprof

# Be very pedantic about undefined variables
set -u

export SHELL_RC_FILE=$HOME/.zshrc

# Source the main configuration for zsh
source $HOME/.zshrc_grml
unset EDITOR # GRML sets it, but we're setting it later on

# Setup theme
autoload -U colors && colors
autoload -U bashcompinit && bashcompinit
autoload -Uz promptinit && promptinit

prompt grml

zstyle ':prompt:grml:left:setup' items rc change-root user at host path vcs percent
zstyle ':prompt:grml:right:setup' items

zstyle ':prompt:grml:left:items:percent' token '$ '

zstyle ':prompt:grml:left:items:path' pre '%F{blue}'
zstyle ':prompt:grml:left:items:path' post "%{$reset_color%}"

# Set LS_COLORS
if [ -f ~/.dircolors ]; then
    eval $(dircolors -b ~/.dircolors)
fi

# colored completion - use my LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

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

function ranger-cd {
    local tmpfile="$(mktemp)"
    ranger --choosedir=$tmpfile $argv
    local rangerpwd=`cat $tmpfile`
    if [ "$PWD" != $rangerpwd ]; then
        cd $rangerpwd
    fi
}

# Global aliases
alias -g ...=../..
alias -g ....=../../..
alias -g .....=../../../..

# Source local zshrc if any
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi

source ~/.shrc

# Uncomment to profile zsh startup
#zprof
