
# Note: This is all commented as the asdf dotnet-core version doesn't work well 
# with omnisharp. We use a a brew cask for installing the SDK instead ( at 
# least for now )
# # just inner closure so we don't pollute env with DOTNET_ASDF_PLUGIN_DIR
# (){
# local DOTNET_ASDF_PLUGIN_DIR="$ASDF_DATA_DIR/plugins/dotnet-core"
# if [[ -d "$DOTNET_ASDF_PLUGIN_DIR" ]] then
#     #DOTNET_ROOT=$(asdf where dotnet-core)
#     #source "$DOTNET_ASDF_PLUGIN_DIR/set-dotnet-home.zsh"
#     #export MsBuildSDKsPath="$DOTNET_ROOT/sdk/$(asdf current dotnet-core | awk '{print $2}')/Sdks"
# fi
# }

# # Currently dotnet does not support XDG ( https://github.com/dotnet/sdk/issues/10390 )
# export DOTNET_TOOLS_DIR="$HOME/.dotnet"


# # Omnisharp home for global omnisharp configuration
export OMNISHARPHOME="$XDG_CONFIG_HOME/omnisharp"

# Nuget package cache
export NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages"