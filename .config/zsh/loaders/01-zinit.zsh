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

## initial source
source "${ZINIT_HOME}/zinit.zsh"
export ZINIT[ZCOMPDUMP_PATH]="${ZSH_CACHE_DIR:-${XDG_CACHE_HOME:-$HOME/.cache/zinit}}/zcompdump-${HOST/.*/}-${ZSH_VERSION}"


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


zinit light-mode blockf id-as"localconf" for \
        "$(dirname $ZINIT_HOME)/snippets/config"

# zinit annexes (https://zdharma.org/zinit/wiki/Annexes/) 
# TODO: fork all annexes
zinit light-mode for \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-readurl \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/z-a-submods \
    bbenzikry/zinit-annex-linkman \
    zdharma-continuum/zinit-annex-binary-symlink


# load local zinit configuration (see: https://github.com/NICHOLAS85/dotfiles )
# zinit light-mode blockf for \ 
#   $ZINIT_HOME/.zinit/snippets/config
    
# TODO: Update zinit if needed
# zinit self-update --quiet

