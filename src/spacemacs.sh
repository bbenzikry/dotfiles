#!/bin/bash
set -e 

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils/main.sh"

print_in_purple "Installing spacemacs"

# if [[ "$OSTYPE" = darwin* ]]; then
    if [[ ! -d "/Application/Emacs.app" ]]; then
        print_warning "Emacs.app not found. Deleting and reapplying brew symlink"

        if [[ -n "$TRAVIS" ]]; then
            print_warning "running in travis context, not building emacs."
        else
        # for ligatures and unicode
        brew tap railwaycat/emacsmacport
        brew install emacs-mac --HEAD --with-modules --force
        # link Emacs.app to application. Doesn't work well with Alfred OOTB, but finds emacs from cellar.
        ln -s "$(brew --prefix emacs-mac)/Emacs.app" "/Applications"
        fi
    fi
