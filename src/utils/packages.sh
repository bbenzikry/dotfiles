#!/usr/bin/env bash
# shellcheck disable=SC2086
# shellcheck disable=SC2216

###
# convienience methods for requiring installed software
###


require_tap() {
  brew tap "$1"
  if [[ $? != 0 ]]; then
      error "failed to tap $1! aborting..."
      # exit -1
  fi
}

# require_pin(){
#     brew tap-pin "$1"
#     if [[ $? == 0 ]]; then
#         error "failed to pin $1"
#     fi
# }

# require_docker() {

#   # TODO: support DIND via DIND flag/privileged check? 
#   if ! is_docker; then
#     docker pull "$1"
#   # TODO: Pull images via img/equivalent if in container
#   else
#     print_warning "Running inside container. Package $1 won't be installed"
#     return 1
#   fi
# }

require_brew() {
    running "brew $1"
    brew list $1 > /dev/null 2>&1 | true
    if [[ ${PIPESTATUS[0]} != 0 ]]; 
    then
        execute "brew install $1"
        if [[ $? != 0 ]]; then
            error "failed to install $1! aborting..."
            # exit -1
        fi
    else ok
    fi
}

# require_gem() {
#     running "gem $1"
#     if [[ $(gem list --local | grep "$1" | head -1 | cut -d' ' -f1) != "$1" ]];
#         then
#             action "gem install $1"
#             gem install "$1"
#     fi
#     ok
# }


require_go() {
    go get -u "$1"
}


# require_snap(){
#     declare -r PACKAGE="$1"
#     declare -r ADDITIONAL_ARGS="$3"

#     if  ! snap list | grep -q "$PACKAGE"; then
#         execute "snap install $PACKAGE $ADDITIONAL_ARGS"
#     else
#         print_success "snap package $PACKAGE is already installed"
#     fi
# }

install_package(){
# if [[ "$OSTYPE" = "linux-gnu" ]]; then
#     require_apt "$@"
# else
    require_brew "$1"
# fi
}
