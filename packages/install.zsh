#!/usr/bin/env zsh
# Initial installation of all packages.
brew update && brew upgrade
CURDIR="$(dirname $0)"
for installation ($CURDIR/[0-9][0-9]*) source $installation