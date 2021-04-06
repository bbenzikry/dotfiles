#!/bin/bash
set -e 

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils/main.sh"

print_in_purple "Fixing zsh directory permissions"
sudo chmod g-w /usr/local/share/zsh/site-functions
sudo chmod g-w /usr/local/share/zsh

if ! $SKIPQUESTIONS; then
    ask_for_confirmation "Do you want to install zinit?" response
    if answer_is_yes; then
        # Just in case, should be present on pull
        if [[ -d ~/.zinit/bin ]]; then
            print_in_green "zinit already installed"
        else
            mkdir -p ~/.zinit
            git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
        fi
    fi
fi
