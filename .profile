#█▓▒░ set initial dotfile dir
if [ -z "$PROFILE_SET" ]; then
	# shellcheck source=startup.sh
	# Load common extensions
	. "$HOME/exec/common/main.sh"
	. "$HOME/profile/start.zsh"
	export PROFILE_SET='profile'
fi