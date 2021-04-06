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
source ~/.zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# A binary Zsh module which transparently and automatically compiles sourced scripts
module_path+=( "${HOME}/.zinit/bin/zmodules/Src" )
zmodload zdharma/zplugin &>/dev/null

# zinit annexes (https://zdharma.org/zinit/wiki/Annexes/) 
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node \
    zinit-zsh/z-a-submods \
    NICHOLAS85/z-a-linkman \
    NICHOLAS85/z-a-linkbin

# load local zinit configuration (see: https://github.com/NICHOLAS85/dotfiles )
zt light-mode blockf id-as for \
        $HOME/.zinit/snippets/config
    
# TODO: Update zinit if needed
# zinit self-update --quiet

