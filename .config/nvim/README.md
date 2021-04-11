# Neovim configuration

## Known issues
* Colorbuddy overrides several lua globals.
  This causes the configuration for several plugins to not work as we use the ``g``
  global frequently. In order to avoid that, apply [this
  patch](/.config/bbenzikry/patches/colorbuddy.patch)
