#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░


#█▓▒░ ZInit helper functions 

# from: https://github.com/zdharma/zinit-configs/blob/master/NICHOLAS85/.zshrc
# zt() : First argument is a wait time and suffix, ie "0a". Anything that doesn't match will be passed as if it were an ice mod. Default ices depth'3' and lucid
zt(){ zinit depth'3' lucid ${1/#[0-9][a-c]/wait"${1}"} "${@:2}"; }
ztnodepth(){ zinit lucid ${1/#[0-9][a-c]/wait"${1}"} "${@:2}"; }

zt_completion(){zinit ice lucid ${1/#[0-9][a-c]/wait"${1}"} as"completion" "${@:2}";  }

omz_plugin() {
  zinit ice lucid ${@:2}
  zinit snippet OMZ::plugins/$1
}

omz_lib() {
  zinit ice lucid ${@:2}
  zinit snippet OMZ::lib/$1
}

prezto_module() {
  zinit ice svn lucid $2
  zinit snippet PZT::module/$1
}

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
ZINIT_MODULE_DIR="$(dirname $ZINIT_HOME)/module/Src"

## initial source
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# A binary Zsh module which transparently and automatically compiles sourced scripts
module_path+=( "$ZINIT_MODULE_DIR" )
zmodload zdharma_continuum/zinit # &>/dev/null

_null_plug_dir=${ZINIT[PLUGINS_DIR]}/_local---null
if [[ ! -d $_null_plug_dir ]]; then
  echo "Creating zplugin 'null' plugin directory at: $_null_plug_dir"
  mkdir -p -- "$_null_plug_dir"
fi
unset _null_plug_dir

# zinit annexes (https://zdharma.org/zinit/wiki/Annexes/) 
# TODO: fork all annexes
zinit light-mode for \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-bin-gem-node \
    zdharma-continuum/z-a-submods \
    bbenzikry/z-a-linkman \
    bbenzikry/z-a-linkbin

# load local zinit configuration (see: https://github.com/NICHOLAS85/dotfiles )
# zt light-mode blockf id-as for \
#         $HOME/.zinit/snippets/config
    
# TODO: Update zinit if needed
# zinit self-update --quiet

