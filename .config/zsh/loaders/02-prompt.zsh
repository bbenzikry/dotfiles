#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░


#█▓▒░ Prompt

set_win_title(){
    echo -ne "\033]0; $(basename $PWD) \007"
}

chpwd_onefetch(){
    # Note: this does not work for bare repos such as this one.
    [[ -d .git ]] && onefetch
}


load_tmux(){
if which tmux 2>&1 >/dev/null; then
  if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    tmux attach -t hack || tmux new -s hack; exit
    fi
 fi
}


starship_standalone(){
 eval "$(starship init zsh)"
}

starship_tmux(){
 load_tmux
 starship_standalone
}

neofetch_start(){
    images=($XDG_CONFIG_HOME/bbenzikry/resources/images/*.(png|jpg))
    size=${#images[@]}
    index=$((1 + $RANDOM%$size))
    image=$images[$index]
    if command -v viu > /dev/null; then 
        neofetch --viu "$image"
    else 
        neofetch
    fi
    if command -v imgcat > /dev/null; then 
        gifs=($XDG_CONFIG_HOME/bbenzikry/resources/gifs/*.gif)
        size=${#gifs[@]}
        index=$((1 + $RANDOM%$size))
        gif=$gifs[$index]
        imgcat "$gif"
    fi
}



precmd_functions+=(set_win_title)

## Starship installation ( deprecated, moved to brew )
    # has"cargo" ver"master" atclone'cargo build --release' atpull'%atclone' lbin'!target/release/starship -> starship' atload'!starship_standalone' \
    # starship/starship \


#█▓▒░ Starship prompt, neofetch, hacker-quotes
zinit as"null" lucid for \
    has"starship" as"completion" id-as"starship_completions" atclone"starship completions zsh > _starship" bbenzikry/null \
    lbin'!neofetch' atload"!neofetch_start" atclone"cp neofetch.1 ${ZPFX}/man/man1" atpull'%atclone' \
    dylanaraps/neofetch

# zinit lucid for oldratlee/hacker-quotes

# zinit lucid null as"program" lbin'!' from"gh-r" for "th3Whit3Wolf/pquote"

zinit binary lucid lbin'!**/pq' from"gh-r" for \
pick"pq" atload'pq' bpick"*darwin*" "Th3Whit3Wolf/pquote"

# Note this happens post prompt
zt 0c binary lbin'!' from'gh-r' for bpick'*mac*' \
atinit'chpwd_functions+=(chpwd_onefetch)' o2sh/onefetch

# We want to load tmux but still see the image by neofetch, so load it after 
# zt 1c atload'load_tmux' for \
#     bbenzikry/null