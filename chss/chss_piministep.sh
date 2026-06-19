#!/usr/bin/env bash
set -euo pipefail

mapfile -t csv_files < <(printf '%s\n' *.csv 2>/dev/null)

if [[ ${#csv_files[@]} -eq 0 ]]; then
    echo "No *.csv files found in $(pwd). Nothing to do."
    exit 0
fi

echo "Found ${#csv_files[@]} CSV file(s):"
printf '  %s\n' "${csv_files[@]}"

max_files=20
counter=0

for csv in "${csv_files[@]}"; do
    echo
    echo "=== '$csv' ==="
    pi -p "Read the $csv file and execute the steps in TASK.md"
    echo
    echo "Waiting for next round..."
    sleep 120
done

echo
if (( counter >= max_files )); then
    echo "Processed up to $max_files files (limit reached)."
else
    echo "All CSV files have been processed."
fi

