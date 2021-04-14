
# Enable aliases to be sudo’ed
alias sudo='sudo '

# debugging aliases
for aliasfile ($ZDOTDIR/loaders/aliases/*.zsh) source $aliasfile

LOCAL_ALIASES="$XDG_CONFIG_HOME/zsh/loaders/local/alias.zsh"
if [[ -e "$LOCAL_ALIASES" ]]; then
    source "$LOCAL_ALIASES"
fi





