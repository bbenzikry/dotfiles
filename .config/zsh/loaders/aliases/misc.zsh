alias fuck!='fuck --yeah' # auto-correct previous command

# Trim new lines and copy to clipboard
alias c="tr -d '\\n' | pbcopy"

alias qltext='xattr -wx com.apple.FinderInfo "54 45 58 54 21 52 63 68 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00" $1'

# fix json
alias jsonfix="pbpaste | jq . | pbcopy"
alias lookbusy="cat /dev/urandom | hexdump -C | grep \"34 32\""

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

alias bell='tput bel'
alias j="jobs"

alias lowercase='dd conv=lcase 2> /dev/null'
