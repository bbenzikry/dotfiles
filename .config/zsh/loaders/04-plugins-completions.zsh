#                 ██
#                ░██
#  ██████  ██████░██
# ░░░░██  ██░░░░ ░██████
#    ██  ░░█████ ░██░░░██
#   ██    ░░░░░██░██  ░██
#  ██████ ██████ ░██  ░██
# ░░░░░░ ░░░░░░  ░░   ░░


#█▓▒░ completion styling

zstyle ':completion:*:descriptions' format '[%d]'
# zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' verbose yes
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache on
# do not include pwd after ../
zstyle ':completion:*' ignore-parents parent pwd
# Hide nonexistant matches, speeds up completion a bit
zstyle ':completion:*' accept-exact '*(N)'
# divide man pages by sections
zstyle ':completion:*:manuals' separate-sections true


# zsh-autocomplete
zstyle ':autocomplete:*' min-input 3
zstyle ':autocomplete:tab:*' fzf-completion yes


# fzf-tab
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'   # Space as accept
zstyle ':fzf-tab:*' print-query ctrl-c        # Use input as result when ctrl-c
# zstyle ':fzf-tab:*' accept-line enter         # Accept selected entry on enter
zstyle ':fzf-tab:*' prefix ''                 # No dot prefix
zstyle ':fzf-tab:*' single-group color header # Show header for single groups
zstyle ':fzf-tab:complete:(cd|ls|exa):*' fzf-preview  '[[ -d $realpath ]] && exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:(cd|ls|exa):argument-rest' fzf-flags --preview-window=right:50%:wrap


# zstyle ':fzf-tab:complete:((micro|cp|rm):argument-rest|kate:*)' fzf-preview 'bat --color=always -- $realpath 2>/dev/null || ls --color=always -- $realpath'
# zstyle ':fzf-tab:complete:micro:argument-rest' fzf-flags --preview-window=right:65%

# TODO: change preview to nnn based preview or add support for iTerm protocol in fzf ( when I have time )
# example wanted for fzf in preview is: viu -- $realpath 2>/dev/null || 
zstyle ':fzf-tab:complete:((cat|bat|nano|nvim|vim|cp|rm):argument-rest|vscode-insiders:*)' fzf-preview 'bat --color=always -- $realpath 2>/dev/null || ls --color=always -- $realpath'
zstyle ':fzf-tab:complete:nano:argument-rest' fzf-flags --preview-window=right:65%

# zstyle ':fzf-tab:complete:updatelocal:argument-rest' fzf-preview "git --git-dir=$UPDATELOCAL_GITDIR/\${word}/.git log --color --date=short --pretty=format:'%Cgreen%cd %h %Creset%s %Cred%d%Creset ||%b' ..FETCH_HEAD 2>/dev/null"
# zstyle ':fzf-tab:complete:updatelocal:argument-rest' fzf-flags --preview-window=down:5:wrap
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

#█▓▒░ Plugins and completions seperated by loading order

######################
#   Trigger block    #
######################

# TODO: kubectl one is problematic if we change versions
zt light-mode for \
    trigger-load'!conda' as"completion" esc/conda-zsh-completion \
    has"gsed" trigger-load'!code-insiders' atclone"gsed -i -e 's/@@APPNAME@@/code-insiders/' _code-insiders" as"completion" mv'_code* -> _code-insiders' https://github.com/microsoft/vscode/blob/main/resources/completions/zsh/_code \
    trigger-load'!x' \
        OMZ::plugins/extract \
    trigger-load'!man' \
        ael-code/zsh-colored-man-pages \
    trigger-load'!ga;!grh;!grb;!glo;!gd;!gcf;!gclean;!gss;!gcp;!gcb' \
        wfxr/forgit \
    trigger-load'!zshz' blockf \
        agkozak/zsh-z \
    trigger-load'!updatelocal' blockf compile'f*/*~*.zwc' \
        NICHOLAS85/updatelocal \
    trigger-load'!zhooks' \
        agkozak/zhooks \
    trigger-load'!gcomp' blockf \
    atclone'command rm -rf lib/*;git ls-files -z lib/ |xargs -0 git update-index --skip-worktree' \
    submods'RobSis/zsh-completion-generator -> lib/zsh-completion-generator; nevesnunes/sh-manpage-completions -> lib/sh-manpage-completions' \
    atload' gcomp(){gencomp "${@}" && zinit creinstall -q ${ZINIT[SNIPPETS_DIR]}/config 1>/dev/null}' \
         Aloxaf/gencomp


