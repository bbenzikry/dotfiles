#  ██████████ ██
# ░░░░░██░░░ ░██
#     ░██    ░██       █████  ██████████   █████
#     ░██    ░██████  ██░░░██░░██░░██░░██ ██░░░██
#     ░██    ░██░░░██░███████ ░██ ░██ ░██░███████
#     ░██    ░██  ░██░██░░░░  ░██ ░██ ░██░██░░░░
#     ░██    ░██  ░██░░██████ ███ ░██ ░██░░██████
#     ░░     ░░   ░░  ░░░░░░ ░░░  ░░  ░░  ░░░░░░

export BAT_THEME="Sublime Snazzy"
# Add LS_COLORS snazzy theme
if (($+commands[vivid])); then
# TODO: handle light mode for LS colors
export LS_COLORS="$(vivid generate snazzy)"
export EZA_COLORS="$(vivid generate snazzy)"
fi

# fzf
FZF_THEME_CONFIG="$XDG_CONFIG_HOME/bbenzikry/resources/theme/fzf/snazzy.config"
[[ -e "$FZF_THEME_CONFIG" ]] && source "$FZF_THEME_CONFIG"