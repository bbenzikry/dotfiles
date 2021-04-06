cargo_git() {
	cargo +nightly install --git "$@" --force -Z unstable-options
}
cargo_git_all_features() {
	cargo_git "$@" --all-features
}

cargo_build_ghq(){
    ghq get $0
    cargo build --manifest-path $0 "${@:2}"
}