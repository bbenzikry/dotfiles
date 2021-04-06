#!/bin/bash
# shellcheck disable=SC1091
set -e
source src/utils/main.sh
INSIDERS_DIR="$XDG_CONFIG_HOME/code-insiders"

print_in_green "Pre commit hook \\n"
print_in_purple "Running doctoc...\\n"
if command -v doctoc; 
then
  doctoc README.md &> /dev/null
  ok
else 
  print_warning "doctoc not found. Please install doctoc for table of contents generation."
fi
git add "*.md"
print_in_purple "Running tests...\\n"
task test
ok

command -v code-insiders &> /dev/null && print_in_purple "Persisting current VSCode insiders extensions\\n" \
&& code-insiders --list-extensions > "$INSIDERS_DIR/Codefile" && git add "$INSIDERS_DIR/Codefile" && ok


