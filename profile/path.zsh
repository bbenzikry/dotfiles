CURDIR="$(dirname $0)"

pathadd_tail '/usr/local/sbin'
pathadd_tail '/usr/local/bin'
pathadd_tail '/usr/sbin'
pathadd_tail '/usr/bin'
pathadd_tail '/sbin'
pathadd_tail '/bin'
pathadd_head "$GEM_HOME/bin"                          # rubygems (ruby)
pathadd_head "$PERL_LOCAL_LIB_ROOT/bin"               # cpanm (perl)
pathadd_head "$NPM_PACKAGES/bin"                      # npm
pathadd_head "$XDG_DATA_HOME/luarocks/bin"            # luarocks (lua)
pathadd_head "$PIPX_BIN_DIR"                          # pipx (python)
pathadd_tail "$GOPATH/bin"                            # go packages
pathadd_head "$GOPATH/sdk/gotip/bin"                  # golang nightly build
pathadd_tail "$GOROOT/bin"                            # go binaries
pathadd_head "$NIMBLE_DIR/bin"                        # nim packages
pathadd_head "$STACK_ROOT/bin"                        # stack (haskell)
pathadd_head "$OPAM_SWITCH_PREFIX/bin"                # opam
pathadd_head "$CARGO_HOME/bin"                        # cargo (rust)
pathadd_head "$HOME/.local/sbin"                      # local sbin
pathadd_tail "$HOME/.local/bin"                       # We add this last as we want venv and ASDF precedence over installed binaries. 
pathadd_head "$EXEC_DIR/bin"                          # exec dir

# If we want to directly add binaries from --user folder of the system installation. 
command -v python3 >/dev/null 2>&1 &&  pathadd_tail "$HOME/Library/Python/$(python3 -c 'import sys; print(str(sys.version_info[0])+"."+str(sys.version_info[1]))')/bin"