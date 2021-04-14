# Get known hosts formatted by SHA
alias get-known-hosts='ssh-keygen -l -f ~/.ssh/known_hosts'

# pash
alias encryptit='gpg -r $PASH_KEYID --symmetric --cipher-algo=AES256 --compress-algo none --encrypt'
