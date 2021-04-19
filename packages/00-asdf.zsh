#!/usr/bin/env zsh
# NOTE: removed lua and reverted to brew lua and luajit as the ASDF version is pretty screwed up.
# Note: Crystal is now installed via brew.
if [[ -z $ASDF_DEFAULT_TOOL_VERSIONS_FILENAME ]]; then
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/tool-versions"
fi

# Note: removed dotnet asdf, .NET 6 and above are not installed via brew
if [[ ! -e "$ASDF_DEFAULT_TOOL_VERSIONS_FILENAME" ]] || [[ $1='force' ]]; then
    asdf plugin-add java
    asdf install java openjdk-11
    asdf global java openjdk-11
    for app in "elixir" \
        "python" \
        "clojure" \
        "leiningen" \
        "babashka" \
        "haxe" \
        "ruby" \
        "julia" \
        "kotlin" \
        "graalvm" \
        "scala" \
        "dotty" \
        "sbt" \
        "golang" \
        "rust" \
        "poetry" \
        "deno" \
        "haskell" \
        "kubectl";
        do
        asdf plugin-add ${app}
        asdf install ${app} latest
        asdf global ${app} latest
    done
    asdf plugin-add nodejs
    # Check signature for release
    bash -c '${ASDF_DATA_DIR:=$HOME/.local/share/asdf}/plugins/nodejs/bin/import-release-team-keyring'
    asdf install nodejs latest

fi
