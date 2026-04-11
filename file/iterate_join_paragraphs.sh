#!/bin/bash

# Usage: ./newscript.sh input_dir output_dir

set -e

INPUT_DIR="$1"
OUTPUT_DIR="$2"

if [[ -z "$INPUT_DIR" || -z "$OUTPUT_DIR" ]]; then
    echo "Usage: $0 input_dir output_dir"
    exit 1
fi

# Ensure input directory exists
if [[ ! -d "$INPUT_DIR" ]]; then
    echo "Input directory '$INPUT_DIR' does not exist."
    exit 1
fi

# Find all files in input directory
find "$INPUT_DIR" -type f | while read -r infile; do
    # Get relative path
    rel_path="${infile#$INPUT_DIR/}"
    out_file="$OUTPUT_DIR/$rel_path"
    out_dir="$(dirname "$out_file")"

    # Create output directory if it doesn't exist
    mkdir -p "$out_dir"

    # Run your join_paragraphs.sh script
    ./join_paragraphs.sh "$infile" > "$out_file"
done
