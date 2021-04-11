# Macos dotfiles
```

      ██            ██     ████ ██  ██
     ░██           ░██    ░██░ ░░  ░██
     ░██  ██████  ██████ ██████ ██ ░██  █████   ██████
  ██████ ██░░░░██░░░██░ ░░░██░ ░██ ░██ ██░░░██ ██░░░░
 ██░░░██░██   ░██  ░██    ░██  ░██ ░██░███████░░█████
░██  ░██░██   ░██  ░██    ░██  ░██ ░██░██░░░░  ░░░░░██
░░██████░░██████   ░░██   ░██  ░██ ███░░██████ ██████
 ░░░░░░  ░░░░░░     ░░    ░░   ░░ ░░░  ░░░░░░ ░░░░░░

```

**Table of Contents**

- [Basic features](#basic-features)
- [Usage](#usage)
- [(☞ ͡° ͜ʖ ͡°)☞ Get in touch](#%E2%98%9E-%CD%A1%C2%B0-%CD%9C%CA%96-%CD%A1%C2%B0%E2%98%9E-get-in-touch)
- [Screenshots](#screenshots)
- [Basis and recognition](#basis-and-recognition)
- [Notes](#notes)

## Basic features
* Designed for polyglot work ( mostly Go, Clojure, Python, Scala, Node/React/GraphQL, Rust )
* Snazzy-esque theme in simple-bar / vscode / nvim / tmux / Terminal / iTerm / Alfred
* Neovim color scheme: [snazzybuddy.nvim](https://github.com/bbenzikry/snazzybuddy.nvim)
* [brew formulas](./.config/brewfile/Brewfile)
* [vscode-insiders extensions](./.config/code-insiders/Codefile)
* Removes all kinds of [telemtry](./profile/01-telemetry.zsh) by default
* zsh with [zinit](https://github.com/zdharma/zinit) for loading plugins with async goodness
* ``$EDITOR`` is [neovim](https://neovim.io)
* ``$VISUAL`` is vscode insiders
* [Alfred](https://www.alfredapp.com)
* [iTerm2](https://iterm2.com) with [FiraCode nerd font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode) and selected color schemes
* tmux
* [fzf](https://github.com/junegunn/fzf) for all kinds of fuzzy fun
<!-- * [mcfly](https://github.com/cantino/mcfly) for smarter history search -->
* [Starship prompt](https://starship.rs)
* [yabai](https://github.com/koekeishiya/yabai) as a tiling manager
* [Übersicht](http://tracesof.net/uebersicht/) for desktop widgets
* [stackline](https://github.com/AdamWagner/stackline) for yabai stack management
* [simple-bar](https://github.com/Jean-Tinland/simple-bar)
* [Neofetch](https://github.com/dylanaraps/neofetch) for MOTD
* [Onefetch](https://github.com/o2sh/onefetch) for project MOTD
* [GHQ](https://github.com/x-motemen/ghq) for select repos
* [nnn](https://github.com/jarun/nnn) for file browsing
* [asdf](https://asdf-vm.com/) for most used languages
* Mostly complies with [XDG structure](https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html)

Notes:
* ASDF dir is still at $HOME and default-* dotfiles are not customizable ( see: https://github.com/asdf-vm/asdf/issues/687)
* .zshenv is still at $HOME, other zsh files are at $XDG_CONFIG_HOME/zsh
* Neovim configuration is fully based on lua. I'm considering adding Fennel for expirementation and usability. 

> [Sourcehut mirror](https://git.sr.ht/~bbenzikry/dotfiles)

Also spits out red dwarf themed insults when typing the wrong command
![insult-1](https://user-images.githubusercontent.com/1993348/110026305-27d7e400-7d39-11eb-9a27-2f9259842374.png)

## Usage
```bash
git clone --bare https://github.com/bbenzikry/dotfiles ~/dotfiles
# alias is provided by default after reload
alias dotfiles="GIT_WORK_TREE=~ GIT_DIR=~/dotfiles"
dotfiles checkout

# Bootstrapping
<<c
Same as make install.
Interactive installation, will install brew packages and configure macos defaults.
Will ask for sudo.
c
./src/setup.sh 

# After initial setup
task install-packages # Installs ASDF global languages, python global tooling ( via pipx ) and vscode extensions.
```

## (☞ ͡° ͜ʖ ͡°)☞ Get in touch

[![@bbenzikry](https://img.shields.io/twitter/follow/bbenzikry.svg?style=social&label=@bbenzikry)](https://twitter.com/bbenzikry)

[![keybase](https://badgen.net/keybase/pgp/beni)](https://keybase.io/beni)


# Screenshots
![image](https://user-images.githubusercontent.com/1993348/113521692-cdce7680-95a3-11eb-85ed-396b85725a28.png)



## Basis and recognition
- [atomantic](https://github.com/atomantic/dotfiles)
- [mathiasbynens](https://github.com/mathiasbynens/dotfiles)
- [jessfraz](https://github.com/jessfraz/dotfiles)
- [alrra](https://github.com/alrra/dotfiles)
- [drewolson](https://github.com/drewolson/vim_dotfiles)
- [junegunn](https://github.com/junegunn/dotfiles)
- [christoomey](https://github.com/christoomey/dotfiles)
- [paulirish](https://github.com/paulirish/dotfiles)
- [xero](https://github.com/xero/dotfiles)
- [NICHOLAS85](https://github.com/NICHOLAS85/dotfiles/)


## Notes
* default packages for rust, dotnet and go are pending PRs to individual asdf repos
* any ASCII art used is probably generated with figlet
* If you experience slow prompt load and keep settings related to asdf and java, precmd hooks used in the asdf java plugin are the culprit. you can remove the precmd or comment it out ( probably at ``~/.local/share/asdf/plugins/java/set-java-home.zsh``)
