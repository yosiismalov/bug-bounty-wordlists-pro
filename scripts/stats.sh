#!/usr/bin/env bash

set -euo pipefail

echo "Bug Bounty Wordlists Pro statistics"
echo "==================================="

total_files=0
total_lines=0

while IFS= read -r -d '' file; do
    lines=$(grep -cv '^[[:space:]]*$' "$file" || true)
    printf "%-55s %6d entries\n" "$file" "$lines"
    total_files=$((total_files + 1))
    total_lines=$((total_lines + lines))
done < <(find wordlists -type f -name '*.txt' -print0 | sort -z)

echo "==================================="
echo "Wordlist files: $total_files"
echo "Total entries:  $total_lines"
