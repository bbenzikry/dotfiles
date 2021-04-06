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
print_in_purple "Terminal & iTerm2"
###############################################################################

print_in_purple "Setting up iTerm"
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES_DIR/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -int 1

echo "- Linking iTerm Profiles directory"
mkdir -p "$HOME/Library/Application Support/iTerm2/"
rm -rf "$HOME/Library/Application Support/iTerm2/DynamicProfiles"

ln -sfhF "$DOTFILES_DIR/iterm2/profiles" "$HOME/Library/Application Support/iTerm2/DynamicProfiles"

running "reading iterm settings"
defaults read -app iTerm > /dev/null 2>&1;
ok