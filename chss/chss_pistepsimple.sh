#!/usr/bin/env bash
set -euo pipefail

mapfile -t csv_files < <(printf '%s\n' *.csv 2>/dev/null)

if [[ ${#csv_files[@]} -eq 0 ]]; then
    echo "No *.csv files found in $(pwd). Nothing to do."
    exit 0
fi

echo "Found ${#csv_files[@]} CSV file(s):"
printf '  %s\n' "${csv_files[@]}"

for csv in "${csv_files[@]}"; do
    echo
    echo "=== '$csv' ==="
    pi -p "Read the $csv file. For each row, find the string under Match column in the markdown file under the File column using the Line and Span columns to determine location. Read the value under the Context column to determine how the string is used. Update the string in the file according to the following criteria:
      - If the string is a Roman numeral, especially in regards to title (i.e. Charles II), leave it as-is
      - In all other scenarios, make the string lowercase.
    "
    echo
    echo "Waiting for next round..."
    sleep 30
done

echo
echo "All CSV files have been processed."

