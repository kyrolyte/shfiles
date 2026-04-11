#!/bin/bash

# Usage: ./script.sh /path/to/directory

dir="$1"

if [[ ! -d "$dir" ]]; then
  echo "Directory does not exist: $dir"
  exit 1
fi

for file in "$dir"/*; do
  # Skip if not a regular file
  [[ -f "$file" ]] || continue

  # Use sed to find lines starting with '> ' followed by some content, and append two spaces at the end
  # The regex ^> .+ means: line starts with > and a space, followed by at least one character
  # The substitution appends two spaces to the end of the line
  sed -i.bak '/^> .\+/s/$/  /' "$file"
done

echo "Done appending spaces in files inside $dir"

