#!usr/bin/env zsh
export GOPATH="$XDG_DATA_HOME/go"
# export GOROOT="$(asdf where golang )/go"

export GOOS="darwin"
export GOPROXY=direct

# gotip if available
if "$GOPATH/sdk/gotip/bin/go" version >/dev/null 2>&1; then
	export GOROOT="$GOPATH/sdk/gotip"
	# export GOTOOLDIR="$GOROOT/pkg/tool/darwin_amd64"
fi









