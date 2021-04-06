
#    ████████  ██   ██   ██      ██         ██
#   ██░░░░░░██░░   ░██  ░██     ░██        ░██
#  ██      ░░  ██ ██████░██     ░██ ██   ██░██
# ░██         ░██░░░██░ ░██████████░██  ░██░██████
# ░██    █████░██  ░██  ░██░░░░░░██░██  ░██░██░░░██
# ░░██  ░░░░██░██  ░██  ░██     ░██░██  ░██░██  ░██
#  ░░████████ ░██  ░░██ ░██     ░██░░██████░██████
#   ░░░░░░░░  ░░    ░░  ░░      ░░  ░░░░░░ ░░░░░
  
_ghsearch_url() {
	formatstr=$(echo "$*" | tr ' ' '+')
	printf 'https://github.com/search?q=%s&type=Repositories' "$formatstr"
}


_ghsearch_starred_url() {
	baseurl=$(_ghsearch_url "$*")
	echo "${baseurl}&o=desc&s=starred"
}

gitsearch() {
	$BROWSER "$(_ghsearch_url "$*")"
}

gitssearch() {
	$BROWSER "$(_ghsearch_starred_url "$*")"
}
