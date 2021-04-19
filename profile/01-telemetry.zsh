#!/usr/bin/env zsh
# ============================================================================
# Make sure we remove telemtry from all kinds of tools
# ============================================================================

# proposal
export DO_NOT_TRACK=1 # https://consoledonottrack.com/

# telepresence (https://github.com/telepresenceio/telepresence)
export SCOUT_DISABLE=1

# dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT="true"
# brew
export HOMEBREW_NO_ANALYTICS=1

# azure
export AZURE_CORE_COLLECT_TELEMETRY=0

# aws
export SAM_CLI_TELEMETRY=0

# gatsby
export GATSBY_TELEMETRY_DISABLED=1

# hasura
export HASURA_GRAPHQL_ENABLE_TELEMETRY="false"

export STNOUPGRADE=1

# stripe
export STRIPE_TELEMETRY_OPTOUT=1
export STRIPE_CLI_TELEMETRY_OPTOUT=1

# vagrant
export VAGRANT_CHECKPOINT_DISABLE=1

# powershell
export POWERSHELL_TELEMETRY_OPTOUT=1

# nextjs
export NEXT_TELEMETRY_DISABLED=1

# AutomatedLab
# https://github.com/AutomatedLab/AutomatedLab
export AUTOMATEDLAB_TELEMETRY_OPTOUT='1'

# terraform, packer, cdk, weave
export CHECKPOINT_DISABLE=1

# GCloud
if command -v gcloud >/dev/null 2>&1 ; then
    gcloud config set disable_usage_reporting true >/dev/null 2>&1
fi

# Netlify
if command -v 'netlify' >/dev/null 2>&1
then
  'netlify' --telemetry-disable >/dev/null 2>&1
fi