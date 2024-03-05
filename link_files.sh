#!/bin/bash

# Check the number of input arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 SOURCE_DIR DESTINATION_DIR"
    exit 1
fi

# Read and process the source and destination directory paths from input
SOURCE_DIR="$1"
DESTINATION_DIR="$2"

# Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist: $SOURCE_DIR"
    exit 1
fi

# Check if the destination directory exists, if not, then create it
if [ ! -d "$DESTINATION_DIR" ]; then
    echo "Destination directory does not exist, creating it: $DESTINATION_DIR"
    mkdir -p "$DESTINATION_DIR"
fi

# Iterate over all items in the source directory
for entry in "$SOURCE_DIR"/*; do
    # If the item is a directory, then create a symbolic link
    if [ -d "$entry" ]; then
        # Get the base name of the directory for the link's target name
        base=$(basename "$entry")
        # Create the symbolic link
        ln -s "$entry" "$DESTINATION_DIR/$base"
        echo "Linked $entry to $DESTINATION_DIR/$base"
    fi
done

echo "All first-level directories have been linked."

