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

###############################################################################
print_in_purple "Chrome configuration"
###############################################################################

running "Disable the all too sensitive backswipe on trackpads"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

running "Disable the all too sensitive backswipe on Magic Mouse"
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false

running "Use the system-native print preview dialog"
defaults write com.google.Chrome DisablePrintPreview -bool true

running "Expand the print dialog by default"
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true