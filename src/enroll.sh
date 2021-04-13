#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "./utils/main.sh"


ask_for_confirmation "Do you want to enroll to beta developer updates for macOS?"
if ! answer_is_yes; then
    return
fi

sudo /System/Library/PrivateFrameworks/Seeding.framework/Versions/A/Resources/seedutil enroll DeveloperSeed
print_in_green "Enrolled to dev beta updates"