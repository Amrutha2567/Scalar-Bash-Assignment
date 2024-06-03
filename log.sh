#!/bin/bash

# Check if a log file path is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log_file_path>"
    exit 1
fi

# Check if the log file exists and is readable
if [ ! -r "$1" ]; then
    echo "Error: Log file '$1' not found or not readable."
    exit 1
fi

# Total Requests Count
total_requests=$(wc -l < "$1")

# Percentage of Successful Requests
successful_requests=$(grep -E 'HTTP/1.[01]" 2[0-9]{2}' "$1" | wc -l)
success_percentage=$(awk "BEGIN {printf \"%.2f\", ($successful_requests / $total_requests) * 100}")

# Most Active User
most_active_user=$(awk '{print $1}' "$1" | sort | uniq -c | sort -rn | head -n 1 | awk '{print $2}')

# Output
echo "Total Requests Count: $total_requests"
echo "Percentage of Successful Requests: $success_percentage%"
echo "Most Active User: $most_active_user"
