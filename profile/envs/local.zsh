#!/usr/bin/env zsh
(){
local LOCALFILE="${(%):-%x}"
local LOCALDIR="$(dirname $LOCALFILE)/localprofile"
if [[ -d "$LOCALDIR" ]]; then
    for profile ($LOCALDIR/*) source $profile
fi
}