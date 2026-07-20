#!/usr/bin/env bash

set -e

echo "[*] Cleaning wordlists..."

find wordlists -type f -name "*.txt" | while read file
do
    sed -i 's/\r//g' "$file"
    sed -i '/^$/d' "$file"
    sort -fu "$file" -o "$file"
done

echo "[*] Statistics"
./scripts/stats.sh

echo "[*] Build completed."
