# Neovim configuration

## Language servers
Language servers for nvim are spaghetti installed, mostly because of different ways they are distributed.

* Some are installed via brew ( for example, ``terraform-ls`` )
* Some are installed via [relevant package managers](/.config/asdf/defaults)
* Some are installed manually ( for package managers that are not a part of ASDF - for example, teal language server via luarocks )
* GH Releases (binary release / source compiled ) that are not available via brew and package managers are installed using [zinit](/.config/zsh/loaders/03-programs.zsh)


> Language servers used in vscode have their own .vsix and are installed normally.


## Debugging
Individual language debugging is managed via [nvim-dap configurations](/.config/nvim/lua/config/plugins/dap/debuggers)

## Known issues
* Colorbuddy overrides several lua globals.
  This causes the configuration for several plugins to not work as we use the ``g``
  global frequently. In order to avoid that, apply [this
  patch](/.config/bbenzikry/patches/colorbuddy.patch)
