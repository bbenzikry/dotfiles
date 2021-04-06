#!/bin/bash
# shellcheck disable=SC2086
# shellcheck disable=SC2206
set -e
set -o pipefail
set -o history -o histexpand
set -f


export SHELLCHECK_OPTS="-e SC2039 -e SC2181 \
-e SC2139 -e SC2164 -e SC2145 -e SC1117 \
-e SC1111 -e SC1091 -e SC1090 -e SC2006 \
-e SC2164 -e SC2142"


ERRORS=()

FILES=$(find ./src | xargs realpath)

for f in $FILES; do
	if file "$f" | grep --quiet shell; then
		{
			shellcheck "$f" && echo "[OK]: sucessfully linted $f"
		} || {
			# add to errors
			ERRORS+=("$f")
		}
	fi
done

set +f

if [ ${#ERRORS[@]} -eq 0 ]; then
	echo "No errors, hooray"
else
	echo "These files failed shellcheck: ${ERRORS[*]}"
	exit 1
fi