#                         ██   ████
#                        ░██  ░██░
#   ██████    ██████     ░██ ██████
#  ░░░░░░██  ██░░░░   ██████░░░██░
#   ███████ ░░█████  ██░░░██  ░██
#  ██░░░░██  ░░░░░██░██  ░██  ░██
# ░░████████ ██████ ░░██████  ░██
#  ░░░░░░░░ ░░░░░░   ░░░░░░   ░░

# See: https://github.com/asdf-vm/asdf/issues/687
export ASDF_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/asdf"
export ASDF_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME./config}/asdf"
export ASDF_CONFIG_FILE="$ASDF_CONFIG_HOME/asdfrc"
export ASDF_DEFAULT_PACKAGE_DIR="$ASDF_CONFIG_HOME/defaults"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/tool-versions"
export ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="$ASDF_DEFAULT_PACKAGE_DIR/node"