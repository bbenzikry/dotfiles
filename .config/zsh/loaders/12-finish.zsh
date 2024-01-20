#                 ██      
#                ░██      
#  ██████  ██████░██      
# ░░░░██  ██░░░░ ░██████  
#    ██  ░░█████ ░██░░░██ 
#   ██    ░░░░░██░██  ░██ 
#  ██████ ██████ ░██  ░██ 
# ░░░░░░ ░░░░░░  ░░   ░░  


_direnv_hook() {
  eval "$(direnv export zsh 2> >( egrep -v -e '^direnv: (loading|export|unloading)' ))"
};

# A shortcut for asdf managed direnv.
# direnv() { asdf exec direnv "$@"; }

# yield control back
stty echo
