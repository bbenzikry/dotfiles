#  ███████                    ████ ██  ██
# ░██░░░░██                  ░██░ ░░  ░██
# ░██   ░██ ██████  ██████  ██████ ██ ░██  █████
# ░███████ ░░██░░█ ██░░░░██░░░██░ ░██ ░██ ██░░░██
# ░██░░░░   ░██ ░ ░██   ░██  ░██  ░██ ░██░███████
# ░██       ░██   ░██   ░██  ░██  ░██ ░██░██░░░░
# ░██      ░███   ░░██████   ░██  ░██ ███░░██████
# ░░       ░░░     ░░░░░░    ░░   ░░ ░░░  ░░░░░░


## Don’t clear the screen 
export MANPAGER='less -X';
export PAGER='less -X';

## Avoid issues with `gpg` as installed via Homebrew.
export GPG_TTY=$(tty);

#█▓▒░ editor
export EDITOR="nvim"
export VISUAL="code-insiders -w"
export DISABLE_MAGIC_FUNCTIONS=true

#█▓▒░ debugging
export DEBUGGER=gdb

#█▓▒░ language
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LESSCHARSET=utf-8

# Important part of dotfiles here, add red dwarf insults to bash insults, you smeghead.
# Remove this to get vanilla insults
IFS=$'\n' read -d '' -r -A CMD_NOT_FOUND_MSGS < "$XDG_CONFIG_HOME/bbenzikry/resources/text/insults"
