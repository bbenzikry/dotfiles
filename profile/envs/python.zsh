#!/usr/bin/env zsh
export BETTER_EXCEPTIONS=1
export PIPX_HOME="$XDG_DATA_HOME/pipx"
export PIPX_BIN_DIR="$PIPX_HOME/bin"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export IPYTHONDIR="$XDG_CONFIG_HOME/jupyter"
export PYLINTHOME="$XDG_CACHE_HOME/pylint.d"
export PYTHON_EGG_CACHE="$XDG_CACHE_HOME/python-eggs"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
# matplotlib
export MPLCONFIGDIR="$XDG_CONFIG_HOME"/matplotlib
# Note that there's no seperation of data / config in poetry.
export POETRY_HOME="$XDG_CONFIG_HOME/poetry"
# Prevent creation of .pyc files
export PYTHONDONTWRITEBYTECODE=1