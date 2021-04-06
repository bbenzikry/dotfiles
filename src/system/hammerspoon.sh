#  _   _
# | | | | __ _ _ __ ___  _ __ ___   ___ _ __ ___ _ __   ___   ___  _ __
# | |_| |/ _` | '_ ` _ \| '_ ` _ \ / _ \ '__/ __| '_ \ / _ \ / _ \| '_ \
# |  _  | (_| | | | | | | | | | | |  __/ |  \__ \ |_) | (_) | (_) | | | |
# |_| |_|\__,_|_| |_| |_|_| |_| |_|\___|_|  |___/ .__/ \___/ \___/|_| |_|
#                                               |_|

cd "$(dirname "${BASH_SOURCE[0]}")" 
. "../utils/main.sh"

# Allow XDG file structure ( see: https://github.com/Hammerspoon/hammerspoon/pull/582)
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

