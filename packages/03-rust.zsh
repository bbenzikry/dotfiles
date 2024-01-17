# #!/usr/bin/env zsh
# export CC=clang
# export CXX=clang++
# export CFLAGS="$CLANGFLAGS"
# export CXXFLAGS="$CLANGFLAGS"
# export LDFLAGS="$CFLAGS" CXXFLAGS="$CFLAGS" CPPFLAGS="$CFLAGS"

# export RUSTFLAGS="$RUSTFLAGS \
# 	-L. \
# 	-C linker-plugin-lto \
# 	-C linker=clang \
# 	-C link-arg=-fuse-ld=lld \
# 	-C link-args=-s"

# export RUSTFLAGS_STATIC_LTO="$RUSTFLAGS \
# 	-L. \
# 	-C linker-plugin-lto \
# 	-C linker=clang \
# 	-C link-arg=-fuse-ld=lld \
# 	-C target-feature=+crt-static \
# 	-C lto=fat"

# TODO: move this to different loc
# rustup default nightly
# rustup update
# cargo install cargo-update
# cargo_build_ghq https://github.com/nushell/nushell --workspace --features=extra
