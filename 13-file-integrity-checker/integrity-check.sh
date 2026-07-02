#!/bin/bash

HASH_FILE="$HOME/.integrity_hashes"
ACTION=$1
TARGET=$2

if [ -z "$ACTION" ] || [ -z "$TARGET" ]; then
    echo "Usage: $0 <init|check|update> <file-or-directory>"
    exit 1
fi

compute_hashes() {
    local target=$1
    if [ -f "$target" ]; then
        sha256sum "$target"
    elif [ -d "$target" ]; then
        find "$target" -type f | sort | xargs sha256sum
    else
        echo "Error: '$target' is not a valid file or directory."
        exit 1
    fi
}

case $ACTION in
    init)
        echo "Initializing hashes for '$TARGET'..."
        compute_hashes "$TARGET" > "$HASH_FILE"
        echo "Hashes stored successfully in $HASH_FILE"
        ;;

    check)
        if [ ! -f "$HASH_FILE" ]; then
            echo "Error: No hash file found. Run 'init' first."
            exit 1
        fi

        echo "Checking integrity of '$TARGET'..."
        CURRENT=$(compute_hashes "$TARGET")
        STORED=$(grep "$TARGET" "$HASH_FILE")

        if [ -z "$STORED" ]; then
            echo "Status: Not found in hash store. Run 'init' to register this file."
            exit 1
        fi

        if [ "$CURRENT" = "$STORED" ]; then
            echo "Status: Unmodified"
        else
            echo "Status: Modified (Hash mismatch) — possible tampering detected!"
            echo ""
            echo "Stored hash:"
            echo "$STORED"
            echo ""
            echo "Current hash:"
            echo "$CURRENT"
        fi
        ;;

    update)
        if [ ! -f "$HASH_FILE" ]; then
            echo "Error: No hash file found. Run 'init' first."
            exit 1
        fi

        echo "Updating hash for '$TARGET'..."
        NEW_HASH=$(compute_hashes "$TARGET")

        # Remove old entry and add new one
        grep -v "$TARGET" "$HASH_FILE" > "$HASH_FILE.tmp"
        echo "$NEW_HASH" >> "$HASH_FILE.tmp"
        mv "$HASH_FILE.tmp" "$HASH_FILE"

        echo "Hash updated successfully."
        ;;

    *)
        echo "Error: Unknown action '$ACTION'. Use init, check, or update."
        exit 1
        ;;
esac
