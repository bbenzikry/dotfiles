# Autoload personal functions
fpath=("${0:h}/functions" "${fpath[@]}")
autoload -Uz $fpath[1]/*(.:t)
# ZINIT_PATCHES="${0:h}/patches"