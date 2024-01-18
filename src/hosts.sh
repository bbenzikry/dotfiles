#!/bin/bash
set -e

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils/main.sh"

main(){
if ! $SKIPQUESTIONS; then
    ask_for_confirmation "Overwrite /etc/hosts with the ad-blocking hosts file from someonewhocares.org? (from ./config/hosts file) [y|N] " response
    if ! answer_is_yes; then
        return
    fi
fi

execute "sudo cp -f /etc/hosts /etc/hosts.backup" "Copying backup to /etc/hosts.backup"
execute "sudo cp -f ./config/hosts /etc/hosts" "Replacing with ./config/hosts"
execute "echo $(ipconfig getifaddr en0) $(hostname) | sudo tee -a /etc/hosts" "Adding local hostname to hosts"
print_in_purple "Your /etc/hosts file has been updated. Last version is saved in /etc/hosts.backup"
print_in_purple "Hostfile version was $(grep "Last updated" ./config/hosts | cut -d' ' -f2-9)"
}

main "$@"