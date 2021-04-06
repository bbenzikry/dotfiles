#!/usr/bin/env zsh
export NPM_PACKAGES="$XDG_DATA_HOME/npm"
# export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export npm_config_cache="${XDG_CACHE_HOME}/npm"