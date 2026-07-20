#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <wordlist-file>"
    exit 1
fi

file="$1"

if [[ ! -f "$file" ]]; then
    echo "Error: file not found: $file"
    exit 1
fi

temp_file="$(mktemp)"

sed 's/\r$//' "$file" |
    sed 's/^[[:space:]]*//;s/[[:space:]]*$//' |
    grep -v '^[[:space:]]*$' |
    sort -fu > "$temp_file"

mv "$temp_file" "$file"

echo "Cleaned: $file"
echo "Unique entries: $(wc -l < "$file")"
