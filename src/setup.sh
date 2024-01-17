#!/bin/bash
set -e

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


    # set basic xdg environment
    export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
    export XDG_RUNTIME_DIR="/tmp"
    export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"


    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    # shellcheck disable=SC2034
    skip_questions "$@" \
        && SKIPQUESTIONS=true


    print_in_green "The installation process requires sudo access .. \\n"
    [[ $NO_SUDO ]] || ask_for_sudo


    # - - - - - - - - - - - System and brew configuration - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    ./system/main.sh

    # - - - - - - - - - Host file - - - - - - - - - - - - - - - - - - - - - - - - 
    
    ./hosts.sh
    
    # - - - - - - - - - cURL/wget - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_purple "\\n   Making sure CURL and wget are installed.. \\n\\n"
    install_package curl "curl"
    install_package wget "wget"

    # - - - - - - - - - ASDF - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

    ./asdf.sh

    # - - - - - - - - - Install spacemacs - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    # ./spacemacs.sh

    # - - - - - - - - - - - - - - - - Zsh - - - - - - - - - - - - - - - - - - - - - 

    ./zsh.sh

    # - - - - - - - - -  - - - - - - - Local config files - - - - - - - - - - - - - - 

    print_in_purple "\\n  Creating .local config files \\n\\n"

    ./create_local_config_files.sh

    # - - - - - - - - - - - - Post installation hooks - - - - - - - - - - - - - - - - - 

    # ./post/main.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
    ./finish.sh

}

main "$@"