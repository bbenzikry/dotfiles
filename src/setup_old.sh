#!/bin/bash
set -e

declare -r GITHUB_REPOSITORY="bbenzikry/dotfiles"

declare -r DOTFILES_ORIGIN="git@github.com:$GITHUB_REPOSITORY.git"
declare -r DOTFILES_UTILS_BASE="https://raw.githubusercontent.com/$GITHUB_REPOSITORY/master/utils"
declare -r DOTFILES_UTILS_FILES=(print packages main)
if [[ -z "$DOTFILES_DIR" ]]; then
    declare -x DOTFILES_DIR="$HOME/dotfiles"
fi
declare -x SKIPQUESTIONS=false
declare -x OS=""

# ----------------------------------------------------------------------
# | Helper Functions                                                   |
# ----------------------------------------------------------------------

download() {

    local url="$1"
    local output="$2"

    if command -v "curl" &> /dev/null; then

        curl -LsSo "$output" "$url" &> /dev/null
        #     │││└─ write output to file
        #     ││└─ show error messages
        #     │└─ don't show the progress meter
        #     └─ follow redirects

        return

    elif command -v "wget" &> /dev/null; then

        wget -qO "$output" "$url" &> /dev/null
        #     │└─ write output to file
        #     └─ don't show output

        return
    fi

    return 1

}

download_dotfiles() {


    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # local tmpFile=""
    # 
    # Old - download tarball
    # print_in_purple "\n • Download and extract archive\n\n"

    # tmpFile="$(mktemp /tmp/XXXXX)"

    # download "$DOTFILES_TARBALL_URL" "$tmpFile"
    # print_result $? "Download archive" "true"
    # printf "\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    if ! $SKIPQUESTIONS; then

        ask_for_confirmation "Do you want to store the dotfiles in '$DOTFILES_DIR'?"

        if ! answer_is_yes; then
            DOTFILES_DIR=""
            while [ -z "$DOTFILES_DIR" ]; do
                ask "Please specify another location for the dotfiles (path): "
                DOTFILES_DIR="$(get_answer)"
            done
        fi
    fi

        # check current dotfiles state
    if [[ -d "$DOTFILES_DIR" ]]; then
        if [[ ! -f "$DOTFILES_DIR/.installed" ]]; 
        then
            print_error "dotfile dir found at $DOTFILES_DIR but seems to be a custom one. Aborting"
            exit 1
        fi
    else
        print_in_purple "Cloning dotfiles repository..."
        git clone --recurse-submodules "$DOTFILES_ORIGIN" "$DOTFILES_DIR" &> /dev/null
        print_result $? "Cloning '$DOTFILES_DIR'" "true"
    fi

    cd "$DOTFILES_DIR/src" \
        || return 1

}

download_utils() {

    local tmpFile=""

    tmpFile="$(mktemp /tmp/XXXXX)"

    for file in "${DOTFILES_UTILS_FILES[@]}"
    do
        {
            download "$DOTFILES_UTILS_BASE/$file" "$tmpFile" \
            && . "$tmpFile" \
            && rm -rf "$tmpFile"
        } || return 1
    done

   return 1

}

extract() {

    local archive="$1"
    local outputDir="$2"

    if command -v "tar" &> /dev/null; then
        tar -zxf "$archive" --strip-components 1 -C "$outputDir"
        return $?
    fi

    return 1

}

verify_os() {

    declare -r MINIMUM_MACOS_VERSION="10.10"
    # declare -r MINIMUM_UBUNTU_VERSION="14.04"

    local os_name=""
    local os_version=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Check if the OS is `macOS` and
    # it's above the required version.

    os_name="$(uname -s)"

    if [ "$os_name" == "Darwin" ]; then

        os_version="$(sw_vers -productVersion)"

        if is_supported_version "$os_version" "$MINIMUM_MACOS_VERSION"; then
            return 0
        else
            printf "Sorry, this script is intended only for macOS %s+" "$MINIMUM_MACOS_VERSION"
        fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    elif [ "$os_name" == "Linux" ]; then
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        printf "Sorry, this script is intended only for macOS"
    fi
    return 1

}

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

    # Ensure that the following actions
    # are made relative to this file's path.

    cd "$(dirname "${BASH_SOURCE[0]}")" \
        || exit 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    # Load utils

    if [ -x "./utils/main.sh" ]; then
        . "./utils/main.sh" || exit 1
    else
        download_utils || exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    # Source bot helper functions

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 


    # Ensure the OS is supported and
    # it's above the required version.

    verify_os \
        || ( echo 'verify' && exit 1 )

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    skip_questions "$@" \
        && SKIPQUESTIONS=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

        # Check if this script was run directly (./<path>/setup.sh),
        # and if not, it most likely means that the dotfiles were not
        # yet set up, and they will need to be downloaded.
        printf "%s" "${BASH_SOURCE[0]}" | grep "setup.sh" &> /dev/null || download_dotfiles
        # shellcheck disable=SC2155
        export DOTFILES_DIR="$(dirname "$(pwd)")"


    # - - - - - - - - - - - Brew and brewfile init - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    
    ./homebrew.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    print_in_green "The installation process requires sudo access .. \\n"
    [[ $NO_SUDO ]] || ask_for_sudo

    # - - - - - - - - - Host file - - - - - - - - - - - - - - - - - - - - - - - - 
    
    ./hosts.sh
    
    # - - - - - - - - - initiailize GIT - - - - - - - - - - - - - - - - - - - - - 

    ./git.sh

    # - - - - - - - - - cURL/wget - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_purple "\\n   Making sure CURL and wget are installed.. \\n\\n"
    install_package curl "curl"
    install_package wget "wget"

    # - - - - - - - - - ASDF - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    ./asdf.sh

    # - - - - - - - - - Install spacemacs - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    ./spacemacs.sh

    # - - - - - - - - - - - - - - - - Zsh - - - - - - - - - - - - - - - - - - - - - 

    ./zsh.sh

    # - - - - - - - - -  - - - - - - - Local config files - - - - - - - - - - - - - - 

    print_in_purple "\\n  Creating .local config files \\n\\n"

    ./create_local_config_files.sh

    # - - - - - - - - - - - - Post installation hooks - - - - - - - - - - - - - - - - - 

    ./post/main.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    ./finish.sh

}

main "$@"