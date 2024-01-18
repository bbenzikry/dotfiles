#!/usr/bin/env zsh
# Test how this works with ASDF
export GEM_HOME="${XDG_DATA_HOME}/gem"
export IRBRC="$XDG_CONFIG_HOME/ruby/irbrc"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export PRYRC="$XDG_CONFIG_HOME/ruby/pryrc"
# Used for selection of ruby build with ASDF 
# export ASDF_RUBY_BUILD_VERSION="master"