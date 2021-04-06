go_update() {
	echo "Updating $*"
	cd "$GOPATH/src/$1" && git reset --hard HEAD && git clean -fx && cd - || echo "$1 doesn't seem to be installed yet."
	go get -u -v "$*" 2>&1 # verbose output is sent to stderr
}
go_update_static() {
	# shellcheck disable=SC2034 # CGO_ENABLED is in fact used by cmd/go.
	CGO_ENABLED=0 GOFLAGS="$GOFLAGS -buildmode=pie -tags=osusergo,netgo,static_build" go_update "$*"
}