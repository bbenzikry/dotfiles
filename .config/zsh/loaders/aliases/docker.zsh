# docker & k8s
alias dkillall='docker kill $(docker ps -a -q)'
alias drmall='docker kill $(docker ps -a -q) >/dev/null 2>&1;docker rm $(docker ps -a -q)'
alias drmiall='docker rmi $(docker images -a -q)'
alias lzd="lazydocker"
alias kubefwd='sudo -E kubefwd'
alias k='kubectl'


# TODO: shortcuts for wireshark debugging of containers