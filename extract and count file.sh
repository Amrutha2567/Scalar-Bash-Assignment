#!/bin/bash

# Check if a directory is provided as an argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Assign the directory path from the argument
directory="$1"

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found."
    exit 1
fi

# Traverse the directory recursively, identify file types, count and list them
find "$directory" -type f | awk -F. '{print $NF}' | sort | uniq -c | sort -nr | awk '{printf "%-10s : %s\n", $2, $1}'
