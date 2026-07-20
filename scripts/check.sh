#!/usr/bin/env bash

echo "Checking duplicates..."

find wordlists -type f -name "*.txt" | while read file
do
    total=$(wc -l < "$file")
    unique=$(sort "$file" | uniq | wc -l)

    if [ "$total" != "$unique" ]; then
        echo "[WARNING] $file has duplicates"
    else
        echo "[OK] $file"
    fi
done
