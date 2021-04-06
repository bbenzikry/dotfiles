ghq_cd() {
	if [ -z "$GHQ_ROOT" ]; then
		GHQ_ROOT=$(ghq root)
	fi
	trimmed_url=$(trim-git-url "$1")
	if [ -d "${GHQ_ROOT}/$trimmed_url" ]; then
		cd "${GHQ_ROOT}/$trimmed_url" \
			&& git stash \
			&& git reset --hard origin/HEAD
	fi
	ghq get -u "$1" \
		&& cd "${GHQ_ROOT}/$trimmed_url" \
		&& git pull \
		&& git submodule update --init --recursive --remote
}

cdg() {
	# cd to a git repo managed by ghq
	if [ -z "$1" ]; then
		cdto=$(ghq list | fzf)
	else
		cdto=$(ghq list | fzf -q "$@")
	fi
	# shellcheck disable=SC2154
	[ "$cdto" = '' ] || cd "$GHQ_ROOT/$cdto" || return 1
}