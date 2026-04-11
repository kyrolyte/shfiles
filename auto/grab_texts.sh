#!/bin/bash

# In this script the limit is 50 however you can use any number you want
for number in {1..50}
do
  # Format number with leading zeros (e.g., 01, 02, ..., 50)
  # This is optional, if leading zeros are not needed you can use $number variable directly
  num=$(printf "%02d" $number)

  url="https://sample.org/item${num}/file${num}.txt"
  output="outputvol${num}.txt"

  echo "Downloading $url to $output"
  curl -s -o "$output" "$url"
done

echo "All downloads complete."
