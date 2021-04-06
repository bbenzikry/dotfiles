#       ██                  ██
#      ░██                 ░██
#      ░██  ██████   █████ ░██  ██  █████  ██████
#   ██████ ██░░░░██ ██░░░██░██ ██  ██░░░██░░██░░█
#  ██░░░██░██   ░██░██  ░░ ░████  ░███████ ░██ ░
# ░██  ░██░██   ░██░██   ██░██░██ ░██░░░░  ░██
# ░░██████░░██████ ░░█████ ░██░░██░░██████░███
#  ░░░░░░  ░░░░░░   ░░░░░  ░░  ░░  ░░░░░░ ░░░

# Start and attach to a docker container
da() {
	cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

# Select a running docker container to stop
ds() {
	cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker stop "$cid"
}