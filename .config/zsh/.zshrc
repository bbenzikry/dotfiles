# autoload -U add-zsh-hook
# # Onefetch for git repos


# reload the zsh session. From OMZ:plugins/zsh_reload
zreload() {
	local cache="$ZSH_CACHE_DIR"
	autoload -U compinit zrecompile
	compinit -i -d "$cache/zcomp-$HOST"

	for f in ${ZDOTDIR:-~}/.zshrc "$cache/zcomp-$HOST"; do
		zrecompile -p $f && command rm -f $f.zwc.old
	done

	# Use $SHELL if available; remove leading dash if login shell
	[[ -n "$SHELL" ]] && exec ${SHELL#-} || exec zsh
}

if [ -z "$PROFILE_SET" ]; then
	. "$HOME/exec/common/main.sh"
	. "$HOME/.profile"
	export PROFILE_SET='zshrc'
fi

# Start zsh load
for config ($ZDOTDIR/loaders/*.zsh) source $config
