# Zsh related aliases
zdebug(){
    zmodload zsh/zprof 
    eval "$1"
    zprof
}

alias zshtrace='zsh -x 2>zsh.trace'