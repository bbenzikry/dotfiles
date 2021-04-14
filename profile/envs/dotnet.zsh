# just inner closure so we don't pollute env with DOTNET_ASDF_PLUGIN_DIR
(){
local DOTNET_ASDF_PLUGIN_DIR="$ASDF_DATA_DIR/plugins/dotnet-core"
if [[ -d "$DOTNET_ASDF_PLUGIN_DIR" ]] then
    export DOTNET_ROOT=$(asdf where dotnet-core)
    source "$DOTNET_ASDF_PLUGIN_DIR/set-dotnet-home.zsh"
    export MsBuildSDKsPath="$DOTNET_ROOT/sdk/$(asdf current dotnet-core | awk '{print $2}')/Sdks"
fi
}

# Currently dotnet does not support XDG ( https://github.com/dotnet/sdk/issues/10390 )
export DOTNET_TOOLS_DIR="$HOME/.dotnet"
# Omnisharp home for global omnisharp configuration
export OMNISHARPHOME="$XDG_CONFIG_HOME/omnisharp"


