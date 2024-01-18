#!/bin/bash
set -e 

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils/main.sh"

# not needed anymore
# print_in_purple "Fixing zsh directory permissions"
# sudo chmod g-w /usr/local/share/zsh/site-functions
# sudo chmod g-w /usr/local/share/zsh

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ -d "$ZINIT_HOME" ]]; then
    print_in_green "zinit already installed"
else
        ZINIT_MODULE_DIR="$(dirname $ZINIT_HOME)/module"
        git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
        git clone --depth 10 https://github.com/bbenzikry/zinit-module.git "$ZINIT_MODULE_DIR"
        pushd $PWD > /dev/null
        cd "$ZINIT_MODULE_DIR"
        [ -e Makefile ] && make distclean

        # Note: if using older zsh versions, you may need to change DL_EXt to so
        CFLAGS="-Wno-implicit-function-declaration" ./configure \
            --enable-unicode9 \
            --with-tcsetpgrp \
            --disable-gdbm DL_EXT=bundle
        make
        popd
fi