# local completions
zt_completion 0a blockf
zinit snippet "${ASDF_DIR}/completions/_asdf"


# Generated completions
zt 0a light-mode for \
has"kubectl" is-snippet id-as"kubectl_completion" atclone"kubectl completion zsh > _kubectl && kubectl completion zsh | sed 's/kubectl/k/g' > _k" /dev/null


##################
# Wait'0a' block #
##################

zt 0a light-mode for \
        OMZP::sudo/sudo.plugin.zsh \
        OMZP::command-not-found/command-not-found.plugin.zsh \
    atload'zstyle ":completion:*" special-dirs false' \
        OMZL::completion.zsh \
    as'completion' atpull'zinit cclear' blockf \
        zsh-users/zsh-completions \
    as'completion' nocompile mv'*.zsh -> _git' reset \
        felipec/git-completion \
    ver'master' atload'_zsh_autosuggest_start' \
        zsh-users/zsh-autosuggestions \
    as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" tj/git-extras \
    id-as"direnv_completion" as'completion' atclone"direnv complete zsh > _direnv" atpull"%atclone" run-atpull zdharma/null



##################
# Wait'0b' block #
##################

    # If we want LS colors instead of default zsh snazzy.
    # pack'no-dir-color-swap' atload"zstyle ':completion:*' list-colors \${(s.:.)LS_COLORS}" \
    #     trapd00r/LS_COLORS \
        # 



zt 0b light-mode reset nocompile'!' for \
    atload'ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(__fz_zsh_completion)' \
        changyuheng/fz \
    atload'ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(autopair-insert)' \
        hlissner/zsh-autopair \
        bbenzikry/per-directory-history \
    compile'h*' \
        zdharma/history-search-multi-word \
    blockf nocompletions compile'functions/*~*.zwc' \
        marlonrichert/zsh-edit \
    atinit'zicompinit_fast; zicdreplay' atload'FAST_HIGHLIGHT[chroma-man]=' \
    atclone'(){local f;cd -q →*;for f (*~*.zwc){zcompile -Uz -- ${f}};}' \
    compile'.*fast*~*.zwc' nocompletions atpull'%atclone' patch"${ZINIT_PATCHES}/%PLUGIN%.patch" \
        zdharma/fast-syntax-highlighting

zt 0b light-mode for \
    blockf compile'lib/*f*~*.zwc' \
        Aloxaf/fzf-tab \
    autoload'#manydots-magic' \
        knu/zsh-manydots-magic \
        RobSis/zsh-reentry-hook \
    MichaelAquilina/zsh-you-should-use \
    pick'src/bash.command-not-found' \
    hkbakke/bash-insulter \
    atload'bindkey "^[[A" history-substring-search-up; bindkey "^[[B"  history-substring-search-down' \
        zsh-users/zsh-history-substring-search \
    wakeful/zsh-packer


# Snippet completions
zt 0b as"completion" for \
    https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker \
    mv'zsh_tealdeer -> _tldr' https://github.com/dbrgn/tealdeer/blob/master/zsh_tealdeer \
    https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/rust/_rust \
    https://github.com/rust-lang/cargo/blob/master/src/etc/_cargo \
    https://github.com/x-motemen/ghq/blob/master/misc/zsh/_ghq \
    mv'zsh -> _coursier' https://github.com/coursier/coursier/blob/master/modules/cli/src/main/resources/completions/zsh




# Note: 
# For linux env, use 
## atload'bindkey "${terminfo[kcuu1]}" history-substring-search-up; bindkey "${terminfo[kcud1]}"  history-substring-search-down' \
## zsh-users/zsh-history-substring-search \

# TODO: Maybe remove fzf-tab and switch to 

##################
# Wait'0c' block #
##################

# Error handling ( allows try / catch / throw with stack traces )
zt 0c light-mode as"null" atload'autoload -Uz $PWD/crash && crash register' for molovo/crash

zt 0c light-mode null for \
id-as'Cleanup' is-snippet atinit'_zsh_autosuggest_bind_widgets; eval "$(asdf exec direnv hook zsh)"' \
        /dev/null

    # TODO: marlonrichert/zsh-autocomplete \

# zinit ice from"gh-pr" as"program"


# direnv is installed via asdf plugin, to properly manage all kinds of problems with environments by shims. 
# What currently bothers me the most is the fact that conda elements shadow clear and other items :/
# See: 
# as"program" from'gh-r' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' pick"direnv" src"zhook.zsh" \
# direnv/direnv \