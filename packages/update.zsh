#!/usr/bin/env zsh 

#  ██     ██ ███████  ███████       ██     ██████████ ████████
# ░██    ░██░██░░░░██░██░░░░██     ████   ░░░░░██░░░ ░██░░░░░
# ░██    ░██░██   ░██░██    ░██   ██░░██      ░██    ░██
# ░██    ░██░███████ ░██    ░██  ██  ░░██     ░██    ░███████
# ░██    ░██░██░░░░  ░██    ░██ ██████████    ░██    ░██░░░░
# ░██    ░██░██      ░██    ██ ░██░░░░░░██    ░██    ░██
# ░░███████ ░██      ░███████  ░██     ░██    ░██    ░████████
#  ░░░░░░░  ░░       ░░░░░░░   ░░      ░░     ░░     ░░░░░░░░


CURDIR=${0:a:h}

# update brew
brew update && brew upgrade && brew upgrade --cask

# update asdf
asdf update

# Update asdf global versions 
./CURDIR/00-asdf.zsh force

# update zinit
zinit self-update 

# update zinit packages
zinit update --parallel # Update zinit plugins/snippets in parallel

# clear cargo cache
if command -v cargo 2>&1; then 
cargo cache -e
fi

# Update yarn global packages
yarn global upgrade

# Update pipx packages
# TODO pipx update
wait