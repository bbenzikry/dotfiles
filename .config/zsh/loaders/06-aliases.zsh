

alias ll='exa -l --icons'
alias ls='exa --icons'
alias gls='gls --color'
alias exa='exa --icons'
alias tree='exa --tree'
alias curll='curl -L'
alias fuck!='fuck --yeah' # auto-correct previous command

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias iplocal="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show network connections
# Often useful to prefix with SUDO to see more system level network usage
alias network.connections='lsof -l -i +L -R -V'
alias network.established='lsof -l -i +L -R -V | grep ESTABLISHED'
alias network.externalip='curl -s http://checkip.dyndns.org/ | sed "s/[a-zA-Z<>/ :]//g"'
alias network.internalip="ifconfig en0 | egrep -o '([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)'"
# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
# git
alias g=git
alias gpull='git pull; git submodule update --init --recursive --force --remote'

# pash
alias encryptit='gpg -r $PASH_KEYID --symmetric --cipher-algo=AES256 --compress-algo none --encrypt'

# Trim new lines and copy to clipboard
alias c="tr -d '\\n' | pbcopy"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# browsers
alias firefox='open -a "Firefox Developer Edition" --args'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary'
alias incognito='open -a "Google Chrome" --args --incognito'
# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"


alias qltext='xattr -wx com.apple.FinderInfo "54 45 58 54 21 52 63 68 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00" $1'
# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"
alias dnsflush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# fix json
alias jsonfix="pbpaste | jq . | pbcopy"
alias lookbusy="cat /dev/urandom | hexdump -C | grep \"34 32\""
alias sysinfo='system_profiler SPSoftwareDataType'
# Enable aliases to be sudo’ed
alias sudo='sudo '
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"


# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Airport CLI alias
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'


# audio / volume
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume output volume 100'"


# Get known hosts formatted by SHA
alias get-known-hosts='ssh-keygen -l -f ~/.ssh/known_hosts'

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# bat instead of cat 
# shellcheck disable=SC2230
alias maccat="$(which cat)"
alias cat='bat'

alias bell='tput bel'
alias j="jobs"


alias dt="dtrace"
alias dtr="dtruss"


# docker & k8s
alias dkillall='docker kill $(docker ps -a -q)'
alias drmall='docker kill $(docker ps -a -q) >/dev/null 2>&1;docker rm $(docker ps -a -q)'
alias drmiall='docker rmi $(docker images -a -q)'
alias lzd="lazydocker"
alias kubefwd='sudo -E kubefwd'
alias k='kubectl'


# vim 
alias vim="nvim"


# du
alias du="dust"

# top = bottom
alias top='btm'

# dotfile management via bare git repo
alias dotfiles="GIT_WORK_TREE=~ GIT_DIR=~/dotfiles"
alias dotfiles_home_status="dotfiles git status ~/*(.) -u"

# git ignore
alias gi="git-ignore"

alias unquarantine="xattr -dr com.apple.quarantine"
alias bbrepl="rlwrap bb --repl"


snoop(){
    opensnoop -n $1
}

zdebug(){
    zmodload zsh/zprof 
    eval "$1"
    zprof
}

# poetry hotfixes for big sur
alias poetry_compat='SYSTEM_VERSION_COMPAT=1 poetry'
alias ipython='ptpython3'

# gdb w/ XDG 
alias gdb="gdb -n -x $XDG_CONFIG_HOME/gdb/init"
alias sigusr='kill -s SIGUSR1'

alias yabais="yabai -m window --toggle split"

LOCAL_ALIASES="$XDG_CONFIG_HOME/zsh/loaders/local/alias.zsh"
if [[ -e "$LOCAL_ALIASES" ]]; then
    source "$LOCAL_ALIASES"
fi


alias serve='python3 -m http.server'

alias fixterm='stty sane'

alias profilevim='vim-startuptime -vimpath nvim'
alias zshtrace='zsh -x 2>zsh.trace'

# This is helpful when a prompt screws up autocompletion etc. and we want to easily debug the issue
defaultprompt() { 
    PROMPT="%n@%m %1~ %#"
}




## zinit alias pollution
unalias zini zplg