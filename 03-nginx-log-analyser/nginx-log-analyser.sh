#!/bin/bash

# Usage: ./nginx-log-analyser.sh <log-file>

if [ -z "$1" ]; then
    echo "Usage: $0 <log-file>"
    exit 1
fi

LOG_FILE="$1"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' not found."
    exit 1
fi

echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | awk '{print $2 " - " $1 " requests"}'

echo -e "\nTop 5 most requested paths:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | awk '{print $2 " - " $1 " requests"}'

echo -e "\nTop 5 response status codes:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | awk '{print $2 " - " $1 " requests"}'

echo -e "\nTop 5 user agents:"
awk -F'"' '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | awk '{count=$1; $1=""; print $0 " - " count " requests"}'
