#!/usr/bin/env zsh
export CARGO_BUILD_JOBS="$THREADS"
# Note that these default ones are shimmed with asdf
if command -v asdf >/dev/null 2>&1; 
then 
export CARGO_HOME=$(asdf where rust)
export RUSTUP_HOME=$(asdf where rust)
fi
