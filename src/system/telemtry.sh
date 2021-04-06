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

running "Disable firefox telemetry"
defaults write /Library/Preferences/org.mozilla.firefox DisableTelemetry -bool TRUE

# https://docs.microsoft.com/en-us/deployoffice/privacy/overview-privacy-controls#diagnostic-data-sent-from-microsoft-365-apps-for-enterprise-to-microsoftd
running "Disable office diagnostic data"
write com.microsoft.office DiagnosticDataTypePreference -string ZeroDiagnosticData