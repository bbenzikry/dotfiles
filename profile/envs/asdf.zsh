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

# See: https://github.com/danhper/asdf-python on why we need this
# export ASDF_PYTHON_PATCH_URL="https://github.com/python/cpython/commit/8ea6353.patch?full_index=1"
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="$ASDF_DEFAULT_PACKAGE_DIR/python"

# NOTE: python asdf may fail compilation due to clang / llvm error for undefined directives
# /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/stdio.h:220:5: error: 'TARGET_OS_IPHONE' is not defined, evaluates to 0 [-Werror,-Wundef-prefix=TARGET_OS_]
# In that case use: CFLAGS="-Wno-error=undef-prefix" asdf install python x.x.x
## Make sure you have the right SDKROOT set. We're doing that automatically as part of our profile init.

## For example, on 11.5 
# SDKROOT="$(xcrun --show-sdk-path)" CFLAGS="-Wno-error=undef-prefix" asdf install python x.x.x