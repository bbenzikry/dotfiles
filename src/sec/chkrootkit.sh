#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")"
. "./utils/main.sh"

RKHUNTER_LOG="/var/log/rkhunter.log"
CHKROOTKIT_LOG="/var/log/chkrootkit.log"

###############################################################################
print_in_purple "Installing chkrootkit and rkhunter..."
###############################################################################

install_package "chkrootkit" "chkrootkit"
install_package "rkhunter" "rkhunter"
install_package "clamav" "clamav"

sudo rm -f "$CHKROOTKIT_LOG" "$RKHUNTER_LOG"

print_in_purple "\\n\\n  Updating rkhunter  \\n\\n"
sudo rkhunter --update
print_in_purple "\\n  Running rkhunter"
sudo rkhunter --check --sk --quiet
# shellcheck disable=SC2181
[[ "$?" -gt 0 ]] && print_in_red "\\n rkhunter found issues. Please look at $RKHUNTER_LOG"

print_in_purple "\\n\\n  Running chkrootkit  \\n\\n"
sudo bash -c "chkrootkit  &> $CHKROOTKIT_LOG"
if grep "INFECTED" "$CHKROOTKIT_LOG"; then
print_in_red "Issues occurred during chkrootkit run. "
print_in_red "\\n$(grep INFECTED $CHKROOTKIT_LOG) \\n"
print_in_yellow " NOTE that this could be a false positive."
print_in_yellow "\\n See more info @ $CHKROOTKIT_LOG"
fi
