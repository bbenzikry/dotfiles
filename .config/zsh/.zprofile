if [ -z "$PROFILE_SET" ]; then
	# shellcheck source=.profile
	. "$HOME/exec/common/main.sh"
	. "$HOME/.profile"
	export PROFILE_SET='zprofile'
fi