#!/bin/bash

# Usage: ./log-archive.sh <log-directory>

if [ -z "$1" ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

LOG_DIR="$1"

if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory '$LOG_DIR' does not exist."
    exit 1
fi

ARCHIVE_DIR="./archives"
mkdir -p "$ARCHIVE_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${ARCHIVE_DIR}/${ARCHIVE_NAME}"

tar -czf "$ARCHIVE_PATH" -C "$(dirname "$LOG_DIR")" "$(basename "$LOG_DIR")"

if [ $? -eq 0 ]; then
    echo "Logs archived successfully: $ARCHIVE_PATH"
    echo "$(date): Archived $LOG_DIR -> $ARCHIVE_PATH" >> "${ARCHIVE_DIR}/archive_log.txt"
else
    echo "Error: Failed to archive logs."
    exit 1
fi
