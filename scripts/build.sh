#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

echo "[*] Generating wordlists..."

if [[ -x generators/idor_generator.py ]]; then
    python3 generators/idor_generator.py
fi

echo "[*] Cleaning wordlists..."

while IFS= read -r -d '' file; do
    temp_file="$(mktemp)"

    sed 's/\r$//' "$file" |
        sed 's/^[[:space:]]*//;s/[[:space:]]*$//' |
        grep -v '^[[:space:]]*$' |
        LC_ALL=C sort -u > "$temp_file"

    mv "$temp_file" "$file"
done < <(find wordlists -type f -name '*.txt' -print0)

echo "[*] Running quality checks..."
./scripts/check.sh

echo "[*] Statistics..."
./scripts/stats.sh

echo "[+] Build completed."
