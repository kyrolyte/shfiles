#!/bin/bash

# Usage: ./script.sh /path/to/directory

dir="$1"

if [[ ! -d "$dir" ]]; then
  echo "Directory does not exist: $dir"
  exit 1
fi

# Loop through all regular files (not directories) in the directory
for file in "$dir"/*; do
  # Skip if not a regular file
  [[ -f "$file" ]] || continue

  # Use sed to delete lines that match the pattern
  # Pattern explanation:
  # ^> {1,2}$  means line starts ^ with > followed by 1 or 2 spaces {1,2}, then end of line $
  sed -i.bak '/^> \{1,2\}$/d' "$file"
done

echo "Done processing files in $dir"

