#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

errors=0
files=0

echo "Quality checks"
echo "=============="

while IFS= read -r -d '' file; do
    files=$((files + 1))
    file_errors=0

    total="$(wc -l < "$file")"
    unique="$(LC_ALL=C sort -u "$file" | wc -l)"

    if [[ "$total" -eq 0 ]]; then
        echo "[ERROR] Empty file: $file"
        file_errors=$((file_errors + 1))
    fi

    if [[ "$total" -ne "$unique" ]]; then
        echo "[ERROR] Duplicate entries: $file"
        file_errors=$((file_errors + 1))
    fi

    if grep -q '^[[:space:]]*$' "$file"; then
        echo "[ERROR] Blank lines: $file"
        file_errors=$((file_errors + 1))
    fi

    if grep -qE '^[[:space:]]|[[:space:]]$' "$file"; then
        echo "[ERROR] Leading or trailing whitespace: $file"
        file_errors=$((file_errors + 1))
    fi

    if [[ "$file_errors" -eq 0 ]]; then
        echo "[OK] $file ($total entries)"
    else
        errors=$((errors + file_errors))
    fi
done < <(find wordlists -type f -name '*.txt' -print0 | sort -z)

echo "=============="
echo "Files checked: $files"
echo "Errors:        $errors"

if [[ "$errors" -ne 0 ]]; then
    exit 1
fi
