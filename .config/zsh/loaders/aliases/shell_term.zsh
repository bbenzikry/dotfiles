# Shell and terminal related aliases


# This is helpful when a prompt screws up autocompletion etc. and we want to easily debug the issue
defaultprompt() { 
    PROMPT="%n@%m %1~ %#"
}

alias fixterm='stty sane'
