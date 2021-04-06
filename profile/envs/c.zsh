#    ██████        ██
#   ██░░░░██      ██               █          █
#  ██    ░░      ██    █████      ░█         ░█
# ░██           ██    ██░░░██  █████████  █████████
# ░██          ██    ░██  ░░  ░░░░░█░░░  ░░░░░█░░░
# ░░██    ██  ██     ░██   ██     ░█         ░█
#  ░░██████  ██      ░░█████      ░          ░
#   ░░░░░░  ░░        ░░░░░


export THREADS="$(getconf _NPROCESSORS_ONLN)"
# utilize all threads on compilation. may be smart to reduce this some day.
export MAKEFLAGS="-j $THREADS"
