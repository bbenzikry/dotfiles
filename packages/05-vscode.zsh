if [ -e "$XDG_CONFIG_HOME/code-insiders/Codefile" ]; then;
    for EXT in $(cat ~/.config/code-insiders/Codefile); do 
    code-insiders --install-extension $EXT
    done
fi