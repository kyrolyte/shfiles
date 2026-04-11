#!/bin/bash

# Usage: ./join_paragraphs.sh input > output
# The purpose of this script is for editing large files with irregular line breaks
# If there is a break in the middle of the paragraph, the script will rejoin them
# Content seperated by lines already, are ignored

awk '
BEGIN { ORS=""; }
{
    # If the line is blank, print newline (ends paragraph)
    if ($0 ~ /^[[:space:]]*$/) {
        print "\n\n";
    } else {
        # If not the first line of a paragraph, add a space before printing
        if (NR > 1 && prev != "") print " ";
        # Print the line, remove leading/trailing whitespace
        sub(/^[ \t]+/, "", $0);
        sub(/[ \t]+$/, "", $0);
        print $0;
    }
    prev = $0;
}
END { print "\n"; }
' "$1"
