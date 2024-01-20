#!/bin/bash

#                                  ███████    ████████
#                                 ██░░░░░██  ██░░░░░░
#  ██████████   ██████    █████  ██     ░░██░██
# ░░██░░██░░██ ░░░░░░██  ██░░░██░██      ░██░█████████
#  ░██ ░██ ░██  ███████ ░██  ░░ ░██      ░██░░░░░░░░██
#  ░██ ░██ ░██ ██░░░░██ ░██   ██░░██     ██        ░██
#  ███ ░██ ░██░░████████░░█████  ░░███████   ████████
# ░░░  ░░  ░░  ░░░░░░░░  ░░░░░    ░░░░░░░   ░░░░░░░░

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils/main.sh"

###############################################################################
print_in_purple "Yabai / Window tilling"
###############################################################################

# make sure yabai is installed
install_package "koekeishiya/formulae/yabai"

# skhd as well
install_package "koekeishiya/formulae/skhd"

# hammerspoon for stackline
install_package "hammerspoon"

if ! sudo grep -q "<user> ALL = (root) NOPASSWD: $(which yabai) --load-sa" "/etc/sudoers"; then

  print_in_purple "Setup yabai?\\nThis may have security implications. Please read here to see what I am doing:\\nhttps://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release) \\n"

  ask_for_confirmation "Add sudo entry for yabai? [y|N]"

  if answer_is_yes; then
      sudo cp /etc/sudoers /etc/sudoers.back
      echo "$(whoami) ALL = (root) NOPASSWD: $(which yabai) --load-sa" | sudo tee -a /etc/sudoers > /dev/null
      print_in_purple "Done"
  fi
fi

if [[ ! -d "$XDG_CONFIG_HOME/hammerspoon/stackline" ]]; then
ask_for_confirmation "Do you want to install Stackline for yabai? [y|N]"
  if answer_is_yes; then 
    print_in_purple "Cloning stackline to hammerspoon dir"
    mkdir -p "$XDG_CONFIG_HOME/hammerspoon"
    git clone https://github.com/bbenzikry/stackline.git "$XDG_CONFIG_HOME/hammerspoon/stackline"
    print_in_green "Cloned stackline. Make sure to add stackline to your hammerspoon config."
  fi
fi


# Removed perf
# if [[ ! -d "$XDG_CONFIG_HOME/ubersicht/simple-bar" ]]; then
# ask_for_confirmation "Do you want to install simple bar with snazzy theme for Übersicht / yabai? [y|N]"
#   if answer_is_yes; then 
#     print_in_purple "Cloning simple-bar to Übersicht dir"
#     mkdir -p "$XDG_CONFIG_HOME/ubersicht"
#     git clone https://github.com/bbenzikry/simple-bar -b snazzy "$XDG_CONFIG_HOME/ubersicht/simple-bar"
#     print_in_green "Cloned simple-bar"
#   fi
# fi