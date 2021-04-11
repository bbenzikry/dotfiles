# just inner closure so we don't pollute env with DOTNET_ASDF_PLUGIN_DIR
(){
local DOTNET_ASDF_PLUGIN_DIR="$ASDF_DATA_DIR/plugins/dotnet-core"
if [[ -d "$DOTNET_ASDF_PLUGIN_DIR" ]] then
    export DOTNET_ROOT=$(asdf where dotnet-core)
    source "$DOTNET_ASDF_PLUGIN_DIR/set-dotnet-home.zsh"
fi
}

# Currently dotnet does not support XDG ( https://github.com/dotnet/sdk/issues/10390 )
DOTNET_TOOLS_DIR="$HOME/.dotnet"