#!/bin/bash
set -e 

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils/main.sh"

print_in_purple "Fixing zsh directory permissions"
sudo chmod g-w /usr/local/share/zsh/site-functions
sudo chmod g-w /usr/local/share/zsh

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if ! $SKIPQUESTIONS; then
    ask_for_confirmation "Do you want to install zinit?" response
    if answer_is_yes; then
        # Just in case, should be present on pull
        if [[ -d "$ZINIT_HOME" ]]; then
            print_in_green "zinit already installed"
        else
            mkdir -p "$ZINIT_HOME"
            ZINIT_MODULE_DIR="$(dirname $ZINIT_HOME)/module"
            # TODO: move to fork just in case
            git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
            git clone --depth 10 https://github.com/bbenzikry/zinit-module.git "$ZINIT_MODULE_DIR"
            pushd $PWD
            cd "$ZINIT_MODULE_DIR"
            make distclean
            CFLAGS="-Wno-implicit-function-declaration" ./configure \
                --enable-cap \
                --enable-maildir-support \
                --enable-multibyte \
                --enable-zsh-secure-free \
                --enable-unicode9 \
                --enable-etcdir=/etc \
                --with-tcsetpgrp \
                DL_EXT=so
            make
            fi
            popd
        fi
    fi
fi
