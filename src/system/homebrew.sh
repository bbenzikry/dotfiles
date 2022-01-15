#!/bin/bash
#                                  ███████    ████████
#                                 ██░░░░░██  ██░░░░░░
#  ██████████   ██████    █████  ██     ░░██░██
# ░░██░░██░░██ ░░░░░░██  ██░░░██░██      ░██░█████████
#  ░██ ░██ ░██  ███████ ░██  ░░ ░██      ░██░░░░░░░░██
#  ░██ ░██ ░██ ██░░░░██ ░██   ██░░██     ██        ░██
#  ███ ░██ ░██░░████████░░█████  ░░███████   ████████
# ░░░  ░░  ░░  ░░░░░░░░  ░░░░░    ░░░░░░░   ░░░░░░░░


cd "$(dirname "${BASH_SOURCE[0]}")" 
. "../utils/main.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

get_homebrew_git_config_file_path() {

    local path=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if path="$(brew --repository 2> /dev/null)/.git/config"; then
        printf "%s" "$path"
        return 0
    else
        print_error "Homebrew (get config file path)"
        return 1
    fi

}

install_homebrew() {

    if ! cmd_exists "brew"; then
        printf "\n" | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null
        #  └─ simulate the ENTER keypress
    fi
    print_result $? "Homebrew"
}


install_brew_packages() {
    # Uses XDG in the same spot where homebrew-file uses by default
    # this assumes the file exists in the repo
    print_in_purple "Updating from brewfile $XDG_CONFIG_HOME/brewfile/Brewfile"
    brew bundle --file="$XDG_CONFIG_HOME/brewfile/Brewfile"
}


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n   Homebrew\n\n"

    install_homebrew
    execute "brew update" "Brew update"
    execute "brew upgrade" "Brew upgrade"
    install_brew_packages

    # Make sure we have the /usr/local/bin version of zsh for later definition.
    install_package "zsh"
}

main


