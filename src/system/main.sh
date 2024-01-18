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

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if ! sudo grep -q "%wheel		ALL=(ALL) NOPASSWD: ALL #bbenzikry/dotfiles" "/etc/sudoers"; then

  print_in_purple "Do you want me to setup this machine to allow you to run sudo without a password?\\nPlease read here to see what I am doing:\\nhttps://summercode.com/wiki/sudo-without-a-password-in-mac-os-x \\n"

  ask_for_confirmation "Make sudo passwordless? [y|N]"

  if answer_is_yes; then
      sudo cp /etc/sudoers /etc/sudoers.back
      echo '%wheel		ALL=(ALL) NOPASSWD: ALL #bbenzikry/dotfiles' | sudo tee -a /etc/sudoers > /dev/null
      sudo dscl . append /Groups/wheel GroupMembership "$(whoami)"
      print_in_purple "You can now run sudo commands without password!"
  fi
fi

# - - - - - - - - - - - xcode - - - - - - - - - - - 
./xcode.sh

# - - - - - - - - - - - Brew - - - - - - - - - - - 

./homebrew.sh

# NOTE: removed this as we're currently on latest version with big sur. 
CURRENTSHELL=$(dscl . -read /Users/"$USER" UserShell | awk '{print $2}')
if [[ "$CURRENTSHELL" != "/opt/homebrew/bin/zsh" ]]; then
  if [[ -z "/opt/homebrew/bin/zsh" ]]; then
	print_in_yellow "Homebrew zsh not found, leaving default."
  else 
	print_in_purple "setting newer homebrew zsh (/opt/homebrew/bin/zsh) as your shell (password required)\\n"
	sudo dscl . -change /Users/"$USER" UserShell "$SHELL" /opt/homebrew/bin/zsh > /dev/null 2>&1
    ok
  fi
fi

require_brew cmake
ok

# - - - - - - - - - - - Configuration - - - - - - - - - - - 
./yabai.sh
./general.sh
./screen.sh
./input.sh
./ssd.sh
./finder.sh
# ./spotlight.sh
./security.sh
./appstore.sh
./dock.sh
./finder.sh
./mail.sh
./messages.sh
./safari.sh
./terminal.sh


for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Google Chrome Canary" \
	"Google Chrome" \
	"Mail" \
	"Messages" \
	"Opera" \
	"Photos" \
	"Safari" \
	"SystemUIServer" \
	"Terminal" \
	"iCal"; do
	killall "${app}" &> /dev/null
done
print_in_purple "Done with initial configuration. Note that some of these changes require a logout/restart to take effect."
