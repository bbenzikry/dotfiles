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

#█▓▒░ Emacs bindings for the terminal itself (can't without ^A/^E)
bindkey -e
# bindkey -v


#█▓▒░ Profile defaults

# Set the "umask" (see "man umask"):
# umask 002 # relaxed   -rwxrwxr-x
# umask 022 # cautious  -rwxr-xr-x
# umask 027 # uptight   -rwxr-x---
# umask 077 # paranoid  -rwx------
# umask 066 # bofh-like -rw-------
umask 022

# Set ulimit
ulimit -n unlimited

# automatically remove duplicates from the following
typeset -U path cdpath fpath manpath

