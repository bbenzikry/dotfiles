#  ████     ████ ██
# ░██░██   ██░██░░
# ░██░░██ ██ ░██ ██  ██████  █████
# ░██ ░░███  ░██░██ ██░░░░  ██░░░██
# ░██  ░░█   ░██░██░░█████ ░██  ░░
# ░██   ░    ░██░██ ░░░░░██░██   ██
# ░██        ░██░██ ██████ ░░█████
# ░░         ░░ ░░ ░░░░░░   ░░░░░

mkcd() {
	mkdir -p "$@"
	cd "$@" || return
}

# jq for YAML.
# [yq](https://github.com/mikefarah/yq) uses unfamiliar syntax.
# So just convert YAML to json, run jq on it, then convert back to YAML.
# Surround the jq commands in quotes for it to be treated as a single argument
jqy() {
	yq r -j "$1" \
		| jq "$2" \
		| yq - r
}


# Open man as PDF
manpdf() {
  man -t "$1" | open -f -a /Applications/Preview.app/
}


sip_partial_disable(){
# this is required if you want to use yabai fully. 
# boot to recovery mode and run it
# csrutil enable --no-internal
# csrutil enable --without kext
# csrutil enable --without fs
# csrutil enable --without debug
# csrutil enable --without dtrace
# csrutil enable --without nvram
csrutil disable --with kext --with dtrace --with nvram --with basesystem
}




