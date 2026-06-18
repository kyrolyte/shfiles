#!/usr/bin/env bash
# -------------------------------------------------------------
# process_csvs.sh
# -------------------------------------------------------------
#
#  1. Grab a list of all *.csv files in the current directory
#  2. For each file (up to 5):
#       • run: pi -p "... <file> ..."
#       • wait 5 seconds
#
# This script is ready‑to‑run – just drop it where your csvs live,
# make it executable (chmod +x process_csvs.sh) and execute it.
# -------------------------------------------------------------

set -euo pipefail      # safest shell mode

# ------------------------------------------------------------------
# 1. Create an array of all *.csv files.  If none exist, exit politely.
# ------------------------------------------------------------------
mapfile -t csv_files < <(printf '%s\n' *.csv 2>/dev/null)

if [[ ${#csv_files[@]} -eq 0 ]]; then
    echo "No *.csv files found in $(pwd). Nothing to do."
    exit 0
fi

echo "Found ${#csv_files[@]} CSV file(s):"
printf '  %s\n' "${csv_files[@]}"

# ------------------------------------------------------------------
# 2. Process each file (up to a maximum of 10)
# ------------------------------------------------------------------
max_files=10          # <-- Set your desired limit here
counter=0            # <-- Initialize counter

for csv in "${csv_files[@]}"; do
    # Check if we've reached the limit
    if (( counter >= max_files )); then
        echo "Reached maximum file limit ($max_files). Skipping remaining files."
        break      # Exit the loop early
    fi

    counter=$((counter + 1))   # Increment counter before processing

    echo
    echo "=== Processing [$counter/$max_files] '$csv' ==="

    # 3. Run the pi command
    pi -p "Read the $csv file. Apply the steps in /path/to/STEPS.md for the related file."

    # 4. Wait 5 seconds before the next iteration
    sleep 5
done

echo
if (( counter >= max_files )); then
    echo "Processed up to $max_files files (limit reached)."
else
    echo "All CSV files have been processed."
fi

