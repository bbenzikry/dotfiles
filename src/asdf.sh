#!/bin/bash
set -e
cd "$(dirname "${BASH_SOURCE[0]}")" 
. "./utils/main.sh"
export ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}"
if [[ ! -d $ASDF_DIR ]]; then 
print_in_purple "Cloning asdf to $ASDF_DIR"
git clone --depth=1 https://github.com/asdf-vm/asdf.git ~/.asdf
print_in_green "Cloned ASDF\n"
fi

print_in_green "sourcing ASDF\n"
source "$ASDF_DIR/asdf.sh"
asdf plugin-add direnv

