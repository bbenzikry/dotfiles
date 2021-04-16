#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░



#█▓▒░ Shut everything up until we're done
stty -echo

#█▓▒░ For profiling

if [[ ! -z $ZPROF ]]; then
zmodload zsh/zprof
fi

if [[ ! -z $ZINIT_DEBUGGING ]]; then
typeset -g ZPLG_MOD_DEBUG=1
fi

#█▓▒░ Emacs bindings for the terminal itself (can't live without ^A/^E in term)
bindkey -e

# # If we want vi mode
# bindkey -v
## type jk quickly to get into command mode
# bindkey -M viins 'jk' vi-cmd-mode  
# Keep reverse search
# bindkey "^R" history-incremental-search-backward




#█▓▒░ Profile defaults

# Set the "umask" (see "man umask"):
# umask 002 # relaxed   -rwxrwxr-x
# umask 022 # cautious  -rwxr-xr-x
# umask 027 # uptight   -rwxr-x---
# umask 077 # paranoid  -rwx------
# umask 066 # bofh-like -rw-------
umask 022

# Set ulimit
ulimit -n 1048576

# automatically remove duplicates from the following
typeset -U path cdpath fpath manpath


# Set history defaults
HISTSIZE=9999999
SAVEHIST=$HISTSIZE

