#!/usr/bin/env zsh

#  ███████                    ████ ██  ██
# ░██░░░░██                  ░██░ ░░  ░██
# ░██   ░██ ██████  ██████  ██████ ██ ░██  █████
# ░███████ ░░██░░█ ██░░░░██░░░██░ ░██ ░██ ██░░░██
# ░██░░░░   ░██ ░ ░██   ░██  ░██  ░██ ░██░███████
# ░██       ░██   ░██   ░██  ░██  ░██ ░██░██░░░░
# ░██      ░███   ░░██████   ░██  ░██ ███░░██████
# ░░       ░░░     ░░░░░░    ░░   ░░ ░░░  ░░░░░░

CURDIR=$(dirname $0)

## Starts profile assignemnts. 
# Note that while this uses zsh, in contrast to .zshenv, this is supposed to run well on other shells
# Don't run again.
if [ -n "$PROFILE_SET" ]; then
	exit
fi


# We start with ASDF for all downstream tasks.
. $CURDIR/envs/asdf.zsh
if ! command -v asdf >/dev/null 2>&1; 
then 
    export PATH="$PATH:$ASDF_DIR/bin"
    . $ASDF_DIR/lib/asdf.sh
fi

export CODE_ROOT="$HOME/code"
export EXEC_DIR="$HOME/exec"
export INSIDERS_DIR="$XDG_CONFIG_HOME/code-insiders"
CURDIR="$(dirname $0)"
# # Load profiles.
for profile ($CURDIR/[0-9][0-9]*) source $profile


# Load environments, remember to base them on XDG
environments=("brew" "tmux" "docker" "ruby" "ghq" "c" "haskell" "go" "rust" "java" "scala" \
"clojure" "scala" "spark" "python" "node" "perl" "wasm" "nnn" "general" "wakatime" "android" "aws" "nvim" "dotnet")

for env in $environments; do
    . "$CURDIR/envs/$env.zsh"
done

. "$EXEC_DIR/common/main.sh"
. "$CURDIR/path.zsh"