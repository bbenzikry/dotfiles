# Window management aliases

# Toggle window state
alias yabais="yabai -m window --toggle split"

# yabai quick reset - this is faster than brew services
function yabaireset {
    launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"
}
function yabaiwindow {
    yabai -m query --windows | jq 'map(select(.app =="'"$1"'").title)'
}
