#!/bin/bash

SEARCH_PHRASE="OldPhrase"
REPLACEMENT_PHRASE="NewPhrase"

for file in *; do
    if [ -f "$file" ]; then
        if grep -q "$SEARCH_PHRASE" "$file"; then
            sed -i "s/$SEARCH_PHRASE/$REPLACEMENT_PHRASE/g" "$file"
        fi
    fi
done

echo "Replacement process complete."

