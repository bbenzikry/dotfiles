#                 ██      
#                ░██      
#  ██████  ██████░██      
# ░░░░██  ██░░░░ ░██████  
#    ██  ░░█████ ░██░░░██ 
#   ██    ░░░░░██░██  ░██ 
#  ██████ ██████ ░██  ░██ 
# ░░░░░░ ░░░░░░  ░░   ░░  

# chpwd hooks for custom issues
# TODO: do something about this, it doesn't work as well as I'd like to
conda_zsh_hook(){
    # We do this in case the conda trigger hook(zinit) runs
    command -v conda > /dev/null 2>&1
    # This will get either the binary or the ASDF shim if available
    if command -v conda > /dev/null; 
    then
        # This is the actual output from ``conda init zsh```
        eval "$(conda shell.zsh hook 2>/dev/null)"
    fi
}

chpwd_functions+=(conda_zsh_hook)