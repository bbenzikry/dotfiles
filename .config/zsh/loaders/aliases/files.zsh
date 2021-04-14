alias unquarantine="xattr -dr com.apple.quarantine"

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
