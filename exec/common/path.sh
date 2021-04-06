#  ███████              ██   ██
# ░██░░░░██            ░██  ░██
# ░██   ░██  ██████   ██████░██
# ░███████  ░░░░░░██ ░░░██░ ░██████
# ░██░░░░    ███████   ░██  ░██░░░██
# ░██       ██░░░░██   ░██  ░██  ░██
# ░██      ░░████████  ░░██ ░██  ░██
# ░░        ░░░░░░░░    ░░  ░░   ░░

pathadd_head() {
	if [ -d "$1" ] && ! echo "$PATH" | grep -q "$1" >/dev/null; then
		PATH="$1${PATH:+":$PATH"}"
	fi
}
pathadd_tail() {
	if [ -d "$1" ] && ! echo "$PATH" | grep -q "$1" >/dev/null; then
		PATH="${PATH:+"$PATH:"}$1"
	fi
}
manpathadd_head() {
	if [ -d "$1" ] && ! echo "$MANPATH" | grep -q "$1" >/dev/null; then
		MANPATH="$1${MANPATH:+":$MANPATH"}"
	fi
}
manpathadd_tail() {
	if [ -d "$1" ] && ! echo "$MANPATH" | grep -q "$1" >/dev/null; then
		MANPATH="${MANPATH:+":$MANPATH"}$1"
	fi
}